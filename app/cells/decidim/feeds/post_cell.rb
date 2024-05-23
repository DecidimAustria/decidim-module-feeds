# frozen_string_literal: true

module Decidim
  module Feeds
    class PostCell < Decidim::ViewModel
      include Cell::ViewModel::Partial
      def show
        render :show
      end
      
      def category
        model[:category]
      end

      def commentable
      end
    end
  end
end