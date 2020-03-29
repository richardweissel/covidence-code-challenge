require 'yaml'

module GlobalSettings
  def self.citation_included_threshold
    GlobalSettings.properties['citation_included_threshold']
  end

  def self.properties
    @properties ||= YAML.load_file('config.yaml')
  end
end