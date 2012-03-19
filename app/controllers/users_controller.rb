class UsersController < ApplicationController
  
=begin
  before_filter :ensure_current_user
  skip_before_filter :ensure_current_user, :only => [:new, :create]
  before_filter :ensure_signed_in
  
  
  def new
    #@user = User.new(params[:user])
    @title = "Sign up!"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to the Supermit!"
      session[:user_id] = @user
      redirect_to new_session_path
      
      #redirect_to @user
    else
      flash[:failure] = "Signup failed!"
      @title = "Sign up!"
      render :new
    end
    
  end
  
  def show
    @user = User.find(params[:id])
    @title = "User: "
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to edit_user_path(@user)
    else
      render :action => :edit
    end
  end
  
  private
  
  def ensure_current_user
    head(401) unless current_user.id.to_s == params[:id]
  end
=end

  before_filter :ensure_current_user
  
  def show
    @user = User.find(params[:id])
    @todos = @user.todos
    @title = @user.first_name + "'s Dashboard"
    @page_type = "dashboard"
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to edit_user_path(@user)
    else
      render :action => :edit
    end
  end
  
  private
  
  def ensure_current_user
    if signed_in?
      head(401) unless current_user.id.to_s == params[:id]
    end
    
  end
end
