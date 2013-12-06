unstoppable
===========

* [Homepage](https://rubygems.org/gems/unstoppable)
* [Documentation](http://rubydoc.info/gems/unstoppable/frames)
Cucumber extension that ensures all tests run to completion, catching failures and errors along the way and reporting them at completion.

## Description
Problem
  
  While Cucumber is an awesome tool, for some kinds of tests it's default behaviour becomes an obstacle.
  Testing large batches of input against a slow error prone system is the source of much frustration.
  Cucumber will skip remaining steps on failure or error. This is especially problematic if the test input is 
  a dynamic collection, *(e.g. results of a database query). 
  This is opposed to a static collection testing which is solved by a Scenario Outline.
  
Solution:
  
  We need to step putside Cucumber's default pass/fail/error handling.
  Capture all failures and errors in collections.
  Log errors and failures.
  Generate a pass/fail manifest against the test inputs.
  
  Do not use this for normal BDD style testing, Cucumber's default behaviour is perfect for that. 
  
Public Interface:

 This is a works in progress so I expect changes as usage reveals more.

  In your cucumber env.rb
  
  
  Before do |scenario|
    setup_unstoppable
  end

  After do |scenario|
    print unstoppable_failures(scenario)
    print unstoppable_errors(scenario)
  end
  
In a step definition  wrap any operation that you do not wish to stop execution like so

  unstoppable do
    expect(thing).to be(exected_thing)
  end

This helper method does the following:
  1. runs executes the block
  2. catches any exception
    2a. adds error to errors collection if an error
    2b. adds expectation failure to failures collection if error is an RSpec::Expectations::ExpectationNotMetError
  3. logs error/failure








  
  
  
  


