require_dependency "decidim/feeds/application_controller"

module Decidim::Feeds
  class PostsController < ApplicationController
    helper Decidim::Feeds::ApplicationHelper
    def index
      @form = form(PostForm).from_params(post_creation_params)
    end

    def new
      @form = form(PostForm).from_params(post_creation_params)
    end

    private

    def post_creation_params
      #params[:post].merge(body_template: translated_proposal_body_template)
      params[:post]
    end
  end
end
