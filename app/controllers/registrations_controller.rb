class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation, :last_name, :first_name, :last_name_kana, :first_name_kana, :date_of_birth)
  end

  def create
    super
  end
end