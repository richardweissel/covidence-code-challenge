require 'yaml'

module GlobalSettings
  def self.citation_included_review_threshold
    GlobalSettings.properties['citation_included_review_threshold']
  end

  def self.citation_minimum_reviews_for_outcome
    GlobalSettings.properties['citation_minimum_reviews_for_outcome']
  end

  def self.properties
    @properties ||= YAML.load_file('config.yaml')
  end
end