require 'securerandom'

module Covidence
  class Review
    OUTCOME_NO = 0
    OUTCOME_YES = 1
    attr_reader :id, :reviewer, :citation, :outcome

    def initialize(reviewer:, citation:, outcome_is_approved: false)
      @id = SecureRandom.uuid
      @reviewer = reviewer
      @citation = citation
      @outcome = outcome_is_approved ? OUTCOME_YES : OUTCOME_NO
    end
  end
end