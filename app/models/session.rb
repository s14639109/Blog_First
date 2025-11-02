class Session < ApplicationRecord
  # 在指令中 bin/rails generate model Session user:references 
  # user:references Rails 會自動建立 belongs_to :user
  belongs_to :user
end
