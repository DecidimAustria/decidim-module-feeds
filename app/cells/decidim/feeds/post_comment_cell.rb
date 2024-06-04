# frozen_string_literal: true

module Decidim
  module Feeds
    class PostCommentCell < Decidim::ViewModel
      include Cell::ViewModel::Partial
      def show
        render :show
      end

      def post
        model
      end

      def post_commentable
        model.enable_comments?
      end
      
    end
  end
end
