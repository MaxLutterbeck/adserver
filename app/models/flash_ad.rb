class FlashAd < ActiveRecord::Base
  
  file_column :file
  
  validates_uniqueness_of :title
  
  def self.find_flash_ad(query)
    FlashAd.find(:all, 
               :select => "id, title, description, created_at",
               :conditions => ["title rlike ? or description rlike ?", "#{query}", "#{query}"],:order => "id desc")  
  end
  
end
