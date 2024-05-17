# frozen_string_literal: true

module Decidim
  module Feeds
    module ContentBlocks
      class FeedsCell < Decidim::ViewModel
        include Cell::ViewModel::Partial

        def all_categories
          return if @all_categories.present?

          @category_ids ||= Decidim::Category.pluck(:id, :decidim_participatory_space_type, :decidim_participatory_space_id).select do |category|
            _id, space_type, space_id = category
            space = space_type.constantize.find(space_id)
            space.organization == current_organization
          end.map(&:first)

          @all_categories ||= Decidim::Category.where(id: @category_ids)
        end
      end
    end
  end
end