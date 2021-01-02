ActiveAdmin.register Post do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :content, :image, :user_id, :author
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :content, :image, :user_id, :author]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :title do |post|
      post.title.truncate 10
    end
    column :content do |post|
      post.content.truncate 30
    end
    column :user
    column :image do |post|
      image_tag(post.image.url, size: "100x100")
    end
    actions
  end
    
end
