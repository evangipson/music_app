class RegistrationsController < Devise::RegistrationsController
  
  def new
    @user = User.new
  end
  
  def create
    sign_up_params = devise_parameter_sanitizer.sanitize(:sign_up)
    @user = User.new(sign_up_params)
    if @user.valid? 
      super
    else 
      message = I18n.t("Please fill out all info!")
      flash[:notice] = message if message.present?
      message = ""
      render 'new'
    end
  end
  
   def update
     account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
     @user = User.find(current_user.id)
     successfully_updated = update_resource(@user, account_update_params)
     
    if successfully_updated
      set_flash_message :notice, :updated
      sign_in @user, :bypass => true
      redirect_to '/'
    else
      render 'edit'
    end
  end
  
  private

  def sign_up_params
    params.require(:user).permit(:username, :email, :artist_id, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :current_password )
  end
end