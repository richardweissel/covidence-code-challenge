module Covidence
  class CitationNotFoundError < StandardError
  def initialize(msg='Citation not found')
    super
  end
  end
end