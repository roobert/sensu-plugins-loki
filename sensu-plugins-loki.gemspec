lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'date'
require_relative 'lib/sensu-plugins-loki'

Gem::Specification.new do |s| # rubocop:disable Metrics/BlockLength
  s.authors                = ['Sensu-Plugins and contributors']
  s.date                   = Date.today.to_s
  s.description            = 'This plugin provides checks for Grafana Loki'
  s.email                  = '<roobert@gmail.com>'
  s.executables            = Dir.glob('bin/**/*.rb').map { |file| File.basename(file) }
  s.files                  = Dir.glob('{bin,lib}/**/*')
  s.homepage               = 'https://github.com/roobert/sensu-plugins-loki'
  s.license                = 'MIT'
  s.metadata               = { 'maintainer'         => 'roobert@gmail.com',
                               'development_status' => 'active',
                               'production_status'  => 'unstable - testing recommended',
                               'release_draft'      => 'false',
                               'release_prerelease' => 'false' }
  s.name                   = 'sensu-plugins-loki'
  s.platform               = Gem::Platform::RUBY
  s.require_paths          = ['lib']
  s.required_ruby_version  = '>= 2.3'
  s.summary                = 'Sensu plugins for Grafana Loki checks'
  s.version                = SensuPluginsLoki::Version::VER_STRING

  s.add_runtime_dependency 'sensu-plugin', '~> 4.0'
  s.add_development_dependency 'bundler',                   '~> 1.7'

end
