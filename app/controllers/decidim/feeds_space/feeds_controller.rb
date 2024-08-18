# frozen_string_literal: true

module Decidim
  module FeedsSpace
    # A controller that holds the logic to show Feeds in a public layout.
    class FeedsController < Decidim::FeedsSpace::ApplicationController
      include ParticipatorySpaceContext
      include FeedBreadcrumb

      participatory_space_layout only: :show

      include FilterResource
      include Paginable
      include HasParticipatorySpaceContentBlocks

      # helper_method :collection, :stats

      def index
        enforce_permission_to :list, :feed

        respond_to do |format|
          format.html do
            raise ActionController::RoutingError, "Not Found" if published_feeds.none?

            render "index"
          end

          format.js do
            raise ActionController::RoutingError, "Not Found" if published_feeds.none?

            render "index"
          end

          format.json do
            render json: published_feeds.query.includes(:children).where(parent: nil).collect { |feed|
              {
                name: feed.title[I18n.locale.to_s],
                children: feed.children.collect do |child|
                  {
                    name: child.title[I18n.locale.to_s],
                    children: child.children.collect { |child_of_child| { name: child_of_child.title[I18n.locale.to_s] } }
                  }
                end
              }
            }
          end
        end
      end

      def show
        enforce_permission_to :read, :feed, feed: current_participatory_space
      end

      private

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
        @published_feeds ||= OrganizationFeeds.new(current_organization, current_user)
      end

      # def collection
      #   @collection ||= paginate(Kaminari.paginate_array(parent_feeds))
      # end

      # def stats
      #   @stats ||= FeedStatsPresenter.new(feed: current_participatory_space)
      # end

      # def feed_participatory_processes
      #   @feed_participatory_processes ||= @current_participatory_space.linked_participatory_space_resources(:participatory_processes, "included_participatory_processes")
      # end
    end
  end
end
