# frozen_string_literal: true

require "decidim/seeds"

module Decidim
  module Feeds
    class Seeds < Decidim::Seeds
      def call
        # create_content_block!

        feed = create_feed!

        seed_components_manifests!(participatory_space: current_feed)

        # Decidim::ContentBlocksCreator.new(current_feed).create_default!
      end

      # def create_content_block!
      #   Decidim::ContentBlock.create(
      #     organization:,
      #     weight: 32,
      #     scope_name: :homepage,
      #     manifest_name: :highlighted_feeds,
      #     published_at: Time.current
      #   )
      # end

      def create_feed!
        params = {
          title: Decidim::Faker::Localized.sentence(word_count: 5),
          slug: Decidim::Faker::Internet.unique.slug(words: nil, glue: "-"),
          organization:,
          created_by: "others",
        }

        Decidim.traceability.perform_action!(
          "publish",
          Decidim::Feeds::Feed,
          organization.users.first,
          visibility: "all"
        ) do
          Decidim::Feeds::Feed.create!(params)
        end
      end
    end
  end
end
