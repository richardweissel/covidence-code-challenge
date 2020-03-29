require_relative '../logging'
module Covidence
  class Reviewer
    include Logging
    attr_reader :id, :name, :reviews

    def initialize(id = 0)
      @id = id
      @reviews = []
    end

    def add_review(review:)
      @reviews << review
      logger.info("Total reviews for reviewer: #{@reviews.length}")
    end
  end
end