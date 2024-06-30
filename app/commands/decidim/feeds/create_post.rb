# frozen_string_literal: true

module Decidim
  module Feeds
    # This command is executed when a participant or user group creates a Meeting from the public
    # views.
    class CreatePost < Decidim::Command
      # include CurrentLocale
      include ::Decidim::MultipleAttachmentsMethods

      def initialize(form)
        @form = form
      end

      def call
        return broadcast(:invalid) if form.invalid?

        if process_attachments?
          build_attachments
          return broadcast(:invalid) if attachments_invalid?
        end

        with_events(with_transaction: true) do
          create_post
          # create_attachments(weight: first_attachment_weight) if process_attachments?
          create_attachments if process_attachments?
        end

        # create_follow_form_resource(form.current_user)
        #send_notification

        broadcast(:ok, post)
      end

      private

      attr_reader :post, :form, :attachment

      def event_arguments
        {
          resource: post,
          extra: {
            event_author: form.current_user,
            locale:
          }
        }
      end

      def create_post
        # parsed_title = Decidim::ContentProcessor.parse_with_processor(:hashtag, form.title, current_organization: form.current_organization).rewrite
        # parsed_description = Decidim::ContentProcessor.parse(form.description, current_organization: form.current_organization).rewrite

        params = {
          category: form.category,
          enable_comments: form.enable_comments,
          body: { I18n.locale => form.body },
          author: form.current_user,
          component: form.current_component
        }

        @post = Decidim.traceability.create!(
          Post,
          form.current_user,
          params,
          visibility: "public-only"
        )

        @attached_to = @post

        # Decidim.traceability.perform_action!(:publish, meeting, form.current_user, visibility: "all") do
        #   meeting.publish!
        # end
      end

      # TODO: Finish this method
      # def send_notification
      #   Decidim::EventsManager.publish(
      #     event: "decidim.events.feeds.post_created",
      #     event_class: Decidim::Feeds::CreatePostEvent,
      #     resource: post,
      #     followers: post.participatory_space.followers,
      #     extra: {
      #       participatory_space: true,
      #     }
      #   )
      # end

      # def create_follow_form_resource(user)
      #   follow_form = Decidim::FollowForm.from_params(followable_gid: post.to_signed_global_id.to_s).with_context(current_user: user)
      #   Decidim::CreateFollow.call(follow_form, user)
      # end
      
      def first_attachment_weight
        return 1 if proposal.documents.count.zero?

        proposal.documents.count
      end
    end
  end
end
