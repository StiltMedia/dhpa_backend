class Admin::UsersController < AdminsController
  before_action :set_user, only: [:edit, :update, :delete]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    handle_exif(@user)
    if @user.save
      flash[:success] = "User created successfully."
      redirect_to admin_users_path
    else
      flash[:error] = "Error creating user: #{@user.errors.full_messages.join('; ')}."
      render :new
    end
  end

  def edit
  end

  def update
    @user.assign_attributes(user_params)
    handle_exif(@user)
    if @user.save
      flash[:success] = "User updated successfully."
      redirect_to admin_users_path
    else
      flash[:error] = "Error updating user: #{@user.errors.full_messages.join('; ')}."
      render :new
    end
  end

  private
    def user_params
      filtered_params = params.require(:user).permit(:first_name, :last_name, :email, :password, :is_admin, :is_photographer)
      
      filtered_params.delete(:password) if filtered_params[:password].blank?
      
      return filtered_params
    end

    def set_user
      @user = User.find(params[:id])
    end
end