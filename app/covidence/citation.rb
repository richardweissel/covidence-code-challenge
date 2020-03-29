require 'securerandom'
require_relative 'review'
require_relative 'review_exists_error'
require_relative '../logging'
require_relative '../global_settings'

module Covidence
  class Citation
    include Logging
    include GlobalSettings
    OUTCOME_INCLUDED = 'included'.freeze
    OUTCOME_EXCLUDED = 'excluded'.freeze
    OUTCOME_UNDECIDED = 'undecided'.freeze

    attr_reader :citation_id, :title, :authors, :abstract, :published_year, :pages, :journal, :outcome, :reviews

    def initialize(key_value_hash:)
      @citation_id = key_value_hash[:citation_id]
      @title = key_value_hash[:title]
      @authors = key_value_hash[:authors]
      @abstract = key_value_hash[:abstract]
      @published_year = key_value_hash[:published_year]
      @pages = key_value_hash[:pages]
      @journal = key_value_hash[:journal]
      @outcome = OUTCOME_UNDECIDED
      @total_approvals = 0
      @reviews = []
    end

    def ==(other)
      citation_id == other.citation_id
    end

    def add_review(review:)
      # If this reviewer has already submitted a review for this citation, return an error
      raise ReviewExistsError if been_reviewed_by?(review.reviewer)

      @reviews << review
      if review.outcome == Covidence::Review::OUTCOME_YES
        @total_approvals += 1
        @outcome = OUTCOME_INCLUDED if @total_approvals >= GlobalSettings.citation_included_review_threshold
      elsif @reviews.length > GlobalSettings.citation_minimum_reviews_for_outcome
        @outcome = OUTCOME_EXCLUDED
      end
      logger.info("Outcome is now #{@outcome}")
    end

    private

    def been_reviewed_by?(reviewer)
      @reviews.each do |review|
        return true if review.reviewer.id == reviewer.id
      end
      false
    end

  end
end