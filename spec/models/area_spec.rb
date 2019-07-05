require 'rails_helper'

RSpec.describe Area, type: :model do
  subject { described_class }

  let (:path) { subject::AREA_DATA_PATH }
  let (:json_data) { File.read(path) }
  let (:data) do
    [
      OpenStruct.new(geometry: 1),
      OpenStruct.new(geometry: 2),
      OpenStruct.new(geometry: 3)
    ]
  end
  let (:geo_parser) { double('geo parser') }

  before do
    allow(geo_parser).to receive(:parse) { data }
    allow(subject).to receive(:geo_parser) { geo_parser }
  end

  describe '.all' do
    it 'returns parsed data' do
      expect(subject.all).to eq data
    end
  end

  describe '.as_json' do
    it 'parses json from the area data path' do
      expect(subject.as_json).to eq JSON.parse(json_data).to_json
    end
  end

  describe '.any_contains?' do
    let (:location) { OpenStruct.new(geometry: 1) }
    let (:provider) { double('provider') }

    before { allow(subject).to receive(:provider) { provider } }

    context 'an area contains geometry' do
      before { allow(provider).to receive(:contains?) { true } }
    
      it 'returns true' do
        expect(subject.any_contains?(location)).to be_truthy
      end
    end

    context 'no area contains geometry' do
      before { allow(provider).to receive(:contains?) { false } }
    
      it 'returns false' do
        expect(subject.any_contains?(location)).to be_falsey
      end
    end
  end
end
