class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer :author_id
      t.string :title, limit: 100
      t.string :text, limit: 1000
      t.integer :comments_counter
      t.integer :likes_counter
      t.timestamps
    end
    add_foreign_key :posts, :users, column: :author_id
  end
end
