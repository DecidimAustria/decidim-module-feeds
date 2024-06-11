# frozen_string_literal: true

module Decidim
  module Feeds
    module ContentBlocks
      class FeedsCell < Decidim::ViewModel
        include Cell::ViewModel::Partial
        include FormFactory

        def show
          component_id = model.settings.try(:component_id)
          @posts = Decidim::Feeds::Post
                   .where(decidim_component_id: component_id)
                   .filter_category(params[:filter_post_category])
                   .order(created_at: :desc)
                   .limit(10)
          @form = form(PostForm).from_params(params)
          render :show
        end

        private

        def post_creation_params
          # params[:post].merge(body_template: translated_proposal_body_template)
          params[:post]
        end
      end
    end
  end
end
