require 'rails_helper'

RSpec.describe Result::Success, type: :model do
  let (:payload) { { a: 1 } }
  let (:result) { described_class.new(payload)}

  describe '#payload' do
    subject { result.payload }
    it { is_expected.to eq payload }
  end

  describe '#success?' do
    subject { result.success? }
    it { is_expected.to be_truthy }
  end

  describe '#failure?' do
    subject { result.failure? }
    it { is_expected.to be_falsey }
  end
end
