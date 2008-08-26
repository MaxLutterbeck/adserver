class ImageAd < ActiveRecord::Base
  
  file_column :file , :magick => { 
            :versions => { "thumb" => "250x250", "medium" => "600x600>" }
          }
  
  
  validates_uniqueness_of :title
  
  def self.find_image_ad(query)
    ImageAd.find(:all, 
               :select => "id, title, description, created_at",
               :conditions => ["title rlike ? or description rlike ?", "#{query}", "#{query}"],:order => "id desc")  
  end

end
