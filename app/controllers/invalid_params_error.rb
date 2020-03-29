class InvalidParamsError < StandardError
  def initialize(msg = 'Invalid params')
    super
  end
end
