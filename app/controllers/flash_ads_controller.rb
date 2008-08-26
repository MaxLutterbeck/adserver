class FlashAdsController < ApplicationController

    def new
      @flash_ad = FlashAd.new
    end

    def show
      @flash_ad = FlashAd.find(params[:id])
    end
    
    def create 
      @flash_ad = FlashAd.new(params[:flash_ad])
      @flash_ad.save! 
      flash[:notice] = "Ad was added"
      redirect_to root_path
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "There was a problem creating this ad!"
      render :action => 'new'
    end

    def edit
      @flash_ad = FlashAd.find(params[:id])
    end

    def update
      @flash_ad = FlashAd.find(params[:id])
       if @flash_ad.update_attributes(params[:flash_ad])
          flash[:notice] = "Image Ad updated"
          redirect_to :action => 'show', :id => @flash_ad
        else
          render :action => 'edit'
        end
    end

    def destroy
      FlashAd.find(params[:id]).destroy
      respond_to do |format|
        flash[:notice] = "Ad was delete!"
        format.html { redirect_to root_path}
      end
    end

  end
  

