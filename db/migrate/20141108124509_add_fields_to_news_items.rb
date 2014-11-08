class AddFieldsToNewsItems < ActiveRecord::Migration
  def change
    add_column :news_items, :short_text, :text
    add_attachment :news_items, :image
  end
end
