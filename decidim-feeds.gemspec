# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require "decidim/feeds/version"

Gem::Specification.new do |s|
  s.version = Decidim::Feeds::VERSION
  s.authors = ["Alexander Rusa", "Piero Chiussi"]
  s.email = ["alex@rusa.at", "info@webchroma.de"]
  s.license = "AGPL-3.0"
  s.homepage = "https://github.com/DecidimAustria/decidim-module-feeds/"
  s.metadata = {
    "bug_tracker_uri" => "https://github.com/DecidimAustria/decidim-module-feeds/issues",
    "source_code_uri" => "https://github.com/DecidimAustria/decidim-module-feeds/"
  }
  s.required_ruby_version = ">= 3.1"

  s.name = "decidim-feeds"
  s.summary = "A social feeds participatory space for Decidim."
  s.description = "A new participatory space for Decidim that is ideal for decidim-posts."

  s.files = Dir["{app,config,lib}/**/*", "LICENSE-AGPLv3.txt", "Rakefile", "README.md"]

  s.add_dependency "decidim-core", Decidim::Feeds::COMPAT_DECIDIM_VERSION
end
