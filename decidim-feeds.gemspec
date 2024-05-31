# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require "decidim/feeds/version"

Gem::Specification.new do |s|
  s.version = Decidim::Feeds.version
  s.authors = ["Alexander Rusa", "Piero Chiussi"]
  s.email = ["alex@rusa.at", "info@webchroma.de"]
  s.license = "AGPL-3.0"
  s.homepage = "https://decidim.org"
  s.metadata = {
    "bug_tracker_uri" => "https://github.com/decidim/decidim/issues",
    "documentation_uri" => "https://docs.decidim.org/",
    "funding_uri" => "https://opencollective.com/decidim",
    "homepage_uri" => "https://decidim.org",
    "source_code_uri" => "https://github.com/decidim/decidim"
  }
  s.required_ruby_version = ">= 3.1"

  s.name = "decidim-feeds"
  s.summary = "A decidim feeds module"
  s.description = "Feeds component for Decidim."

  s.files = Dir["{app,config,lib}/**/*", "LICENSE-AGPLv3.txt", "Rakefile", "README.md"]

  s.add_dependency "decidim-core", "~> #{Decidim::Feeds.version}"
end
