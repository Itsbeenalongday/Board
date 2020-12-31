# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ROOT = "/public/image/"
PIMAGES = ["test1.jpg", "test2.jpg", "test3.jpg", "test4.jpg", "test5.jpg", "test6.jpg"]

def destroy_all_data

  Comment.destroy_all
  puts "Comment 삭제"

  Post.destroy_all
  puts "Post 삭제"

end

def generate_posts
  15.times.each do |i|
    puts i
    image_field = File.open(("#{Rails.root}" + ROOT + PIMAGES.shuffle.first))
    Post.create(title: Faker::Lorem.sentence(word_count: 10), content: Faker::Lorem.sentence(word_count: 30), image: image_field, user_id: User.ids.shuffle.first)
  end
end

destroy_all_data
generate_posts
