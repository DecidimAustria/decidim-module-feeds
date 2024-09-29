# frozen_string_literal: true

module Decidim
  module Feeds
    module Admin
      # Controller that allows managing feeds.
      #
      class FeedsController < Decidim::Feeds::Admin::ApplicationController
        include Decidim::Admin::ParticipatorySpaceAdminBreadcrumb
        helper_method :current_feed, :current_participatory_space
        layout "decidim/admin/feeds"

        def index
          enforce_permission_to :read, :feed_list
          @feeds = collection
        end

        def new
          enforce_permission_to :create, :feed
          @form = form(FeedForm).instance
        end

        def create
          enforce_permission_to :create, :feed

          params[:created_by] = current_user
          @form = form(FeedForm).from_params(params)

          CreateFeed.call(@form) do
            on(:ok) do |feed|
              flash[:notice] = I18n.t("feeds.create.success", scope: "decidim.admin")
              redirect_to feeds_path
            end

            on(:invalid) do
              flash.now[:alert] = I18n.t("feeds.create.error", scope: "decidim.admin")
              render :new
            end
          end
        end

        def edit
          enforce_permission_to :update, :feed, feed: current_feed
          @form = form(FeedForm).from_model(current_feed)
          render layout: "decidim/admin/feed"
        end

        def update
          enforce_permission_to :update, :feed, feed: current_feed
          @form = form(FeedForm).from_params(
            feed_params,
            feed_id: current_feed.id
          )

          UpdateFeed.call(current_feed, @form) do
            on(:ok) do |feed|
              flash[:notice] = I18n.t("feeds.update.success", scope: "decidim.admin")
              redirect_to edit_feed_path(feed)
            end

            on(:invalid) do
              flash.now[:alert] = I18n.t("feeds.update.error", scope: "decidim.admin")
              render :edit, layout: "decidim/admin/feed"
            end
          end
        end

        def copy
          enforce_permission_to :create, :feed
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

        alias current_participatory_space current_feed

        def feed_params
          { id: params[:slug] }.merge(params[:feed].to_unsafe_h)
        end
      end
    end
  end
end
