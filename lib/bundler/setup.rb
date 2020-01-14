require 'rbconfig'
ruby_engine = RUBY_ENGINE
ruby_version = RbConfig::CONFIG["ruby_version"]
path = File.expand_path('..', __FILE__)
$:.unshift "#{path}/"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/extensions/universal-darwin-17/2.3.0/json-2.3.0"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/json-2.3.0/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/mixlib-cli-1.7.0/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/sensu-plugin-4.0.0/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/bundler/gems/sensu-plugins-loki-d12db47624b4/lib"
