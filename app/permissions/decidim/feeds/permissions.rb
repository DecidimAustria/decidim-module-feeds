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
          when :update
            allow! if can_update_post?
          when :read
            allow! if can_access?
          end
        end

        permission_action
      end

      private

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

      def public_space_or_member?
        participatory_space = context[:current_component].participatory_space

        participatory_space.private_space? ? space_member?(participatory_space, user) : true
      end

      # Neither platform admins, nor space admins should be able to create meetings from the public side.
      def space_member?(participatory_space, user)
        return false unless user

        participatory_space.participatory_space_private_users.exists?(decidim_user_id: user.id)
      end
    end
  end
end
