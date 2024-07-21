module Decidim
  module Feeds
    class Question < Feeds::ApplicationRecord
      include Decidim::TranslatableResource
      include Decidim::TranslatableAttributes

      belongs_to :post
      has_many :answers, class_name: "Decidim::Feeds::Answer", dependent: :destroy
      accepts_nested_attributes_for :answers, allow_destroy: true

      enum question_type: { single_choice: 0, multiple_choice: 1 }

      translatable_fields :title
    end
  end
end
