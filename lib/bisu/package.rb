module Bisu
  class Package

    attr_accessor :platform, :name, :version

    def initialize options={}
      @platform = options[:platform] || Bisu::Platform.current.to_s
      @name = options[:name]
      @version = options[:version]
    end

    def vulnerable?
      vulnerabilities.any?
    end

    def vulnerabilities
      @vulnerabilities ||= platform_object.vulnerabilities.select do |vulnerability|
        vulnerability[:package] == name && vulnerability[:unstable_version] == version
      end
    end

  private
    def platform_object
      Bisu::Platform.new(name: platform)
    end
  end
end
