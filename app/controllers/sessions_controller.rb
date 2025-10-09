class SessionsController < ApplicationController
  include Authentication
  allow_unauthenticated_access only: %i[ new create ]
  
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      start_new_session_for(user)
      redirect_to root_path, notice: "登入成功！"
    else
      flash.now[:alert] = "Email 或密碼錯誤"
      render :new
    end
  end

  def destroy
    end_current_session
    redirect_to root_path, notice: "已登出"
  end
end
