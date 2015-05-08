require 'spec_helper'

RSpec.describe SmartAleck::CategoryIndexer do
  let(:cat1) {Category.create(name: 'cat 1')}
  let(:cat2) {Category.create(name: 'cat 2')}
  let(:categories) {[cat1, cat2]}
  let(:indexer) {described_class.new(categories)}

  describe '.index' do
    it 'creates a new indexer' do
      expect(described_class).to receive(:new).with(categories).and_call_original
      described_class.index(categories)
    end

    it 'is the hash of the provided categories' do
      expect(described_class.index(categories)).
        to eql(indexer.category_hash)
    end
  end

  describe '.new' do
    it 'requires a list of categories' do
      expect {described_class.new}.to raise_error(ArgumentError)
      expect {described_class.new(categories)}.not_to raise_error
    end

    it 'allows categories to be expressed as category ids' do
      expect {described_class.new(categories.map(&:id))}.not_to raise_error
    end

    it 'populates the category_hash reader' do
      expect(indexer.category_hash).not_to be_nil
    end
  end

  describe '#category_hash' do
    it 'is the OR of the provided category ids' do
      expect(indexer.category_hash).
        to eql(2 ** cat1.id.to_i | 2 ** cat2.id.to_i)
    end
  end
end
