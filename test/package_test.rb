require_relative 'test_helper'

describe 'Package' do
  describe '#new' do
    it 'uses the current platform if none is submitted in the arguments' do
      assert Bisu::Package.new.platform == Bisu::Platform.current.to_s
    end

    it 'uses the platform from the arguments if it was submitted' do
      assert Bisu::Package.new(platform: 'foobar').platform == Bisu::Platform.new(name: 'foobar').to_s
    end
  end
end
