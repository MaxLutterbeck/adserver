class FlashAdObserver < ActiveRecord::Observer
  
  def after_create(flash_ad)
    FlashAdMailer.deliver_new_flash_ad(flash_ad)
  end
  
end