# frozen_string_literal: true

module Decidim
  module Feeds
    class PostMetaCell < Decidim::ViewModel
      include Cell::ViewModel::Partial
      include Decidim::TooltipHelper
      include Decidim::CardHelper
      include Decidim::LayoutHelper
      include Decidim::SearchesHelper
      include ::Decidim::EndorsableHelper
      include ::Decidim::FollowableHelper

      alias resource model

      def show
        render :show
      end

      def post
        model
      end
      
    end
  end
end
