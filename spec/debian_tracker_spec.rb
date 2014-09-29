require 'spec_helper'
require 'debian_tracker'

describe DebianTracker, 'Tracker' do
  it 'Should return at least one suite' do
    tracker = DebianTracker.new(
      'http://secure-testing.debian.net' \
        '/debian-secure-testing/project/debsecan/release/1/'
    )

    expect(tracker.fetch_suites.count).to be > 0
  end

  it 'Should return at least one package listing' do
    tracker = DebianTracker.new(
      'http://secure-testing.debian.net' \
        '/debian-secure-testing/project/debsecan/release/1/'
    )

    expect(tracker.fetch_listings('wheezy').count).to be > 0
  end
end
