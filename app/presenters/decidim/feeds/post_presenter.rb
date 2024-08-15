# frozen_string_literal: true

module Decidim
  module Feeds
    #
    # Decorator for Posts
    #
    class PostPresenter < Decidim::ResourcePresenter
      include Rails.application.routes.mounted_helpers
      include ActionView::Helpers::UrlHelper
      include Decidim::SanitizeHelper

      def post
        __getobj__
      end

      def post_path
        Decidim::ResourceLocatorPresenter.new(post).path
      end

      def body(links: false, extras: true, strip_tags: false, all_locales: false)
        return unless post

        content_handle_locale(post.body, all_locales, extras, links, strip_tags)
      end

      def editor_body(all_locales: false, extras: true)
        editor_locales(post.body, all_locales, extras:)
      end

      # def resource_manifest
      #   post.class.resource_manifest
      # end

      # private

    end
  end
end
