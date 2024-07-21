# frozen_string_literal: true

# require_dependency "decidim/feeds/application_controller"

module Decidim
  module Feeds
    class PostsController < Decidim::Feeds::ApplicationController
      include FormFactory
      include Flaggable
      include Decidim::AttachmentsHelper

      def index
        enforce_permission_to :read, :post

        @posts = Decidim::Feeds::Post
                 .where(decidim_component_id: current_component.id)
                 .filter_category(params[:filter_post_category])
                 .order(created_at: :desc)
                 .includes(:attachments)
                 .limit(10)

        extra_context = {
          current_component: current_component,
          current_organization: current_component.organization,
          current_user:,
          current_participatory_space: participatory_space
        }
        @form = form(Decidim::Feeds::PostForm).from_params(params, extra_context)
        @meeting_form = meeting_form

        @meetings = if params[:filter_post_category].blank? || params[:filter_post_category] == 'calendar'
                meetings_component.blank? ? [] : Decidim::Meetings::Meeting.where(component: meetings_component)
              else
                []
              end

        @all_objects = (@posts + @meetings).sort_by(&:created_at).reverse
      end

      def show
        raise ActionController::RoutingError, "Not Found" unless post
      end

      def new
        @form = form(PostForm).from_params(post_creation_params)
      end

      def create
        enforce_permission_to :create, :post

        @form = form(PostForm).from_params(post_creation_params)

        CreatePost.call(@form) do
          on(:ok) do |post|
            flash[:notice] = I18n.t("posts.create.success", scope: "decidim.feeds")
            # TODO: implement javascript to create a new post without reloading the page
            # redirect_to decidim.root_path
            # redirect_to current_component_path
            redirect_to posts_path
          end

          on(:invalid) do
            flash.now[:alert] = I18n.t("posts.create.invalid", scope: "decidim.feeds")
            render action: "new"
          end
        end
      end

      private

      def post
        @post ||= Post.where(component: current_component).find_by(id: params[:id])
      end

      def post_creation_params
        #params[:post].merge(body_template: translated_proposal_body_template)
        params[:post]
      end

      def participatory_space
        @participatory_space ||= current_component.participatory_space
      end

      def meetings_component
        @meetings_component ||= participatory_space.components.find_by(manifest_name: "meetings")
      end

      def meeting_form
        form(Decidim::Meetings::MeetingForm).from_params(params)
      end
    end
  end
end