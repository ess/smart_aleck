require 'spec_helper'

RSpec.describe SmartAleck::FindingViablePeers do
  describe '.new' do
    it 'allows an array of peers' do
      expect {described_class.new([])}.not_to raise_error
    end

    it 'defaults the categories reader to an empty array' do
      expect(described_class.new.categories).to eql([])
    end

    it 'sets the categories reader to a provided Category collection' do
      category_1 = Category.create(name: 'category 1')
      category_2 = Category.create(name: 'category 2')
      expected_categories = [category_1, category_2]
      finder = described_class.new(expected_categories)
      expect(finder.categories).to eql(expected_categories)
    end
  end

  describe '#viable_peers' do
    let(:cat1) {Category.create(name: 'cat 1')}
    let(:cat2) {Category.create(name: 'cat 2')}
    let(:cat3) {Category.create(name: 'cat 3')}
    let(:cat4) {Category.create(name: 'cat 4')}
    let(:considered_categories) {[cat1, cat2]}
    let(:finder) {described_class.new(considered_categories)}
    let(:viable_peers) {finder.viable_peers}

    before(:each) do
      EntryGenerator.generate(categorized: [cat1])
      EntryGenerator.generate(categorized: [cat2])
      EntryGenerator.generate(categorized: [cat3])
      EntryGenerator.generate(categorized: [cat1, cat2])
      EntryGenerator.generate(categorized: [cat1, cat2, cat3])
    end

    it 'is a collection' do
      expect(viable_peers).to respond_to(:each)
    end

    context 'when the categories reader is empty' do
      it 'is all known categories that have entries' do
        viable = described_class.new.viable_peers
        Category.with_entries.each do |category|
          expect(viable).to include(category)
        end
      end
    end

    context 'when the categories reader is not empty' do
      it 'contains only categories with entries' do
        viable_peers.each do |peer|
          expect(peer.entries).not_to eql(0)
        end
      end

      it 'excludes categories that are in the categories reader' do
        finder.categories.each do |category|
          expect(viable_peers).not_to include(category)
        end
      end

      it 'includes categories that share entries with all categories reader items' do
        expect(viable_peers).to include(cat3)
      end

      it 'excludes categories without common entries with all categories reader items' do
        cat4 = Category.create(name: 'cat 4')
        EntryGenerator.generate(categorized: [cat4])
        EntryGenerator.generate(categorized: [cat1, cat4])
        EntryGenerator.generate(categorized: [cat2, cat4])
        EntryGenerator.generate(categorized: [cat3, cat4])
        EntryGenerator.generate(categorized: [cat1, cat3, cat4])

        expect(viable_peers).not_to include(cat4)
      end
    end
  end
end
