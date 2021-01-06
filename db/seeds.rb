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

  User.destroy_all
  puts "User 삭제"

end

def generate_users
  first_names = ['유', '김', '최']
  emails = ['dbtjdals1771@ajou.ac.kr', 'tjdals1771@gmail.com', 'codingmachine1771@gmail.com']
  3.times.each do |i|
    puts i
    User.create(name: first_names[i]+'성민', email: emails[i], password: '123456')
  end
  puts "user 생성완료"
end

def generate_posts
  15.times.each do |i|
    puts i
    image_field = File.open(("#{Rails.root}" + ROOT + PIMAGES.shuffle.first))
    Post.create(title: Faker::Lorem.sentence(word_count: 10), content: Faker::Lorem.sentence(word_count: 30), image: image_field, user_id: User.ids.shuffle.first).errors.full_messages
  end
end

destroy_all_data
generate_users
generate_posts


AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?