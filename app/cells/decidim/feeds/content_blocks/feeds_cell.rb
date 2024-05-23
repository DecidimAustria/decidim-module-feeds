# frozen_string_literal: true

module Decidim
  module Feeds
    module ContentBlocks
      class FeedsCell < Decidim::ViewModel
        include Cell::ViewModel::Partial
        def show
          render :show
        end
      end
    end
  end
end