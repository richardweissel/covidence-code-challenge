require 'ostruct'
require 'json'
require_relative '../logging'

class JsonInputParser
  include Logging
  def read_array_of_citations(json_string:)
    return JSON.parse(json_string, object_class: OpenStruct)
  end

  def read_citations_from_input_file(filename:)
    logger.info("Reading citations from file #{filename}")
    citations_array_as_string = File.read(filename)
    read_array_of_citations(json_string: citations_array_as_string)
  end
end