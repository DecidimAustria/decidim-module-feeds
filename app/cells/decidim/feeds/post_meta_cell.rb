# frozen_string_literal: true

module Decidim
  module Feeds
    class PostMetaCell < Decidim::ViewModel
      include Cell::ViewModel::Partial
      include Decidim::EndorsableHelper
      def show
        render :show
      end

      def post
        model
      end

      def post_author
        if model.is_a?(Decidim::Feeds::Post)
          post.author
        elsif model.is_a?(Decidim::Meetings::Meeting)
          post.decidim_author_id
        else
          post.author
        end
      end
      
    end
  end
end
