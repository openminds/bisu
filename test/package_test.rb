require_relative 'test_helper'

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
end
