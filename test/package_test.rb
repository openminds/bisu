require_relative 'test_helper'

def vulnerabilities_fixtures
  @vulnerabilities_fixures ||= YAML.load_file('./test/fixtures/wheezy_vulnerabilities.yml')
end

def vulnerability_data
  @vulnerability_data ||= File.read('./test/fixtures/wheezy_vulnerability_data.txt')
end

describe 'Package' do
  describe '#new' do
    it 'uses the current platform if none is submitted in the arguments' do
      assert Bisu::Package.new.platform == Bisu::Platform.current.to_s
    end

    it 'uses the platform from the arguments if it was submitted as a string' do
      package = Bisu::Package.new(platform: 'foobar')
      assert package.platform == 'foobar'
    end
  end

  describe '#platform_object' do
    it "returns a Platform object with the same name as the package's platform name" do
      package = Bisu::Package.new(platform: 'foobar')
      assert package.send(:platform_object).name == 'foobar'
      assert Bisu::Platform === package.send(:platform_object)
    end
  end

  describe '#vulnerabilities' do
    before do
      Bisu::VulnerabilityParser::Debian.any_instance.stubs(:vulnerability_data).returns(vulnerability_data)
    end

    it 'includes matching vulnerabilities on name, platform and version' do
      package = Bisu::Package.new(platform: 'wheezy', name: 'drupal2', version: '1.2.3')
      assert_includes package.vulnerabilities, vulnerabilities_fixtures[3]
    end

    it 'does not include a vulnerability for another version' do
      package = Bisu::Package.new(platform: 'wheezy', name: 'drupal2', version: '1.2.3')
      refute_includes package.vulnerabilities, vulnerabilities_fixtures[4]
    end

    it 'does not include a vulnerability for another package' do
      package = Bisu::Package.new(platform: 'wheezy', name: 'drupal2', version: '1.2.3')
      refute_includes package.vulnerabilities, vulnerabilities_fixtures[2]
    end
  end

  describe '#vulnerable?' do
    it 'returns true if a matching vulnerability is found' do
      package = Bisu::Package.new(platform: 'wheezy', name: 'drupal2', version: '1.2.3')
      package.stub(:vulnerabilities, [:foo]) do
        assert package.vulnerable?
      end
    end

    it 'returns false if no matching vulnerabilities are found' do
      package = Bisu::Package.new(platform: 'wheezy', name: 'drupal2', version: '1.2.3')
      package.stub(:vulnerabilities, []) do
        refute package.vulnerable?
      end
    end
  end
end
