# frozen_string_literal: true

module Decidim
  module Feeds
    class PostHvCell < Decidim::ViewModel
      include Cell::ViewModel::Partial
      def show
        render :show
      end

      def category
        model[:category]
      end
    end
  end
end