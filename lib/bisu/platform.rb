require 'open-uri'
require 'oga'

module Bisu
  class Platform
    RELEASES_PAGE = 'http://secure-testing.debian.net/debian-secure-testing/project/debsecan/release/1/'
    NON_PLATFORM_LINK_HREFS = %w(
      ?C=N;O=D
      ?C=M;O=A
      ?C=S;O=A
      ?C=D;O=A
      /debian-secure-testing/project/debsecan/release/
      GENERIC
    )

    class << self
      def all
        scrape_platforms
      end
    end

  private
    class << self
      def scrape_platforms
        releases_page = Oga.parse_html(open(RELEASES_PAGE))
        releases_page.xpath('//a/@href').map(&:text).reject { |text| NON_PLATFORM_LINK_HREFS.include?(text) }
      end
    end
  end
end
