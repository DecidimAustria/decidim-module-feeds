# frozen_string_literal: true

module Decidim
  module FeedsSpace
    module Admin
      # A command with all the business logic when creating a new participatory
      # feed in the system.
      class UpdateFeed < Decidim::Command
        include ::Decidim::AttachmentAttributesMethods

        # Public: Initializes the command.
        #
        # feed - the Feed to update
        # form - A form object with the params.
        def initialize(feed, form)
          @feed = feed
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

          update_feed
          # link_participatory_processes(@feed)

          if @feed.valid?
            broadcast(:ok, @feed)
          else
            # form.errors.add(:hero_image, @feed.errors[:hero_image]) if @feed.errors.include? :hero_image
            # form.errors.add(:banner_image, @feed.errors[:banner_image]) if @feed.errors.include? :banner_image
            broadcast(:invalid)
          end
        end

        private

        attr_reader :form, :feed

        def update_feed
          @feed.assign_attributes(attributes)
          save_feed if @feed.valid?
        end

        def save_feed
          transaction do
            @feed.save!
            Decidim.traceability.perform_action!(:update, @feed, form.current_user) do
              @feed
            end
          end
        end

        def attributes
          {
            title: form.title,
            slug: form.slug,
            created_by: form.created_by
          }
        end

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
