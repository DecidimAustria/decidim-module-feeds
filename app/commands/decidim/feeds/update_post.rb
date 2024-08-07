module Decidim
  module Feeds
    class UpdatePost < Decidim::Command
      include ::Decidim::MultipleAttachmentsMethods

      def initialize(form, current_user, post)
        @form = form
        @current_user = current_user
        @post = post
        @attached_to = post
      end

      def call
        return broadcast(:invalid) if invalid?

        if process_attachments?
          build_attachments
          return broadcast(:invalid) if attachments_invalid?
        end

        with_events(with_transaction: true) do
          #Decidim.traceability.perform_action!("update_feeds_post", Post, form.current_user) do
          update_post
          #end
          #document_cleanup!(include_all_attachments: true)
          create_attachments if process_attachments?
        end


        broadcast(:ok, @post)
      end

      private

      attr_reader :post, :form, :current_user, :attachment

      def event_arguments
        {
          resource: @post,
          extra: {
            event_author: form.current_user,
            locale:
          }
        }
      end

      def invalid?
        form.invalid? || !@post.editable_by?(current_user)
      end

      def update_post
        @post = Decidim.traceability.update!(
          @post,
          current_user,
          attributes,
          visibility: "public-only"
        )
      end

      def attributes
        {
          category: form.category,
          body: { I18n.locale => form.body },
          enable_comments: form.enable_comments,
          highlighted: form.highlighted,
          fixed: form.fixed
        }
      end
    end
  end
end

