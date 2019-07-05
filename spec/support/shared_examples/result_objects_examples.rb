shared_examples 'returns a success object' do
  it 'returns a success object' do
    aggregate_failures 'success object' do
      expect(subject.success?).to be_truthy
      expect(subject.failure?).to be_falsey
    end
  end
end

shared_examples 'returns a failure object' do
  it 'returns a success object' do
    aggregate_failures 'success object' do
      expect(subject.success?).to be_falsey
      expect(subject.failure?).to be_truthy
    end
  end
end
