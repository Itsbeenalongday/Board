class Comment < ApplicationRecord
  # belongs_to 사용시 comment에 user가 없는 경우도 있다면(예: 탈퇴한 회원의 댓글)
  # optional: true를 추가해줍니다
  belongs_to :post
  belongs_to :user, optional: true
end
