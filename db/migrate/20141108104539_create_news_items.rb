class CreateNewsItems < ActiveRecord::Migration
  def change
    create_table :news_items do |t|
      t.string :title
      t.text :text
      t.float :rating
      t.integer :plus_ids, array: true
      t.integer :minus_ids, array: true
      t.integer :plus_count
      t.integer :minus_count

      t.timestamps
    end
    add_index :news_items, :rating
  end
end
