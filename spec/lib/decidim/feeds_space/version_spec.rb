# frozen_string_literal: true

require "spec_helper"

module Decidim
  describe FeedsSpace do
    subject { described_class }

    it "has version" do
      expect(subject.version).to eq("0.28.0")
    end
  end
end
