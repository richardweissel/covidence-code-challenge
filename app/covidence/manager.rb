require_relative './review'
require_relative './reviewer'
require_relative './citation'
require_relative '../logging'
require_relative '../data_access/data_accessor'
require_relative './citation_not_found_error'

module Covidence
  class Manager
    include Logging

    def initialize(data_accessor = nil)
      @data_accessor = data_accessor
    end

    def data_accessor
      @data_accessor ||= DataAccessor.instance
    end

    def create_review(params_hash:)
      reviewer = data_accessor.find_or_create_reviewer(params_hash[:reviewer_id])
      citation = data_accessor.find_citation(params_hash[:citation_id])
      raise Covidence::CitationNotFoundError, "Citation id #{params_hash[:citation_id]} not found" unless citation

      review = Covidence::Review.new(reviewer: reviewer, citation: citation)
      data_accessor.save_review(review)
      review
    end

    def citations
      data_accessor.citations
    end

    def brief_citations
      citations = []
      data_accessor.citations.each do |citation_id, citation|
        citations << { citation_id: citation_id, title: citation.title, published_year: citation.published_year }
      end
      citations
    end
  end
end
