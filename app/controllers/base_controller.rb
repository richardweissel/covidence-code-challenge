require 'sinatra/base'
require_relative '../covidence/manager'
require_relative '../logging'

class BaseController < Sinatra::Base
  include Logging

  def review_manager
    @review_manager ||= Covidence::Manager.new
  end

end