# frozen_string_literal: true

module Decidim
  module Feeds
    module Admin
      # This controller allows admins to manage posts in a participatory space.
      class PostsController < Admin::ApplicationController
        include Decidim::ApplicationHelper

        helper Feeds::ApplicationHelper
        # helper Decidim::Messaging::ConversationHelper
        # helper_method :posts, :query, :form_presenter, :post, :post_ids
        
        def index
        end

        def show
        end

        def new
          enforce_permission_to :create, :post
          # @form = form(Decidim::Feeds::Admin::PostForm).from_params(
          #   attachment: form(AttachmentForm).from_params({})
          # )
        end

        def create
          enforce_permission_to :create, :post
          @form = form(Decidim::Feeds::Admin::PostForm).from_params(params)

          Admin::CreatePost.call(@form) do
            on(:ok) do
              flash[:notice] = I18n.t("posts.create.success", scope: "decidim.feeds.admin")
              redirect_to posts_path
            end

            on(:invalid) do
              flash.now[:alert] = I18n.t("posts.create.invalid", scope: "decidim.feeds.admin")
              render action: "new"
            end
          end
        end

        def edit
          enforce_permission_to(:edit, :post, post:)
          @form = form(Admin::PostForm).from_model(post)
        end

        def update
          enforce_permission_to(:edit, :post, post:)

          @form = form(Admin::PostForm).from_params(params)

          Admin::UpdatePost.call(@form, @post) do
            on(:ok) do |_post|
              flash[:notice] = t("feeds.update.success", scope: "decidim")
              redirect_to posts_path
            end

            on(:invalid) do
              flash.now[:alert] = t("feeds.update.error", scope: "decidim")
              render :edit
            end
          end
        end

        private

        def collection
          @collection ||= Post.where(component: current_component).not_hidden.published
        end

        def posts
          @posts ||= filtered_collection
        end

        def post
          @post ||= collection.find(params[:id])
        end

        def post_ids
          @post_ids ||= params[:post_ids]
        end

        def form_presenter
          @form_presenter ||= present(@form, presenter_class: Decidim::Feeds::PostPresenter)
        end
      end
    end
  end
end
