# frozen_string_literal: true

module Decidim
  module Feeds
    class PostMetaCell < Decidim::ViewModel
      include Cell::ViewModel::Partial
      include ::Devise::Controllers::Helpers
      include ::Devise::Controllers::UrlHelpers
      include Messaging::ConversationHelper
      include Decidim::FollowableHelper
      include ERB::Util

      def show
        render :show
      end

      def post
        model
      end

      property :profile_path
      property :can_be_contacted?
      property :has_tooltip?

      delegate :current_user, to: :controller, prefix: false
      
    end
  end
end
