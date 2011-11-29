class UsersController < ApplicationController
  skip_before_filter :login_required, :except => ['show', 'edit', 'index']
  layout 'admin'
  filter_access_to :edit, :attribute_check => true
    
  def index
    @users = @root.users
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      set_user_cookie @user
      redirect_to(@user, :notice => 'User was successfully created.')
    else
      render :action => "new"
    end    
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to(@user, :notice => 'User was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to(users_url)
  end
  
  def change_password
    @user = User.find(params[:id])    
  end
  
  def validate
    user = User.authenticate(params[:user][:email], params[:user][:password])
    if user.nil?
      flash[:error] = "Your email/password combination is invalid"
    redirect_to signin_path
    else
      set_user_cookie user
      redirect_to church_admin_path(@root)
    end
  end
  
  def signout
    sign_out
    redirect_to signin_path
  end
  
end
