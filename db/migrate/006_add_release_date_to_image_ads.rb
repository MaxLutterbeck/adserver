class AddReleaseDateToImageAds < ActiveRecord::Migration
  def self.up
    add_column :image_ads, :release_date, :datetime
  end

  def self.down
    remove_column :image_ads, :release_date
  end
end
