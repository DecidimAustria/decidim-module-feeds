# frozen_string_literal: true

module Decidim
  module Feeds
    #
    # Decorator for proposals
    #
    class PostPresenter < Decidim::ResourcePresenter
      include Rails.application.routes.mounted_helpers
      include ActionView::Helpers::UrlHelper
      include Decidim::SanitizeHelper

      # def author
      #   @author ||= if official?
      #                 Decidim::Proposals::OfficialAuthorPresenter.new
      #               else
      #                 coauthorship = coauthorships.includes(:author, :user_group).first
      #                 coauthorship.user_group&.presenter || coauthorship.author.presenter
      #               end
      # end

      def post
        __getobj__
      end

      def post_path
        Decidim::ResourceLocatorPresenter.new(post).path
      end

      # def display_mention
      #   link_to title, proposal_path
      # end

      # def id_and_title(links: false, extras: true, html_escape: false)
      #   "##{proposal.id} - #{title(links:, extras:, html_escape:)}"
      # end

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

      # def parsed_state_change(old_state, new_state)
      #   [
      #     translated_attribute(Decidim::Proposals::ProposalState.find_by(id: old_state)&.title),
      #     translated_attribute(Decidim::Proposals::ProposalState.find_by(id: new_state)&.title)
      #   ]
      # end
    end
  end
end
