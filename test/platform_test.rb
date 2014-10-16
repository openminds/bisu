require_relative 'test_helper'

describe Bisu::Platform do
  describe '#scrape_platforms' do
    it 'returns an array of strings' do
      assert Array === Bisu::Platform.all
      Bisu::Platform.all.each do |link_text|
        assert String === link_text
      end
    end
  end

  describe '#all' do
    it 'is the same as #scrape_platforms' do
      assert Bisu::Platform.all == Bisu::Platform.send(:scrape_platforms)
    end
  end
end
