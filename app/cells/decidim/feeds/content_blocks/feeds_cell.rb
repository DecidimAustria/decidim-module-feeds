# frozen_string_literal: true

module Decidim
  module Feeds
    module ContentBlocks
      class FeedsCell < Decidim::ViewModel
        include Cell::ViewModel::Partial
        def show
          # @posts = Decidim::Feeds::Post.where(organization: current_organization).order(created_at: :desc).limit(10)
          @posts = Decidim::Feeds::Post.order(created_at: :desc).limit(10)
          render :show
        end
      end
    end
  end
end