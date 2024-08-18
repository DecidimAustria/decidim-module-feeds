# frozen_string_literal: true

module Decidim
  module Feeds
    module AdminLog
      # This class holds the logic to present a `Decidim::Feeds::Feed`
      # for the `AdminLog` log.
      #
      # Usage should be automatic and you should not need to call this class
      # directly, but here is an example:
      #
      #    action_log = Decidim::ActionLog.last
      #    view_helpers # => this comes from the views
      #    FeedPresenter.new(action_log, view_helpers).present
      class FeedPresenter < Decidim::Log::BasePresenter
        private

        def diff_fields_mapping
          {
            published_at: :date,
            slug: :default,
            title: :i18n,
            created_by: :string
          }
        end

        def i18n_labels_scope
          "activemodel.attributes.feed"
        end

        def action_string
          case action
          when "create", "update"
            "decidim.admin_log.feed.#{action}"
          else
            super
          end
        end

        def diff_actions
          super
        end
      end
    end
  end
end
