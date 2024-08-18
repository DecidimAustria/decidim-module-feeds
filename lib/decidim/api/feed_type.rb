# frozen_string_literal: true

module Decidim
  module FeedsSpace
    # This type represents a Feed.
    class FeedType < Decidim::Api::Types::BaseObject
      implements Decidim::Core::ParticipatorySpaceInterface
      implements Decidim::Core::AttachableInterface
      implements Decidim::Core::ParticipatorySpaceResourceableInterface
      implements Decidim::Core::CategoriesContainerInterface

      description "A feed"

      field :id, ID, "The internal ID for this feed", null: false
      field :slug, String, "The slug of this feed", null: false
      field :created_at, Decidim::Core::DateTimeType, "The time this feed was created", null: false
      field :updated_at, Decidim::Core::DateTimeType, "The time this feed was updated", null: false
      
      field :created_by, String, "The creator of this feed", null: true
      
      # def hero_image
      #   object.attached_uploader(:hero_image).path
      # end

      # def banner_image
      #   object.attached_uploader(:banner_image).path
      # end
    end
  end
end
