class ImageAdObserver < ActiveRecord::Observer
  
  def after_create(image_ad)
    ImageAdMailer.deliver_new_image_ad(image_ad)
  end
  
end