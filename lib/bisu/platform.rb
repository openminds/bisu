require 'open-uri'
require 'oga'

module Bisu
  class Platform
    DEV_ETC_RELEASE_VALUE = %q(PRETTY_NAME="Debian GNU/Linux 7 (wheezy)")
    RELEASES_PAGE = 'http://secure-testing.debian.net/debian-secure-testing/project/debsecan/release/1/'
    NON_PLATFORM_LINK_HREFS = %w(
      ?C=N;O=D
      ?C=M;O=A
      ?C=S;O=A
      ?C=D;O=A
      /debian-secure-testing/project/debsecan/release/
      GENERIC
    )

    attr_accessor :name

    def initialize(attributes = {})
      @name = attributes[:name]
    end

    def to_s
      @name
    end

    def vulnerabilities
      @vulnerabilities ||= vulnerability_parser.parse_vulnerabilities
    end

    class << self
      def all
        scrape_platforms
      end

      def current
        output = ENV['BISU_ENV'].match(/dev|test/) ? DEV_ETC_RELEASE_VALUE : release_output
        if output
          current_name = output.scan(/\((.*)\)/).flatten.first
          @current_platform ||= Bisu::Platform.new
          @current_platform.name = current_name
          @current_platform
        else
          return @current_platform = nil
        end
      end
    end

  private

    def self.scrape_platforms
      releases_page = Oga.parse_html(open(RELEASES_PAGE))
      releases_page.xpath('//a/@href').map(&:text).reject { |text| NON_PLATFORM_LINK_HREFS.include?(text) }
    end

    def self.release_output
      `head -1 /etc/*release`
    end

    def vulnerability_parser
      case name
      when 'etch', 'jessie', 'lenny', 'sid', 'squeeze', 'wheezy'
        Bisu::VulnerabilityParser::Debian.new(platform: name)
      end
    end
  end
end
