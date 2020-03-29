module Covidence
  class ReviewExistsError < StandardError
    def initialize(msg = 'review already exists for this citation and reviewer')
      super
    end
  end
end