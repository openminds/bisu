require 'open-uri'
require 'nokogiri'

# lib/debian_tracker.rb
class DebianTracker
  FALSE_POSITIVES = [
    '?C=N;O=D',
    '?C=M;O=A',
    '?C=S;O=A',
    '?C=D;O=A',
    '/debian-secure-testing/project/debsecan/release/',
    'GENERIC'
  ]

  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def fetch_suites
    releases_page = Nokogiri::HTML(open(@url))
    releases_page.xpath('//a/@href').map(&:content) - FALSE_POSITIVES
  end

  def fetch_listings(suite)
    fail 'Should be a supported suite' if fetch_suites.index(suite).nil?
    open "#{@url}#{suite}" do |compressed_listing|
      Zlib::Inflate.inflate(compressed_listing.read).split("\n")
    end
  end
end
