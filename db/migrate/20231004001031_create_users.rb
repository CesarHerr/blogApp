class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, limit: 50
      t.binary :photo
      t.text :bio
      t.integer :posts_counter
      t.timestamps
    end
  end
end
