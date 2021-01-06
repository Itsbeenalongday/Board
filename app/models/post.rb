class Post < ApplicationRecord
  mount_uploader :image, ImageUploader # 이미지 첨부를 위해 이 부분 추가
  
  belongs_to :user, optional: true

  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy


  def self.generate_posts
    20.times do |i|
      Post.create(title: "#{i}번째 제목", content: "#{i}번째 게시글입니다.", user: User.first)
    end
  end
end
