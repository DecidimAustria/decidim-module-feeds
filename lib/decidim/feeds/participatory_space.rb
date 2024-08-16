# frozen_string_literal: true

Decidim.register_participatory_space(:feeds) do |participatory_space|
  participatory_space.icon = "media/images/decidim_feeds.svg"
  participatory_space.model_class_name = "Decidim::Feeds::Feed"
  # participatory_space.content_blocks_scope_name = "feed_homepage"

  participatory_space.participatory_spaces do |organization|
    Decidim::Feeds::OrganizationFeeds.new(organization).query
  end

  participatory_space.permissions_class_name = "Decidim::Feeds::Permissions"

  participatory_space.query_type = "Decidim::Feeds::FeedType"

  participatory_space.breadcrumb_cell = "decidim/feeds/feed_dropdown_metadata"

  participatory_space.register_resource(:feed) do |resource|
    resource.model_class_name = "Decidim::Feeds::Feed"
    resource.card = "decidim/feeds/feed"
    resource.searchable = true
  end

  participatory_space.context(:public) do |context|
    context.engine = Decidim::Feeds::Engine
    context.layout = "layouts/decidim/feed"
  end

  participatory_space.context(:admin) do |context|
    context.engine = Decidim::Feeds::AdminEngine
    context.layout = "layouts/decidim/admin/feed"
  end

  # participatory_space.exports :feeds do |export|
  #   export.collection do |feed|
  #     Decidim::Feeds::Feed.where(id: feed.id)
  #   end

  #   export.serializer Decidim::Feeds::FeedSerializer
  # end

  # participatory_space.register_on_destroy_account do |user|
  #   Decidim::AssemblyUserRole.where(user:).destroy_all
  #   Decidim::AssemblyMember.where(user:).destroy_all
  # end

  participatory_space.seeds do
    require "decidim/feeds/seeds"

    Decidim::Feeds::Seeds.new.call
  end
end
