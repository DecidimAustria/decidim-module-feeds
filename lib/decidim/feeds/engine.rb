# frozen_string_literal: true

require "rails"
require "decidim/core"

require_relative "content_blocks/content_blocks_homepage"

module Decidim
  module Feeds
    # This is the engine that runs on the public interface of feeds.
    class Engine < ::Rails::Engine
      routes do
        # Add admin engine routes here
        # resources :feeds do
        #   collection do
        #     resources :exports, only: [:create]
        #   end
        # end
        # 
        # survey user answer
        # 
  
        root to: "posts#index"
        resources :posts
        resources :meetings do
          member do
            put :withdraw
          end
        end
        # get "/test" => "posts#test"
        get 'change_status', to: 'posts#change_status', as: 'change_post_status'
        get 'delete_post', to: 'posts#delete', as: 'delete_post'
        get 'user_answers', to: 'user_answers#create', as: 'user_answers'
      end

      isolate_namespace Decidim::Feeds

      # initializer "decidim_feeds.overrides", after: "decidim.action_controller" do
      #   config.to_prepare do
      #     Decidim::HomepageController.include(Decidim::Feeds::NeedsContentBlocksSnippets)
      #   end
      # end

      initializer "Feeds.snippets" do |app|
        app.config.enable_html_header_snippets = true
      end

      initializer "Feeds.add_cells_view_paths" do
        Cell::ViewModel.view_paths << File.expand_path("#{Decidim::Feeds::Engine.root}/app/cells")
        Cell::ViewModel.view_paths << File.expand_path("#{Decidim::Feeds::Engine.root}/app/views")
      end

      initializer "Feeds.webpacker.assets_path" do
        Decidim.register_assets_path File.expand_path("app/packs", root)
      end

      initialize_homepage_content_blocks

      initializer "Feeds.register_icons" do
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
