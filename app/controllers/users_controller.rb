class UsersController < ApplicationController
  before_action :authorize, except: [:sign_up, :sign_up_process, :sign_in, :sign_in_process]

  def sign_up
    @user = User.new
    render layout: "application_not_login"
  end
  
  def sign_up_process
    user = User.new(user_params)
    if user.save
      user_sign_in(user)
      redirect_to ('/')
    else
      flash[:danger] = "ユーザー登録に失敗しました。"
      redirect_to ('/sign_up')
    end
  end
  
  def sign_in
    @user = User.new
    render layout: "application_not_login"
  end
  
  def sign_in_process
    password_md5 = User.generate_password(user_params[:password])
    user = User.find_by(email: user_params[:email],password: password_md5)
    
    if user
      user_sign_in(user)
      redirect_to ('/') and return
    else
      flash[:danger] = "ログインに失敗しました。"
      redirect_to ('/sign_in') and return
    end
  end
  
  def sign_out
    user_sign_out
    flash[:success] = "ログアウトしました。"
    redirect_to sign_in_path and return
  end
  
  private
  def user_params
    params.require(:user).permit(:name,:email,:password)
  end
end
