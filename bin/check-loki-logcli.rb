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
    command = "/usr/local/bin/logcli --addr=#{config[:address]} instant-query '#{config[:query]}'"

    # FIXME: replace this with popen
    output = `#{command} 2> /dev/null`

    if $? != 0
      critical "error running check: #{output}"
    end

    metrics = JSON.load(output)

    if metrics.nil?
      critical "invalid response from query: '#{metrics}'"
    end

    matches = metrics.inject(0) { |count, metric| count + metric["value"].to_i }

    critical "#{matches} > #{config[:crit]}" if matches > config[:crit]
    warning "#{matches} > #{config[:warn]}" if matches > config[:warn]
    ok "#{matches} < warning (#{config[:warn]}) < critical (#{config[:crit]})"
  end
end
