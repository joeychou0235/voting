class VoteLog < ApplicationRecord
  # counter cache
  belongs_to :candidate, counter_cache: true
end
