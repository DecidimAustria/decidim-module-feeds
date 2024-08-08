# frozen_string_literal: true

module Decidim
  module Feeds
    class PostMetaCell < Decidim::ViewModel
      include Cell::ViewModel::Partial
      include Decidim::EndorsableHelper
      def show
        render :show
      end

      def post
        model
      end

      def edit_post_path
        Decidim::Feeds::Engine.routes.url_helpers.edit_post_path(assembly_slug: post.component.participatory_space.slug, component_id: post.component.id, id: post)
      end

      def delete_post_path
        Decidim::Feeds::Engine.routes.url_helpers.post_path(assembly_slug: post.component.participatory_space.slug, component_id: post.component.id, id: post)
      end
    end
  end
end
