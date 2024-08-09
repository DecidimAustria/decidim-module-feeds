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
        if post.component.manifest_name == "meetings"
          Decidim::Feeds::Engine.routes.url_helpers.edit_meeting_path(assembly_slug: post.component.participatory_space.slug, component_id: 1, id: post)
        else
          Decidim::Feeds::Engine.routes.url_helpers.edit_post_path(assembly_slug: post.component.participatory_space.slug, component_id: post.component.id, id: post)
        end
      end

      def delete_post_path
        if post.component.manifest_name == "meetings"
          Decidim::Feeds::Engine.routes.url_helpers.withdraw_meeting_path(assembly_slug: post.component.participatory_space.slug, component_id: 1, id: post)
        else
          Decidim::Feeds::Engine.routes.url_helpers.post_path(assembly_slug: post.component.participatory_space.slug, component_id: post.component.id, id: post)
        end
      end

      def delete_method
        if post.component.manifest_name == "meetings"
          :put
        else
          :delete
        end
      end

      def post_editable_by?(user)
        if post.component.manifest_name == "meetings"
          post.authored_by?(user)
        else
          post.editable_by?(current_user)
        end
      end
    end
  end
end
