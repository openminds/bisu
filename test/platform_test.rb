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

  describe '#current' do
    it 'returns the name of the platform in test environment' do
      ENV['BISU_ENV'] = 'test'
      assert Bisu::Platform.current.kind_of?(Bisu::Platform), "foo msg"
      assert Bisu::Platform.current.name == 'wheezy', "bar msg"
    end

    it 'returns nil if /etc/*release is not found' do
      ENV['BISU_ENV'] = 'foo'
      Bisu::Platform.stub(:release_output, nil) do
        assert Bisu::Platform.current == nil
      end
    end
  end

  describe '#to_s' do
    it 'returns the name of the platform' do
      platform = Bisu::Platform.new(name: 'foobar')
      assert platform.to_s == 'foobar'
    end
  end

  describe '#vulnerability_parser' do
    it 'returns a Bisu::VulnerabilityParser::Debian object for all currently known debian platforms' do
      %w(etch jessie lenny sid squeeze wheezy).each do |platform_name|
        platform = Bisu::Platform.new(name: platform_name)
        assert platform.send(:vulnerability_parser).instance_variable_get('@platform') == platform_name
      end
    end
  end

  describe '#vulnerabilities' do
    it 'calls #parse_vulnerabilities of the parser class' do
      parser = MiniTest::Mock.new
      parser.expect :parse_vulnerabilities, true
      platform = Bisu::Platform.current
      platform.stub(:vulnerability_parser, parser) do
        platform.vulnerabilities
        parser.verify
      end
    end
  end
end
