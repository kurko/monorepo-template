# Contract tests are shared with different classes to ensure their interfaces.
RSpec.shared_context "a calculator" do
  it { expect(described_class.method_defined?(:sum)).to eq(true) }
end
