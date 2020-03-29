require 'sinatra/base'
require_relative 'base_controller'
require_relative 'invalid_params_error'
require 'json'

class ReviewsController < BaseController

  post '/api/v1/reviews' do
    logger.info('creating review...')

    begin
      review = review_manager.create_review(ReviewsController.get_params(params))
      logger.info("created review #{review}")
      JSON.generate({ id: review.id, citation_outcome: review.citation.outcome, total_reviews: review.citation.reviews.length })
    rescue InvalidParamsError => e
      status 400
      JSON.generate(e)
    rescue Covidence::CitationNotFoundError => e
      status 404
      JSON.generate(e)
    rescue Exception => e
      logger.error("Error:#{e.backtrace}")
      status 500
      JSON.generate(e)
    end
  end

  def self.get_params(params)
    required_params = [params[:reviewer_id], params[:citation_id], params[:outcome]]
    raise InvalidParamsError, 'Invalid Params' unless required_params.all?

    {
      reviewer_id: params[:reviewer_id],
      citation_id: params[:citation_id],
      outcome: params[:outcome]
    }
  end

end