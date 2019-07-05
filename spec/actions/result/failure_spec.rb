require 'rails_helper'

RSpec.describe Result::Failure, type: :model do
  let (:result) { described_class.new}

  describe '#payload' do
    subject { result.payload }
    it { is_expected.to be_nil }
  end

  describe '#success?' do
    subject { result.success? }
    it { is_expected.to be_falsey }
  end

  describe '#failure?' do
    subject { result.failure? }
    it { is_expected.to be_truthy }
  end

  describe '#add_error' do
    let (:new_error) { 'NEW ERROR' }

    it 'adds the error to errors array' do
      result.add_error(new_error)
      expect(result.errors.last).to eq new_error
    end

    it 'returns an instance of the Failure object' do
      expect(result.add_error(new_error).class).to eq described_class
    end
  end
end
