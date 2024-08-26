# frozen_string_literal: true

module Decidim
  module Feeds
    class Permissions < Decidim::DefaultPermissions
      def permissions
        return permission_action unless user

        case permission_action.subject
        when :feed
          case permission_action.action
            when :read
              allow! if user.present?
            when :create
              allow! if user.admin?
            when :update
              allow! if user.admin?
            when :list
              allow! if user.admin?
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

        permission_action
      end

      private

      def can_access?
        user.present?
      end
    end
  end
end
