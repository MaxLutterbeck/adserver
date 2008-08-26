class SearchController < ApplicationController

  def index
    @query = params[:query]
    @searchimage = ImageAd.find_image_ad(@query)
    @searchflash = FlashAd.find_flash_ad(@query)
    puts 'XXXXXXXXXXXX'
    puts @searchimage
  end
end
