# frozen_string_literal: true

module Decidim
  module Feeds
    # Custom helpers used in posts views
    module PostsHelper
      include Decidim::ApplicationHelper
      include Decidim::TranslationsHelper
      include Decidim::ResourceHelper

    end
  end
end