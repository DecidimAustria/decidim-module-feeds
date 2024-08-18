# frozen_string_literal: true

require "decidim/faker/localized"
require "decidim/dev"

FactoryBot.define do
  sequence(:feed_slug) do |n|
    "#{Decidim::Faker::Internet.slug(words: nil, glue: "-")}-#{n}"
  end

  factory :feed, class: "Decidim::Feed" do
    title { generate_localized_title(:feed_title, skip_injection:) }
    slug { generate(:feed_slug) }
    organization
    created_by { "others" }
  end
end
