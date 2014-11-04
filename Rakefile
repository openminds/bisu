require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new do |test|
  test.libs << 'lib'
  test.test_files = FileList['test/**/*_test.rb']
end

desc 'Default: run tests'
task default: [:test]
