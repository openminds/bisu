module Bisu
  class Package

    attr_accessor :platform

    def initialize options={}
      @platform = options[:platform] ? options[:platform].to_s : Bisu::Platform.current.to_s
    end
  end
end
