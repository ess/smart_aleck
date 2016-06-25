require 'base58'

module SmartAleck
  class CategoryIndexer
    attr_reader :category_hash

    def self.index(categories)
      new(categories).category_hash
    end

    def initialize(categories)
      @category_hash =
        Base58.encode(
          categories.map {|category|
            2 ** (category.respond_to?(:id) ? category.id : category).to_i
          }.inject(:|).to_i
        )
    end
  end
end
