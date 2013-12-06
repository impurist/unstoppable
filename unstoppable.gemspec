# -*- encoding: utf-8 -*-

require File.expand_path('../lib/unstoppable/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "unstoppable"
  gem.version       = Unstoppable::VERSION
  gem.summary       = %q{Cucumber extension that ensures all tests run to completion, catching failures and errors along the way and reporting them at completion.}
  gem.description   = %q{TODO: Problem

While Cucumber is an awesome tool, for some kinds of tests it's default behaviour becomes an obstacle. Testing large batches of input against a slow error prone system is the source of much frustration. Cucumber will skip remaining steps on failure or error. This is especially problematic if the test input is a dynamic collection, *(e.g. results of a database query). This is opposed to a static collection testing which is solved by a Scenario Outline.

Solution:

We need to step putside Cucumber's default pass/fail/error handling. Capture all failures and errors in collections. Log errors and failures. Generate a pass/fail manifest against the test inputs.

Do not use this for normal BDD style testing, Cucumber's default behaviour is perfect for that.

Public Interface:

This is a works in progress so I expect changes as usage reveals more.

In your cucumber env.rb

Before do |scenario| setup_unstoppable end

After do |scenario| print unstoppable_failures(scenario) print unstoppable_errors(scenario) end

In a step definition wrap any operation that you do not wish to stop execution like so

unstoppable do expect(thing).to be(exected_thing) end

This helper method does the following:

runs executes the block
catches any exception 2a. adds error to errors collection if an error 2b. adds expectation failure to failures collection if error is an RSpec::Expectations::ExpectationNotMetError
logs error/failure}
  gem.license       = "MIT"
  gem.authors       = ["Steven Holloway"]
  gem.email         = "impurist@gmail.com"
  gem.homepage      = "https://rubygems.org/gems/unstoppable"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler', '~> 1.0'
  gem.add_development_dependency 'rake', '~> 0.8'
  gem.add_development_dependency 'rspec', '~> 2.4'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
  gem.add_development_dependency 'yard', '~> 0.8'
end
