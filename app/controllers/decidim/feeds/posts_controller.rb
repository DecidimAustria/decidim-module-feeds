require_dependency "decidim/feeds/application_controller"

module Decidim::Feeds
  class PostsController < ApplicationController
    def index
      @form = Decidim::Feeds::Post.new
    end

    def new
      @form = Decidim::Feeds::Post.new
    end
  end
end
