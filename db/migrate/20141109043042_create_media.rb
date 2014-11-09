class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :title
      t.string :short_title
      t.string :url
      t.float :rating, default: 0

      t.timestamps
    end

    add_column :news_items, :media_id, :integer, index: true
  end
end
