class CreatePostComments < ActiveRecord::Migration[5.1]
  def change
    create_table :post_comments do |t|
      t.text :comment

      t.timestamps
    end
  end
end
