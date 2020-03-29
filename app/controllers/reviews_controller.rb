require 'sinatra/base'
require_relative 'base_controller'
require 'json'

class ReviewsController < BaseController

  post '/reviews' do
    logger.info("creating review with params #{params.length}")
    begin
      review = review_manager.create_review(params_hash: params)
      logger.info("created review #{review}")
      JSON.generate(review.id)
    rescue Covidence::CitationNotFoundError => e
      status 404
      JSON.generate(e)
    rescue Exception => e
      logger.error("Error:#{e.backtrace}")
      status 500
      JSON.generate(e)
    end
  end

  get '/reviews/:id' do
    "Review #{params[:id]} Show"
  end

end