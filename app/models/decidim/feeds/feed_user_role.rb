# frozen_string_literal: true

module Decidim
  module Feeds
    # Defines a relation between a user and an feed, and what kind of relation
    # does the user have.
    class FeedUserRole < ApplicationRecord
      include Traceable
      include Loggable
      include ParticipatorySpaceUser

      belongs_to :feed, foreign_key: "decidim_feed_id", class_name: "Decidim::Feeds::Feed", optional: true
      alias participatory_space feed

      scope :for_space, ->(participatory_space) { where(feed: participatory_space) }

      validates :role, inclusion: { in: ParticipatorySpaceUser::ROLES }, uniqueness: { scope: [:user, :feed] }
      def target_space_association = :feed

      def self.log_presenter_class_for(_log)
        Decidim::Feeds::AdminLog::FeedUserRolePresenter
      end
    end
  end
end
