module Bisu
  class Package

    attr_accessor :platform, :name, :version

    def initialize options={}
      @platform = options.delete(:platform) || Bisu::Platform.current.to_s
    end
  end
end
