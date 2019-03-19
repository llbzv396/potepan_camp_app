class Potepan::SessionsController < ApplicationController
  def new
  end

  def create
    user = Potepan::User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "ログインしました"
      log_in(user)
      redirect_to potepan_path
    else
      flash.now[:danger] = "メールアドレスかパスワードが間違っています"
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:success] = "ログアウトしました"
    redirect_to potepan_path
  end
end
