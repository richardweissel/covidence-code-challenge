require_relative '../covidence/citation'
require_relative '../covidence/reviewer'
require_relative '../covidence/citation_not_found_error'
require_relative '../logging'
require_relative 'json_input_parser'

class DataAccessor
  include Logging
  attr_reader :citations, :reviewers

  @instance = new

  def self.instance
    @instance
  end

  def citations
    @citations ||= {}
  end

  def reviewers
    @reviewers ||= {}
  end

  def add_citation_from_hash(citation_hash:, citation_id:)
    citation_hash[:citation_id] = citation_id
    citation = Covidence::Citation.new(key_value_hash: citation_hash)
    citations[citation.citation_id] = citation
  end

  def find_citation(citation_id)
    citations[citation_id]
  end

  def find_or_create_reviewer(reviewer_id)
    reviewer = reviewers[reviewer_id]
    logger.info("Reviewer for id #{reviewer_id} is #{reviewer}")
    reviewers[reviewer_id] = Covidence::Reviewer.new(reviewer_id) if reviewer.nil?
    reviewers[reviewer_id]
  end

  def save_review(review)
    citation = review.citation
    citation.add_review(review: review)
    review.reviewer.add_review(review: review)
  end

  def initialize_database(filename:)
    citations = JsonInputParser.new.read_citations_from_input_file(filename: filename)
    logger.info("Citations: #{citations.length}")
    citations.each_with_index do |citation, idx|
      add_citation_from_hash(citation_hash: citation, citation_id: idx.to_s)
    end
    logger.info("Total citations in database: #{citations.length}")
  end

end