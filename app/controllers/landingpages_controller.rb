class LandingpagesController < ApplicationController
  layout 'lp'
  
  def index
    @landingpages = Landingpage.find(:all)
  end
  
  def new
    @landingpage = Landingpage.new
  end
  
  def create 
    @landingpage = Landingpage.new(params[:landingpage])
    respond_to do |format|
      if @landingpage.save 
        flash[:notice] = "LP was added"
        format.html { redirect_to landingpages_path }
      else
        flash[:error] = "There was a problem creating this LP!"
        format.html { render :action => 'new' }
      end
    end
  end
  
  def edit
    @landingpage = Landingpage.find(params[:id])
  end

  def update
    @landingpage = Landingpage.find(params[:id])
     if @landingpage.update_attributes(params[:landingpage])
        flash[:notice] = "LP updated"
        redirect_to landingpages_path
      else
        render :action => 'edit'
      end
  end
  
  def destroy
    Landingpage.find(params[:id]).destroy
    respond_to do |format|
      flash[:notice] = "LP was deleted!"
      format.html { redirect_to root_path}
    end
  end
    
  
end
