# frozen_string_literal: true

module Decidim
  module Feeds
    module Admin
      # A command with all the business logic when creating a new participatory
      # feed in the system.
      class CreateFeed < Decidim::Command
        # Public: Initializes the command.
        #
        # form - A form object with the params.
        def initialize(form)
          @form = form
        end

        # Executes the command. Broadcasts these events:
        #
        # - :ok when everything is valid.
        # - :invalid if the form was not valid and we could not proceed.
        #
        # Returns nothing.
        def call
          return broadcast(:invalid) if form.invalid?

          if feed.persisted?
            # link_participatory_processes(feed)
            # Decidim::ContentBlocksCreator.new(feed).create_default!

            broadcast(:ok, feed)
          else
            # form.errors.add(:hero_image, feed.errors[:hero_image]) if feed.errors.include? :hero_image
            # form.errors.add(:banner_image, feed.errors[:banner_image]) if feed.errors.include? :banner_image
            broadcast(:invalid)
          end
        end

        private

        attr_reader :form

        def feed
          @feed ||= Decidim.traceability.create(
            Feed,
            form.current_user,
            organization: form.current_organization,
            title: form.title,
            slug: form.slug,
            created_by: form.created_by
          )
        end

        # def add_admins_as_followers(feed)
        #   feed.organization.admins.each do |admin|
        #     form = Decidim::FollowForm
        #            .from_params(followable_gid: feed.to_signed_global_id.to_s)
        #            .with_context(
        #              current_organization: feed.organization,
        #              current_user: admin
        #            )

        #     Decidim::CreateFollow.new(form, admin).call
        #   end
        # end

        # def participatory_processes(feed)
        #   @participatory_processes ||= feed.participatory_space_sibling_scope(:participatory_processes).where(id: @form.participatory_processes_ids)
        # end

        # def link_participatory_processes(feed)
        #   feed.link_participatory_space_resources(participatory_processes(feed), "included_participatory_processes")
        # end
      end
    end
  end
end