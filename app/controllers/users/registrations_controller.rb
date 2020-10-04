# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  def new
    @user = User.new
    @user.build_sending_address
  end
  
  def create
    
    @user = User.new(user_params)

    if @user.save 
      sign_in(:user, @user) #登録後ログイン状態になるようにしている
      redirect_to complete_users_path, notice: '登録が完了しました'
    else
      redirect_to   new_user_registration_path, alert: '登録できませんでした'
    end
  end




  def update
  
    if @user.update(user_params)
      redirect_to user_path(current_user.id),notice: '編集が完了しました'
    else
      redirect_to user_path(current_user.id), alert: '編集できませんでした'
    end
  end

  def destroy
    redirect_to root_path
  end


  


  private
  def user_params
    params.require(:user).permit(:nickname, :email, :password, :first_name, :family_name, :first_name_kana, :family_name_kana, :birth_date, :image, :introduction, sending_address_attributes:[:id, :first_name, :family_name, :first_name_kana, :family_name_kana, :post_code, :prefecture_code_id, :city, :house_number, :building_name, :phone_number, :user_id])
    #usersテーブル上パスワードはencrypted_passwordであるが、パラメータ上passwordとなるため上記ように記載
    # ユーザー登録の際にsending_address_attributes:を付属させることでsending_addressesテーブルにもデータを入れることが可能。user_idは自動的にmergeされる。
  end






  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
