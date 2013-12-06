require 'spec_helper'

include Unstoppable::Helpers

describe Unstoppable::Helpers do

  context '#setup_unstoppable' do

    before do
      setup_unstoppable
    end

    it 'should create an empty failures collection' do
      expect(failures).to eq []
    end

    it 'should create an empty errors collection' do
      expect(errors).to eq []
    end

  end

  context '#unstoppable' do

    before do
      setup_unstoppable
    end

    it 'does not raise an error' do
      expect {
        unstoppable do
          raise('hell')
        end
      }.to_not raise_error
    end

    it 'captures errors in the errors collection' do
      unstoppable do
        raise('hell')
      end
      expect(errors.first.message).to eq(RuntimeError.new('hell').message)
    end

    it 'captures failures in the failures collection' do
      unstoppable do
        expect('foo').to eq('bar')
      end
      expect(failures.count).to eq(1)
    end

  end

  let(:scenario) { double('Scenario') }

  context '#unstoppable_failures' do

    before do
      allow(scenario).to receive(:name) { 'My awesome scenario' }
      setup_unstoppable
      unstoppable do
        expect('foo').to eq('bar')
      end
    end

    it 'returns a string of all test failures' do

    expected = <<-EXPECTED
Failures for scenario: My awesome scenario

expected: "bar"
     got: "foo"

(compared using ==)

EXPECTED

      expect(unstoppable_failures(scenario)).to eq(expected)
    end
  end

  context '#unstoppable_errors' do

    before do
      allow(scenario).to receive(:name) { 'My awesome scenario' }
      setup_unstoppable
      unstoppable do
        raise('hell')
      end
    end

    it 'returns a string of all test errors' do
      expected = <<-EXPECTED
Errors for scenario: My awesome scenario
hell
EXPECTED
      expect(unstoppable_errors(scenario)).to eq(expected)
    end
  end

end
