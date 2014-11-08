class CreateCategoryNewsItems < ActiveRecord::Migration
  def change
    create_table :category_news_items do |t|
      t.integer :category_id, index: true
      t.integer :news_item_id, index: true

      t.timestamps
    end
  end
end
