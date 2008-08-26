class UsersController < ApplicationController
  layout 'application'
  before_filter :login_required, :only => [:show, :edit, :update]
  before_filter :check_administrator_role, :only => [:index, :destroy, :enable, :new, :create]

  def index
    @users = User.find(:all)
  end

  # this show action only allows users to view their own profile
  def show
    @user = current_user
  end

  # render new.rhtml
  def new
    @user = User.new
  end

  def create
    cookies.delete :auth_token
    @user = User.new(params[:user])
    @user.save!
    # Uncomment to have the user automatically
    # logged in after creating an account - Not Recommended
    # self.current_user = @user
    flash[:notice] = "Thanks for signing up! Please check your email to activate your account before logging in."
    redirect_to login_path
  rescue ActiveRecord::RecordInvalid
    flash[:error] = "There was a problem creating your account."
    render :action => 'new'
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(current_user)
    if @user.update_attributes(params[:user])
      flash[:notice] = "User updated"
      redirect_to :action => 'show', :id => current_user
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.update_attribute(:enabled, false)
      flash[:notice] = "User disabled"
    else
      flash[:error] = "There was a problem disabling this user."
    end
    redirect_to :action => 'index'
  end

  def enable
    @user = User.find(params[:id])
    if @user.update_attribute(:enabled, true)
      flash[:notice] = "User enabled"
    else
      flash[:error] = "There was a problem enabling this user."
    end
    redirect_to :action => 'index'
  end

  def activate
    @user = User.find_by_activation_code(params[:id])
    if @user and @user.activate
      self.current_user = @user
      redirect_back_or_default(:controller => '/user_account', :action => 'index')
      flash[:notice] = "Your account has been activated."
    end
    redirect_to :action => 'index'
  end

end