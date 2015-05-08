module SmartAleck
  class FindingViablePeers
    attr_reader :categories

    def initialize(categories = [])
      @categories = categories
    end

    def viable_peers
      return SmartAleck.category_model.with_entries if categories.empty?
      categories.
        map(&:entries).
        flatten.
        uniq.
        select {|entry| (categories.map(&:id) - entry.category_ids).empty?}.
        map(&:categories).
        flatten.
        uniq - categories
    end
  end
end
