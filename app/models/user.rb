class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :nullify
  
  has_many :likes, dependent: :destroy

  has_many :comments, dependent: :nullify


  def self.generate_users
    10.times.each do |i|
      User.create(email: Faker::Internet.email, name: "#{Faker::Name.last_name}#{Faker::Name.first_name}", password: '123456')
    end
  end
end
