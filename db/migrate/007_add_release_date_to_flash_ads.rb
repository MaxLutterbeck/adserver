class AddReleaseDateToFlashAds < ActiveRecord::Migration
  def self.up
    add_column :flash_ads, :release_date, :datetime
  end

  def self.down
    remove_column :flash_ads, :release_date
  end
end
