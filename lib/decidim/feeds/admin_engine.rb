# frozen_string_literal: true

require "decidim/core"
# require "decidim/feeds/menu"

module Decidim
  module Feeds
    # This is the engine that runs on the public interface of `Feeds`.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::Feeds::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      routes do
        resources :posts
        root to: "posts#index"
      end

      def load_seed
        nil
      end
    end
  end
end
