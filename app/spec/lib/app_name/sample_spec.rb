require "rails_helper"

RSpec.describe AppName::Sample do
  let(:number1) { 1 }
  let(:number2) { 2 }
  let(:result) { 3 }

  subject { described_class.new(number1, number2) }

  it_behaves_like "a calculator"

  describe "#calculate" do
    it "equalizes 1" do
      expect(subject.sum).to eq(result)
    end
  end
end
