# frozen_string_literal: true

module Decidim
  module Feeds
    # A controller that holds the logic to show Feeds in a public layout.
    class FeedsController < Decidim::Feeds::ApplicationController
      include ParticipatorySpaceContext
      # include FeedBreadcrumb
      include FormFactory

      participatory_space_layout only: :show

      include FilterResource
      include Paginable
      include HasParticipatorySpaceContentBlocks

      # helper_method :collection, :stats

      def index
        enforce_permission_to :list, :feed

        @feeds = published_feeds.query
      end

      def show
        enforce_permission_to :read, :feed, feed: current_participatory_space

        @feed = current_feed

        @posts_component = current_feed.components.find_by(manifest_name: "posts")

        if @posts_component.nil?
          flash[:alert] = I18n.t("feeds.show.posts_component_not_found", scope: "decidim.feeds")
          redirect_to feeds_path
        end

        # redirect_to decidim_feed_posts_path(current_participatory_space, posts_component) if posts_component
      end

      def new
        enforce_permission_to :create, :feed

        @form = form(FeedForm).instance
      end

      def create
        enforce_permission_to :create, :feed

        @form = form(FeedForm).from_params(params)

        CreateFeed.call(@form) do
          on(:ok) do |feed|
            flash[:notice] = I18n.t("feeds.create.success", scope: "decidim.feeds")
            redirect_to feeds_path
          end

          on(:invalid) do
            flash.now[:alert] = I18n.t("feeds.create.error", scope: "decidim.feeds")
            render :new
          end
        end
      end

      def edit
        enforce_permission_to :update, :feed, feed: current_feed

        @form = form(FeedForm).from_model(current_feed)
      end

      def update
        enforce_permission_to :update, :feed, feed: current_feed

        @form = form(FeedForm).from_params(
          feed_params,
          feed_id: current_feed.id
        )

        UpdateFeed.call(current_feed, @form) do
          on(:ok) do |feed|
            flash[:notice] = I18n.t("feeds.update.success", scope: "decidim.feeds")
            redirect_to feed
          end

          on(:invalid) do
            flash.now[:alert] = I18n.t("feeds.update.error", scope: "decidim.feeds")
            render :edit
          end
        end
      end

      private

      def collection
        @collection ||= OrganizationFeeds.new(current_user.organization).query
      end

      def current_feed
        @current_feed ||= collection.where(slug: params[:slug]).or(
          collection.where(id: params[:slug])
        ).first
      end

      def search_collection
        Feed.where(organization: current_organization)
      end

      def default_filter_params
        {
          with_any_scope: nil,
          with_any_area: nil,
          with_any_type: nil
        }
      end

      def current_participatory_space
        return unless params[:slug]

        @current_participatory_space ||= OrganizationFeeds.new(current_organization).query.where(slug: params[:slug]).or(
          OrganizationFeeds.new(current_organization).query.where(id: params[:slug])
        ).first!
      end

      def published_feeds
        @published_feeds ||= OrganizationFeeds.new(current_organization)
      end

      # def collection
      #   @collection ||= paginate(Kaminari.paginate_array(parent_feeds))
      # end

      def feed_params
        # only allow title to be updated
        title_params = current_organization.available_locales.map { |locale| "title_#{locale}" }
        permitted_params = params.require(:feed).permit(title_params)
        { id: params[:slug] }.merge(permitted_params)
      end
    end
  end
end
