# frozen_string_literal: true

module Decidim
  module Feeds
    class PostMetaCell < Decidim::ViewModel
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
