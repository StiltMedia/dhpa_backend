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
      redirect_to admin_settings_path()
    else
      render :new
      flash[:error] = "Something went wrong."
    end
  end

  def edit
  end

  def update
    if @setting.update(setting_params)
      redirect_to admin_settings_path()
    else
      render :edit
      flash[:error] = "Something went wrong"
    end
  end

  private
    def setting_params
      params.require(:setting).permit(:default_price_in_dollars)
    end

    def set_setting
      @setting = Setting.first
    end
end