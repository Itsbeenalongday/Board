class ChangeUserIdToPost < ActiveRecord::Migration[6.0]
  def change
    change_column :posts, :user_id, :bigint, :null => true
  end
end
