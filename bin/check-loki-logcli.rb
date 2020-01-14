#!/usr/bin/env ruby

require 'sensu-plugin/check/cli'
require 'json'

class CheckLokiLogCLI < Sensu::Plugin::Check::CLI
  option :warn,
    short: '-w WARN',
    proc: proc {|a| a.to_i },
    default: 1

  option :crit,
    short: '-c CRIT',
    proc: proc {|a| a.to_i },
    default: 1

  option :address,
    short: '-a ADDRESS',
    long: '--addr ADDRESS',
    required: true


  option :query,
    :short => '-q QUERY',
    :long => '--query QUERY'

  def run
    command = "#{File.expand_path(File.dirname(__FILE__))}/logcli --addr=#{config[:address]} query '#{config[:query]}'"
    output = `#{command} 2> /dev/null`

    if $? != 0
      critical "error running check: #{output}"
    end

    metrics = JSON.load(output)

    if metrics.nil? or metrics.length < 1
      critical "invalid response from query: '#{metrics}'"
    end

    matches = metrics.inject(0) { |count, metric| count + metric["values"].length }

    critical "#{matches} > #{config[:crit]}" if matches > config[:crit]
    warning "#{matches} > #{config[:warn]}" if matches > config[:warn]
    ok "#{matches} < warning (#{config[:warn]}) < critical (#{config[:crit]})"
  end
end
