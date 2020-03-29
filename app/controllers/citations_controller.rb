require_relative 'base_controller'
require 'json'

class CitationsController < BaseController
  get '/api/v1/citations' do
    logger.info('retrieving all citations')
    citations = review_manager.brief_citations
    JSON.generate(citations)
  end
end