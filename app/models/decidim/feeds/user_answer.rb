module Decidim
  module Feeds
    # The data store for a Proposal in the Decidim::Proposals component.
    class UserAnswer < Feeds::ApplicationRecord
      belongs_to :decidim_feeds_answer
      belongs_to :decidim_user
    end
  end
end
