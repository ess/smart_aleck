class Category < FakeModel
  def initialize(options = {})
    super(options)
    @entries = []
  end

  def entries
    @entries
  end

  def entry_ids
    entries.map(:id)
  end

  def self.with_entries
    all.select {|category| !category.entries.empty?}
  end
end
