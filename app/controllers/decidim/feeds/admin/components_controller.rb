# frozen_string_literal: true

module Decidim
  module Feeds
    module Admin
      # Controller that allows managing the Feed Components in the
      # admin panel.
      #
      class ComponentsController < Decidim::Admin::ComponentsController
        include Concerns::FeedAdmin
      end
    end
  end
end
