# frozen_string_literal: true

require "decidim/core"
require "decidim/feeds_space/menu"

module Decidim
  module FeedsSpace
    # This is the engine that runs on the public interface of `Feeds`.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::FeedsSpace::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      routes do
        # Add admin engine routes here
        resources :feeds, param: :slug, except: [:show, :destroy] do
          # collection do
          #   resources :exports, only: [:create]
          # end
        end

        scope "/feeds/:feed_slug" do
          # resources :categories, except: [:show]

          resources :components do
            resource :permissions, controller: "component_permissions"
            member do
              put :publish
              put :unpublish
              get :share
            end
            #resources :exports, only: :create
            #resources :imports, only: [:new, :create] do
            #  get :example, on: :collection
            #end
            #resources :reminders, only: [:new, :create]
          end

          resources :moderations do
            member do
              put :unreport
              put :hide
              put :unhide
            end
            resources :reports, controller: "moderations/reports", only: [:index, :show]
          end
        end

        scope "/feeds/:feed_slug/components/:component_id/manage" do
          Decidim.component_manifests.each do |manifest|
            next unless manifest.admin_engine

            constraints CurrentComponent.new(manifest) do
              mount manifest.admin_engine, at: "/", as: "decidim_admin_feed_#{manifest.name}"
            end
          end
        end
      end

      def load_seed
        nil
      end

      initializer "decidim_feeds_admin.action_controller" do |app|
        app.config.to_prepare do
          ActiveSupport.on_load :action_controller do
            helper Decidim::FeedsSpace::Admin::FeedsAdminMenuHelper if respond_to?(:helper)
          end
        end
      end

      initializer "decidim_feeds_admin.menu" do
        Decidim::FeedsSpace::Menu.register_admin_menu_modules!
        Decidim::FeedsSpace::Menu.register_admin_feeds_components_menu!
        Decidim::FeedsSpace::Menu.register_admin_feed_menu!
        Decidim::FeedsSpace::Menu.register_admin_feeds_menu!
      end
    end
  end
end
