class Potepan::UsersController < ApplicationController

  def show
    @user = Potepan::User.find(params[:id])
  end

  def new
    @user = Potepan::User.new
  end

  def create
    @user = Potepan::User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = "会員登録が完了しました"
      redirect_to potepan_path
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "退会手続きが完了しました"
    redirect_to potepan_path
  end

  private

  def user_params
    params.require(:potepan_user).permit(:name, :email, :password, :password_confirmation)
  end
end
