require 'thor'
require './lib/debian_tracker.rb'

# view/console/client.rb
class BisuCLI < Thor
  @tracker = nil

  def initialize(*args)
    @tracker = DebianTracker.new 'http://secure-testing.debian.net/debian-secure-testing/project/debsecan/release/1/'
    super
  end

  desc 'list_suites', 'List available suites'
  def list_suites
    puts 'Suites:'
    puts '-------'
    @tracker.fetch_suites.each { |suite| puts "- #{suite}" }
  end

  desc 'list_issues', 'List issues for a specific suite'
  method_option(
    :suite,
    aliases: '-s',
    desc: 'The suite to find issues for'
  )
  def list_issues
    listings = @tracker.fetch_listings(options[:suite])
    listings.each { |listing| puts "- #{listing}" }
  end
end

BisuCLI.start
