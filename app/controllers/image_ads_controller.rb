class ImageAdsController < ApplicationController
  
  def new
    @image_ad = ImageAd.new
  end
  
  def show
    @image_ad = ImageAd.find(params[:id])
  end
  
  def create 
    @image_ad = ImageAd.new(params[:image_ad])
    @image_ad.save! 
    flash[:notice] = "Ad was added"
    redirect_to root_path
  rescue ActiveRecord::RecordInvalid
    flash[:error] = "There was a problem creating this ad!"
    render :action => 'new'
  end
  
  def edit
    @image_ad = ImageAd.find(params[:id])
  end
  
  def update
    @image_ad = ImageAd.find(params[:id])
     if @image_ad.update_attributes(params[:image_ad])
        flash[:notice] = "Image Ad updated"
        redirect_to :action => 'show', :id => @image_ad
      else
        render :action => 'edit'
      end
  end
  
  def destroy
    ImageAd.find(params[:id]).destroy
    respond_to do |format|
      flash[:notice] = "Ad was delete!"
      format.html { redirect_to root_path}
    end
  end
  
end
