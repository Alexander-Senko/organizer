require_relative "lib/organizer/version"
require_relative 'lib/organizer/authors'

Gem::Specification.new do |spec|
  spec.platform    = Gem::Platform::RUBY
  spec.name        = "organizer-rails"
  spec.version     = Organizer::VERSION
  spec.authors     = Organizer::AUTHORS.filter_map &:name
  spec.email       = Organizer::AUTHORS.filter_map &:email
  spec.homepage    = "#{Organizer::AUTHORS.filter_map(&:github_url).first}/#{spec.name}"
  spec.summary     = 'Record organizer for Rails'
  spec.description = 'Use lists, tags, flags, etc. to organize your application records.'
  spec.license     = "MIT"

  spec.metadata["homepage_uri"]    = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"]   = "#{spec.metadata['source_code_uri']}/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md", 'CHANGELOG.md']
  end

  spec.required_ruby_version = '>= 3.2'

  spec.add_dependency 'rails', '~> 7.1'
end
