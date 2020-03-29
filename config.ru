# Application Entry Point
require 'sinatra'

require_relative 'app/controllers/reviews_controller'
require_relative 'app/controllers/citations_controller'
require_relative 'app/data_access/data_accessor'

DataAccessor.instance.initialize_database(filename: 'sample_2_citations.json')
use CitationsController
run ReviewsController
