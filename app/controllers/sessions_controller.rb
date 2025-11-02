class SessionsController < ApplicationController
  include Authentication
  # 允許未登入的使用者存取 new 與 create 動作
  allow_unauthenticated_access only: %i[ new create ]
  
  # rails rate_limiter 設定，預防被暴力破解
  # 當在三分鐘之內連續登入失敗10次，會自動封鎖該 IP 一段時間
  # 這邊設定是三分鐘內失敗10次就封鎖
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new # 登入表單
    @user = User.new
  end

  def create # 處理登入，當點擊登入時，會送出到這個動作屬於 post 請求
    user = User.find_by(email_address: params[:email_address])

    # &. 是判斷user是不是nil，若不是nil就執行後面的authenticate 方法
    # 如果單純使用 . 的話，當 user 是 nil 時，會發生 NoMethodError 錯誤
    if user&.authenticate(params[:password])
      start_new_session_for(user)
      redirect_to root_path, notice: "登入成功！"
    else
      flash.now[:alert] = "Email 或密碼錯誤"
      render :new
    end
  end

  def destroy # 登出，視為 delete 請求
    terminate_session
    redirect_to root_path, notice: "已登出"
  end
end
