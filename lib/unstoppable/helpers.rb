module Unstoppable
  module Helpers
    attr_accessor :failures, :errors

    def setup_unstoppable
      @failures ||=[]
      @errors ||=[]
    end

    def unstoppable
      begin
        yield
      rescue => error
        handle_error(error)
      end
    end

    def unstoppable_failures(scenario)
      output = 'No Failures'
      unless failures.empty?
        output = failures.reduce("Failures for scenario: #{scenario.name}\n") do |memo, failure|
          memo << "#{failure}\n"
          memo
        end
      end
      output
    end

    def unstoppable_errors(scenario)
      output = 'No Errors'
      unless errors.empty?
        output = errors.reduce("Errors for scenario: #{scenario.name}\n") do |memo, error|
          memo << "#{error}\n"
          memo
        end
      end
      output
    end

    private
    def handle_error(error)
      log_error(error)
      if error.class == RSpec::Expectations::ExpectationNotMetError
        failures.push(error)
      else
        errors.push(error)
      end
    end

    def log_error(error)
      File.open("#{Dir.pwd}/unstoppable.log", 'a') do |f|
        f.write("#{error}\n")
      end
    end
  end
end
