class EntryGenerator
  def self.generate(options = {})
    SmartAleck::EntryCreator.create(
      title: options[:title] || Faker::Lorem.sentence,
      content: options[:content] || Faker::Lorem.paragraph,
      categories: options[:categorized],
      user: options[:user] || User.create(
        email: Faker::Internet.email,
        password: 'supersekrat',
        password_confirmation: 'supersekrat'
      )
    )
  end
end
