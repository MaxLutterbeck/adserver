class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.integer :image_ad_id, :parent_id, :size, :width, :height
      t.string :content_type, :filename, :thumbnail
      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
