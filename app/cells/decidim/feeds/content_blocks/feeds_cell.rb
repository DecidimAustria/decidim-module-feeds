# frozen_string_literal: true

module Decidim
  module Feeds
    module ContentBlocks
      class FeedsCell < Decidim::ViewModel
        include Cell::ViewModel::Partial
        include FormFactory
        def show
          # @posts = Decidim::Feeds::Post.where(organization: current_organization).order(created_at: :desc).limit(10)
          @posts = Decidim::Feeds::Post.order(created_at: :desc).limit(10)
          @form = form(PostForm).from_params(params)
          render :show
        end
        def post_creation_params
          #params[:post].merge(body_template: translated_proposal_body_template)
          params[:post]
        end
      end
    end
  end
end