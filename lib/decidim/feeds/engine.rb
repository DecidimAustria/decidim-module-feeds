# frozen_string_literal: true

require "rails"
require "decidim/core"

require "decidim/feeds/menu"

require_relative "content_blocks/content_blocks_homepage"

module Decidim
  module Feeds
    # This is the engine that runs on the public interface of feeds.
    class Engine < ::Rails::Engine
      routes do
        get "feeds/:feed_id", to: redirect { |params, _request|
          feed = Decidim::Feeds::Feed.find(params[:feed_id])
          feed ? "/feeds/#{feed.slug}" : "/404"
        }, constraints: { feed_id: /[0-9]+/ }

        get "/feeds/:feed_id/f/:component_id", to: redirect { |params, _request|
          feed = Decidim::Feeds::Feed.find(params[:feed_id])
          feed ? "/feeds/#{feed.slug}/f/#{params[:component_id]}" : "/404"
        }, constraints: { feed_id: /[0-9]+/ }

        resources :feeds, only: [:index, :show], param: :slug, path: "feeds" do
          resources :feed_members, only: :index, path: "members"
        end

        scope "/feeds/:feed_slug/f/:component_id" do
          Decidim.component_manifests.each do |manifest|
            next unless manifest.engine

            constraints CurrentComponent.new(manifest) do
              mount manifest.engine, at: "/", as: "decidim_feed_#{manifest.name}"
            end
          end
        end
      end

      isolate_namespace Decidim::Feeds

      # initializer "decidim_feeds.overrides", after: "decidim.action_controller" do
      #   config.to_prepare do
      #     Decidim::HomepageController.include(Decidim::Feeds::NeedsContentBlocksSnippets)
      #   end
      # end

      initializer "FeedsSpace.snippets" do |app|
        app.config.enable_html_header_snippets = true
      end

      initializer "FeedsSpace.add_cells_view_paths" do
        Cell::ViewModel.view_paths << File.expand_path("#{Decidim::Feeds::Engine.root}/app/cells")
        Cell::ViewModel.view_paths << File.expand_path("#{Decidim::Feeds::Engine.root}/app/views")
      end

      initializer "FeedsSpace.webpacker.assets_path" do
        Decidim.register_assets_path File.expand_path("app/packs", root)
      end

      # initialize_homepage_content_blocks

      initializer "FeedsSpace.register_icons" do
        Decidim.icons.register(name: "function-line", icon: "function-line", category: "system", description: "", engine: :feeds)
        Decidim.icons.register(name: "home-5-line", icon: "home-5-line", category: "system", description: "", engine: :feeds)
        Decidim.icons.register(name: "recycle-line", icon: "recycle-line", category: "system", description: "", engine: :feeds)
        Decidim.icons.register(name: "shake-hands-line", icon: "shake-hands-line", category: "system", description: "", engine: :feeds)
        Decidim.icons.register(name: "gallery-fill", icon: "gallery-fill", category: "system", description: "", engine: :feeds)
        Decidim.icons.register(name: "send-plane-line", icon: "send-plane-line", category: "system", description: "", engine: :feeds)
        Decidim.icons.register(name: "image-add-line", icon: "image-add-line", category: "system", description: "", engine: :feeds)
        Decidim.icons.register(name: "film-line", icon: "film-line", category: "system", description: "", engine: :feeds)
        Decidim.icons.register(name: "file-add-line", icon: "file-add-line", category: "system", description: "", engine: :feeds)
        Decidim.icons.register(name: "chat-4-line", icon: "chat-4-line", category: "communication", description: "", engine: :feeds)
        Decidim.icons.register(name: "translate", icon: "translate", category: "editor", description: "", engine: :feeds)
        Decidim.icons.register(name: "file-2-line", icon: "file-2-line", category: "editor", description: "", engine: :feeds)
        Decidim.icons.register(name: "dislike", icon: "heart-fill", description: "Dislike", category: "action", engine: :feeds)
      end

    end
  end
end
