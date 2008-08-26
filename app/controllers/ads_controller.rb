class AdsController < ApplicationController
  layout 'application'
  def index
    @flash_ads = FlashAd.find(:all)
    @image_ads = ImageAd.find(:all)
  end

end

