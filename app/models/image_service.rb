class ImageService < ActiveRecord::Base
  
  attr_reader :image_ad, :image
  
  def initialize(image_ad, image)
    @image_ad = image_ad
    @image = image
  end
  
  def save
    return false unless valid?
    begin
      ImageAd.transaction do
        if @image.new_record?
          @image_ad.image.destroy if @image_ad.image
          @image.image_ad = @image_ad
          @image.save!
        end
        @image_ad.save!
        true
      end
    rescue
      false
    end
  end
  
  def valid?
    @image_ad.valid? && @image.valid?
  end
  
  def update_attributes(image_ad_attributes, image_file)
    @image_ad.attributes = image_ad_attributes
    unless image_file.blank?
      @image = Image.new(:uploaded_data => image_file)
    end
    save
  end
  
end
