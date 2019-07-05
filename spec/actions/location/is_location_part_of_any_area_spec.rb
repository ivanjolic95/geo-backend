require 'rails_helper'

RSpec.describe Geo::IsLocationPartOfAnyArea, type: :model do
  let (:location) { double('location') }
  subject { described_class.build.call(location) }

  describe '#call' do
    context 'given there are no exceptions' do
      context 'when location is not in any area' do
        before { allow(location).to receive(:is_inside_any_area?) { false } }

        it_behaves_like 'returns a success object'

        it 'returns false payload' do
          expect(subject.payload).to be_falsey
        end
      end

      context 'when location is in an area' do
        before { allow(location).to receive(:is_inside_any_area?) { true } }

        it_behaves_like 'returns a success object'

        it 'returns true payload' do
          expect(subject.payload).to be_truthy
        end
      end
    end

    context 'given there are exceptions' do
      context 'invalid GeoJSON error' do
        before { allow(location).to receive(:is_inside_any_area?).and_raise(Geo::Errors::InvalidGeoJSONError) }
      
        it_behaves_like 'returns a failure object'

        it 'returns the matching error message' do
          expect(subject.errors.last).to include described_class::GEO_JSON_PARSE_ERROR_MSG
        end
      end

      context 'JSON parser error' do
        before { allow(location).to receive(:is_inside_any_area?).and_raise(JSON::ParserError) }
      
        it_behaves_like 'returns a failure object'

        it 'returns the matching error message' do
          expect(subject.errors.last).to include described_class::JSON_PARSE_ERROR_MSG
        end
      end

      context 'any other error' do
        before { allow(location).to receive(:is_inside_any_area?).and_raise(StandardError) }
      
        it_behaves_like 'returns a failure object'

        it 'returns the matching error message' do
          expect(subject.errors.last).to include described_class::OTHER_ERROR_MSG
        end
      end
    end
  end
end
