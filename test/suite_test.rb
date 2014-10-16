require_relative 'test_helper'

describe Bisu::Suite do
  describe '#scrape_suites' do
    it 'returns an array of strings' do
      assert Array === Bisu::Suite.all
      Bisu::Suite.all.each do |link_text|
        assert String === link_text
      end
    end
  end

  describe '#all' do
    it 'is the same as #scrape_suites' do
      assert Bisu::Suite.all == Bisu::Suite.send(:scrape_suites)
    end
  end
end
