# frozen_string_literal: true

module Decidim
  module Feeds
    # Custom helpers, scoped to the feeds engine.
    #
    module ApplicationHelper
      include PaginateHelper
      include SanitizeHelper
      include Decidim::Feeds::PostsHelper
      include ::Decidim::EndorsableHelper
      include ::Decidim::FollowableHelper
      include Decidim::Comments::CommentsHelper
    end
  end
end
