class Entry < FakeModel
  def initialize(options = {})
    super(options)
    @categories = []
  end

  def categories
    @categories
  end

  def category_ids
    categories.map(&:id)
  end

  def add_category(category)
    categories << category
    category.entries << self
  end
end
