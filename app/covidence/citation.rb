require 'securerandom'
require_relative '../logging'
require_relative '../global_settings'

module Covidence
  class Citation
    include Logging
    include GlobalSettings
    OUTCOME_INCLUDED = 1
    OUTCOME_EXCLUDED = 2
    OUTCOME_UNDECIDED = 3

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
      @reviews << review
      @total_approvals += 1
      @outcome = OUTCOME_INCLUDED if @total_approvals >= GlobalSettings.citation_included_threshold
      logger.info("Outcome is now #{@outcome}")
    end
  end
end