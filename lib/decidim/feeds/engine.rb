# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module Feeds
    # This is the engine that runs on the public interface of feeds.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Feeds

      routes do
        # Add engine routes here
        # resources :feeds
        # root to: "feeds#index"
      end

      initializer "Feeds.webpacker.assets_path" do
        Decidim.register_assets_path File.expand_path("app/packs", root)
      end
    end
  end
end
