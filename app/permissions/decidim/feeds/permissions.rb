# frozen_string_literal: true

module Decidim
  module Feeds
    class Permissions < Decidim::DefaultPermissions
      def permissions
        return permission_action unless user

        return permission_action if feed && !feed.is_a?(Decidim::Feeds::Feed)

        case permission_action.subject
        when :feed
          case permission_action.action
            when :read
              allow! if user.present?
            when :create
              allow! if user.present? # TODO: maybe add a max number of feeds per user
            when :update
              allow! if can_update?
            when :list
              allow! if user.present?
            end
        when :feed_list
          case permission_action.action
            when :read
              allow! if user.admin?
            end
        when :participatory_space
          case permission_action.action
            when :read
              allow! if user.present?
            end
        when :component
          case permission_action.action
            when :read
              allow! if user.present?
            end
        end

        org_admin_action?
        feed_admin_action?

        permission_action
      end

      private

      def feed
        @feed ||= context.fetch(:current_participatory_space, nil) || context.fetch(:feed, nil)
      end

      def can_access?
        user.present?
      end

      def can_update?
        # TODO: allow feed admins to update
        user.admin? || user == resource.created_by
      end

      def org_admin_action?
        return unless user.admin?

        is_allowed = [
          :attachment,
          :attachment_collection,
          :component,
          :feed,
          :feed_user_role,
          :feed_member,
        ].include?(permission_action.subject)
        allow! if is_allowed
      end

      # Process admins can perform everything *inside* that feed.
      def feed_admin_action?
        return if user.admin?
        return unless can_manage_feed?(role: :admin)

        is_allowed = [
          :attachment,
          :attachment_collection,
          :component,
          :feed,
          :feed_user_role,
          :feed_member
        ].include?(permission_action.subject)
        allow! if is_allowed
      end

      # Whether the user can manage the given feed or not.
      def can_manage_feed?(role: :any)
        return unless user
        return unless feed

        feeds_with_role_privileges(role).include? feed
      end

      # Returns a collection of feeds where the given user has the
      # specific role privilege.
      def feeds_with_role_privileges(role)
        if role == :admin
          feed_admin_allowed_feeds
        else
          Decidim::Feeds::FeedsWithUserRole.for(user, role)
        end
      end

      def feed_admin_allowed_feeds
        @feed_admin_allowed ||= begin
          feeds = FeedsWithUserRole.for(user, :admin).where(id: feed.id)

          Decidim::Feeds::Feed.where(id: feeds)
        end
      end
    end
  end
end
