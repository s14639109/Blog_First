class ApplicationController < ActionController::Base
  include Authentication
  # 在所有請求中都嘗試恢復 session（如果有 cookie 的話）
  # 這樣即使在 allow_unauthenticated_access 的 action 中也能知道用戶是否已登入
  before_action :resume_session_if_available
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private
    def resume_session_if_available
      # 嘗試從 cookie 恢復 session，但不強制要求認證
      resume_session if cookies.signed[:session_id]
    end
end
