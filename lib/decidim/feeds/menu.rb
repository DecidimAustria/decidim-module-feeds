# frozen_string_literal: true

module Decidim
  module Feeds
    class Menu
      def self.register_menu!
        Decidim.menu :menu do |menu|
          menu.add_item :feeds,
                        I18n.t("menu.feeds", scope: "decidim"),
                        decidim_feeds.feeds_path,
                        position: 2.2,
                        # if: OrganizationPublishedFeeds.new(current_organization, current_user).any?,
                        active: :inclusive
        end
      end

      def self.register_home_content_block_menu!
        Decidim.menu :home_content_block_menu do |menu|
          menu.add_item :feeds,
                        I18n.t("menu.feeds", scope: "decidim"),
                        decidim_feeds.feeds_path,
                        position: 20,
                        # if: OrganizationPublishedFeeds.new(current_organization, current_user).any?,
                        active: :inclusive
        end
      end

      def self.register_admin_menu_modules!
        Decidim.menu :admin_menu_modules do |menu|
          menu.add_item :feeds,
                        I18n.t("menu.feeds", scope: "decidim.admin"),
                        decidim_admin_feeds.feeds_path,
                        icon_name: "government-line",
                        position: 2.2,
                        active: is_active_link?(decidim_admin_feeds.feeds_path)
                        # if: allowed_to?(:enter, :space_area, space_name: :feeds)
        end
      end

      def self.register_admin_feeds_components_menu!
        Decidim.menu :admin_feeds_components_menu do |menu|
          current_participatory_space.components.each do |component|
            caption = decidim_escape_translated(component.name)
            caption += content_tag(:span, component.primary_stat, class: "component-counter") if component.primary_stat.present?

            menu.add_item [component.manifest_name, component.id].join("_"),
                          caption.html_safe,
                          manage_component_path(component),
                          active: is_active_link?(manage_component_path(component)) ||
                                  is_active_link?(decidim_admin_feeds.edit_component_path(current_participatory_space, component)) ||
                                  is_active_link?(decidim_admin_feeds.edit_component_permissions_path(current_participatory_space, component)) ||
                                  participatory_space_active_link?(component),
                          if: component.manifest.admin_engine && user_role_config.component_is_accessible?(component.manifest_name)
          end
        end
      end

      def self.register_admin_feed_menu!
        Decidim.menu :admin_feed_menu do |menu|
          menu.add_item :edit_feed,
                        I18n.t("info", scope: "decidim.admin.menu.feeds_submenu"),
                        decidim_admin_feeds.edit_feed_path(current_participatory_space),
                        position: 1,
                        icon_name: "information-line",
                        if: allowed_to?(:update, :feed, feed: current_participatory_space)

          menu.add_item :components,
                        I18n.t("components", scope: "decidim.admin.menu.feeds_submenu"),
                        decidim_admin_feeds.components_path(current_participatory_space),
                        icon_name: "tools-line",
                        active: is_active_link?(decidim_admin_feeds.components_path(current_participatory_space), ["decidim/feeds/admin/components", %w(index new edit)]),
                        if: allowed_to?(:read, :component, feed: current_participatory_space),
                        submenu: { target_menu: :admin_feeds_components_menu }
        end
      end

      def self.register_admin_feeds_menu!
        Decidim.menu :admin_feeds_menu do |menu|
          menu.add_item :feeds,
                        I18n.t("menu.feeds", scope: "decidim.admin"),
                        decidim_admin_feeds.feeds_path,
                        position: 1,
                        active: is_active_link?(decidim_admin_feeds.feeds_path),
                        icon_name: "government-line",
                        if: allowed_to?(:read, :feed_list)

          # menu.add_item :import_feed,
          #               I18n.t("actions.import_feed", scope: "decidim.admin"),
          #               decidim_admin_feeds.new_import_path,
          #               position: 2,
          #               active: is_active_link?(decidim_admin_feeds.new_import_path),
          #               icon_name: "price-tag-3-line",
          #               if: allowed_to?(:import, :feed)

          # menu.add_item :feeds_types,
          #               I18n.t("menu.feeds_types", scope: "decidim.admin"),
          #               decidim_admin_feeds.feeds_types_path,
          #               position: 3,
          #               active: is_active_link?(decidim_admin_feeds.feeds_types_path),
          #               icon_name: "government-line",
          #               if: allowed_to?(:manage, :feeds_type)
        end
      end
    end
  end
end
