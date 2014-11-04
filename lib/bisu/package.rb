module Bisu
  class Package

    attr_accessor :platform, :name, :version

    def initialize options={}
      @platform = options[:platform] || Bisu::Platform.current.to_s
      @name = options[:name]
      @version = options[:version]
    end
  end
end
