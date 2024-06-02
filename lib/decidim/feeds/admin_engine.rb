# frozen_string_literal: true

module Decidim
  module Feeds
    # This is the engine that runs on the public interface of `Feeds`.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::Feeds::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      routes do
        # Add admin engine routes here
        # resources :feeds do
        #   collection do
        #     resources :exports, only: [:create]
        #   end
        # end
        root to: "feeds#index"
      end

      def load_seed
        nil
      end
    end
  end
end
