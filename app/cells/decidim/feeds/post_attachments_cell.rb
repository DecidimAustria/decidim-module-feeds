# frozen_string_literal: true

module Decidim
  module Feeds
    class PostAttachmentsCell < Decidim::ViewModel
      include Cell::ViewModel::Partial
      def show
        render :show
      end

      def post
        model
      end
      
    end
  end
end
