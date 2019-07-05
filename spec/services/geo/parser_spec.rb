require 'rails_helper'

RSpec.describe Geo::Parser, type: :model do
  subject { described_class.new }

  describe '#new' do
    context 'given a provider param' do
      let (:provider) { 1 }
      subject { described_class.new(provider) }

      it 'sets the given provider' do
        expect(subject.provider).to eq provider
      end
    end

    context 'not given a provider param' do
      let (:default_provider_class) { Geo::Providers::RGeo }

      it 'sets the default RGeo provider' do
        expect(subject.provider.class).to eq default_provider_class
      end
    end
  end

  describe '#parse' do
    context 'given a truthy param' do
      let (:json_data) { true }

      before { allow(subject).to receive(:data) { data } }

      context 'parsed data is a collection' do
        let (:data) { [1, 2, 3] }

        it 'returns an array of parsed data' do
          expect(subject.parse(json_data)).to eq data
        end
      end

      context 'parsed data is not a collection' do
        let (:data) { 1 }

        it 'returns parsed data' do
          expect(subject.parse(json_data)).to eq data
        end
      end
    end

    context 'given a falsey param' do
      let (:json_data) { nil }

      it 'returns an empty array' do
        expect(subject.parse(json_data)).to eq []
      end
    end
  end
end
