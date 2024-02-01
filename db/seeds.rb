require 'faker'

Category.destroy_all
Event.destroy_all

5.times do
  Category.create!(name: Faker::Lorem.sentence(word_count: 3))
end
Category.create!(name:"личное")
Category.create!(name:"Отдых")
Category.create!(name:"Работа")

25.times do
  category = Category.all.sample

  Event.create!(
    name: Faker::Lorem.sentence(word_count: 1),
    date: Faker::Date.forward(days: 30),
    description: Faker::Lorem.paragraph(sentence_count: 2),
    category: Category.all.sample
  )
end


puts '8 событий  успешно созданы.'
puts '25 категорий успешно созданы.'
