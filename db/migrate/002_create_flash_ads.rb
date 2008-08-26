class CreateFlashAds < ActiveRecord::Migration
  def self.up
    create_table :flash_ads do |t|
      t.string :title
      t.text :description
      t.string :file
      t.string :category

      t.timestamps
    end
  end

  def self.down
    drop_table :flash_ads
  end
end
