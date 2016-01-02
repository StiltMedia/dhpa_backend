class Admin::SettingsController < AdminsController
  before_action :set_setting

  def index
  end

  def show
  end

  def new
  end

  def create
    if @setting.save
      flash[:success] = "Settings created successfully."
      redirect_to admin_settings_path
    else
      flash[:error] = "Error creating settings: #{@setting.errors.full_messages.join('; ')}."
      render :index
    end
  end

  def edit
  end

  def update
    if @setting.update(setting_params)
      flash[:success] = "Settings updated successfully."
      redirect_to admin_settings_path
    else
      flash[:error] = "Error updating settings: #{@setting.errors.full_messages.join('; ')}."
      render :index
    end
  end

  private
    def setting_params
      params.require(:setting).permit(:commercial_price_in_dollars, :personal_price_in_dollars, :personal_image_size)
    end

    def set_setting
      @setting = Setting.first
    end
end