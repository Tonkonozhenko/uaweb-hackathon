class CreateNewsItems < ActiveRecord::Migration
  def change
    create_table :news_items do |t|
      t.string :title
      t.text :text
      t.float :rating, default: 0
      t.integer :plus_ids, array: true, defaulrt: []
      t.integer :minus_ids, array: true, default: []
      t.integer :plus_count, default: 0
      t.integer :minus_count, default: 0
      t.text :url

      t.timestamps
    end
    add_index :news_items, :rating
  end
end
