require 'rails_helper'

RSpec.describe Location, type: :model do
  let (:json_data) { '{ a: 1 }' }
  subject { described_class.new(json_data)}

  describe '#new' do
    it 'sets json_data' do
      expect(subject.json_data).to eq json_data
    end
  end

  describe '#as_json' do
    it 'returns json_data' do
      expect(subject.as_json).to eq json_data
    end
  end

  describe '#geometry' do
    let (:parsed_data) { 1 }
    let (:geo_parser) { double('geo parser') }

    before do
      allow(geo_parser).to receive(:parse) { parsed_data }
      allow(subject).to receive(:geo_parser) { geo_parser }
    end

    it 'parses json_data' do
      expect(subject.geometry).to eq parsed_data
    end
  end

  describe '#is_inside_any_area?' do
    let (:area) do
      class_double('Area')
        .as_stubbed_const(transfer_nested_constants: true)
    end

    it 'calls any_contains? on Area' do
      expect(area).to receive(:any_contains?)
      subject.is_inside_any_area?
    end
  end
end
