# frozen_string_literal: true

module Decidim
  module Feeds
    class Permissions < Decidim::DefaultPermissions
      def permissions
        return permission_action unless user

        case permission_action.subject
        when :post
          case permission_action.action
            when :create
              allow! if can_create_posts?
            when :edit
              allow! if can_update_post?
            when :read
              allow! if can_access?
            when :change_post_status
              allow! if change_post_status?
            end
        when :meeting
          case permission_action.action
            when :create
              allow! if can_create_posts?
            when :update
              allow! if can_update_meeting?
            when :withdraw
              allow! if can_withdraw_meeting?
            end
        end

        permission_action
      end

      private

      def post
        @post ||= context.fetch(:post, nil) || context.fetch(:resource, nil)
      end

      def meeting
        @meeting ||= context.fetch(:meeting, nil) || context.fetch(:resource, nil)
      end

      def can_access?
        user.present?
      end

      def can_create_posts?
        return false unless user
        # component_settings&.creation_enabled_for_participants? && public_space_or_member?
        public_space_or_member?
      end

      def can_update_post?
        post.authored_by?(user)
      end

      def change_post_status?
        participatory_space.admins.exists?(id: user.id)
      end

      def public_space_or_member?
        participatory_space = context[:current_component].participatory_space

        participatory_space.private_space? ? space_member?(participatory_space, user) : true
      end

      # Neither platform admins, nor space admins should be able to create meetings from the public side.
      def space_member?(participatory_space, user)
        return false unless user

        participatory_space.participatory_space_private_users.exists?(decidim_user_id: user.id)
      end

      def can_update_meeting?
        meeting.authored_by?(user) &&
          !meeting.closed?
      end

      def can_withdraw_meeting?
        meeting.authored_by?(user) &&
          !meeting.withdrawn? &&
          !meeting.past?
      end
    end
  end
end
