require 'faker'

Category.destroy_all
Event.destroy_all

# Создаем 25 категорий
25.times do
  Category.create!(name: Faker::Lorem.sentence(word_count: 3))
end

# Создаем 25 событий, привязывая каждое к одной из категорий
25.times do
  category = Category.all.sample

  Event.create!(
    name: Faker::Lorem.sentence(word_count: 3),
    date: Faker::Date.forward(days: 30),
    description: Faker::Lorem.paragraph(sentence_count: 2),
    category: category
  )
end

puts '25 событий  успешно созданы.'
puts '25 категорий успешно созданы.'
