# frozen_string_literal: true

module Decidim
  module Feeds
    # Exposes the meeting resource so users can view them
    class MeetingsController < Decidim::Feeds::ApplicationController
      # include FilterResource
      # include ComponentFilterable
      include Flaggable
      include Withdrawable
      include FormFactory
      # include Paginable

      helper Decidim::ResourceVersionsHelper
      helper Decidim::ShortLinkHelper
      include Decidim::AttachmentsHelper

      helper_method :meetings, :meeting, :registration, :search, :nav_paths, :tab_panel_items

      before_action :add_addtional_csp_directives, only: [:show]

      def new
        enforce_permission_to :create, :meeting

        @form = meeting_form.instance
      end

      def create
        enforce_permission_to :create, :meeting

        @form = meeting_form.from_params(params, current_component: meetings_component)

        Decidim::Meetings::CreateMeeting.call(@form) do
          on(:ok) do |meeting|
            flash[:notice] = I18n.t("meetings.create.success", scope: "decidim.meetings")
            redirect_to posts_path
          end

          on(:invalid) do
            flash.now[:alert] = I18n.t("meetings.create.invalid", scope: "decidim.meetings")
            rendirect_to posts_path
          end
        end
      end

      def edit
        enforce_permission_to(:update, :meeting, meeting:)

        @form = meeting_form.from_model(meeting)
      end

      def update
        enforce_permission_to(:update, :meeting, meeting:)

        @form = meeting_form.from_params(params)

        UpdateMeeting.call(@form, current_user, meeting) do
          on(:ok) do |meeting|
            flash[:notice] = I18n.t("meetings.update.success", scope: "decidim.meetings")
            redirect_to Decidim::ResourceLocatorPresenter.new(meeting).path
          end

          on(:invalid) do
            flash.now[:alert] = I18n.t("meetings.update.invalid", scope: "decidim.meetings")
            render :edit
          end
        end
      end

      def withdraw
        enforce_permission_to(:withdraw, :meeting, meeting:)

        WithdrawMeeting.call(@meeting, current_user) do
          on(:ok) do
            flash[:notice] = I18n.t("meetings.withdraw.success", scope: "decidim")
            redirect_to Decidim::ResourceLocatorPresenter.new(@meeting).path
          end
          on(:invalid) do
            flash[:alert] = I18n.t("meetings.withdraw.error", scope: "decidim")
            redirect_to Decidim::ResourceLocatorPresenter.new(@meeting).path
          end
        end
      end

      private

      def meeting
        @meeting ||= Decidim::Meetings::Meeting.not_hidden.where(component: current_component).find_by(id: params[:id])
      end

      def nav_paths
        return {} if meeting.blank?

        { prev_path: prev_meeting, next_path: next_meeting }.compact_blank.transform_values { |meeting| meeting_path(meeting) }
      end

      def meetings
        is_past_meetings = params.dig("filter", "with_any_date")&.include?("past")
        @meetings ||= paginate(search.result.order(start_time: is_past_meetings ? :desc : :asc))
      end

      def registration
        @registration ||= meeting.registrations.find_by(user: current_user)
      end

      def search_collection
        Decidim::Meetings::Meeting.where(component: current_component).published.not_hidden.visible_for(current_user).with_availability(
          filter_params[:with_availability]
        ).includes(
          :component,
          attachments: :file_attachment
        )
      end

      def participatory_space
        @participatory_space ||= current_component.participatory_space
      end

      def meetings_component
        @meetings_component ||= participatory_space.components.find_by(manifest_name: "meetings")
      end

      def meeting_form
        form(Decidim::Meetings::MeetingForm)
      end

      def tab_panel_items
        @tab_panel_items ||= [
          {
            enabled: meeting.public_participants.any?,
            id: "participants",
            text: t("attending_participants", scope: "decidim.meetings.public_participants_list"),
            icon: "group-line",
            method: :cell,
            args: ["decidim/meetings/public_participants_list", meeting]
          },
          {
            enabled: !meeting.closed? && meeting.user_group_registrations.any?,
            id: "organizations",
            text: t("attending_organizations", scope: "decidim.meetings.public_participants_list"),
            icon: "community-line",
            method: :cell,
            args: ["decidim/meetings/attending_organizations_list", meeting]
          },
          {
            enabled: meeting.linked_resources(:proposals, "proposals_from_meeting").present?,
            id: "included_proposals",
            text: t("decidim/proposals/proposal", scope: "activerecord.models", count: 2),
            icon: resource_type_icon_key("Decidim::Proposals::Proposal"),
            method: :cell,
            args: ["decidim/linked_resources_for", meeting, { type: :proposals, link_name: "proposals_from_meeting" }]
          },
          {
            enabled: meeting.linked_resources(:results, "meetings_through_proposals").present?,
            id: "included_meetings",
            text: t("decidim/accountability/result", scope: "activerecord.models", count: 2),
            icon: resource_type_icon_key("Decidim::Accountability::Result"),
            method: :cell,
            args: ["decidim/linked_resources_for", meeting, { type: :results, link_name: "meetings_through_proposals" }]
          }
        ] + attachments_tab_panel_items(@meeting)
      end
    end
  end
end
