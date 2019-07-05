require 'rails_helper'

RSpec.describe Geo::Providers::RGeo, type: :model do
  subject { described_class.build }

  describe '#parse' do
    context 'given valid data' do
      let (:x_coord) { 28.3228 }
      let (:y_coord) { -15.3785 }
      let (:json_data) {
        %Q(
          {
            "type": "Point",
            "coordinates": [#{x_coord}, #{y_coord}]
          }
        )
      }
      let (:result) { subject.parse(json_data) }

      it 'returns a valid RGeo object' do
        aggregate_failures 'RGeo object' do
          expect(result).to be_truthy
          expect(result.x).to eq x_coord
          expect(result.y).to eq y_coord
        end
      end
    end

    context 'given invalid data' do
      context 'given invalid JSON' do
        let (:json_data) { 'ABC123' }
        let (:result) { subject.parse(json_data) }

        it 'raises an JSON parse error' do
          expect { result }.to raise_error(JSON::ParserError)
        end
      end

      context 'given invalid GeoJSON query' do
        let (:json_data) { '{"type": "ABC123"}' }
        let (:result) { subject.parse(json_data) }

        it 'raises a InvalidGeoJSONError' do
          expect { result }.to raise_error(Geo::Errors::InvalidGeoJSONError)
        end
      end
    end
  end

  describe '#contains?' do
    let (:area) { 1 }
    let (:location) { double('location') }

    before { allow(location).to receive(:within?) }

    it 'calls within? method on location object' do
      expect(location).to receive(:within?)
      subject.contains?(area, location)
    end
  end
end
