# frozen_string_literal: true

module Decidim
  module Feeds
    # A command with all the business logic when a user destroys a draft proposal.
    class DestroyPost < Decidim::Command
      def initialize(post, current_user)
        @post = post
        @current_user = current_user
      end

      def call
        return broadcast(:invalid) unless @post.authored_by?(@current_user)

        @post.destroy!

        broadcast(:ok, @post)
      end
    end
  end
end
