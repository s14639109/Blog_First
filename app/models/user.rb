class User < ApplicationRecord
  # 下指令產生 model 時， Rails 會自動幫忙建立 model 檔之外
  # 還會建立 migration 檔，以及 test 檔
 
  # 使用 bcrypt 進行密碼加密與驗證，要有 bcrypt 這個gem 才可以使用
  has_secure_password 

  # destroy 指刪除 user 時，連帶刪除該 user 底下的 sessions 與 blog_posts
  # 好比說 user 刪除時，連帶刪除該 user 的所有 session 紀錄與 blog post 文章
  has_many :sessions, dependent: :destroy
  has_many :blog_posts, dependent: :destroy

  # 去除email字串前後的空白值，並轉成小寫
  normalizes :email_address, with: ->(e) { e.strip.downcase }
  # presence: true 確保email_address 欄位是必填
  # uniqueness: true 確保email_address 欄位的值是唯一的
  validates :email_address, presence: true, uniqueness: true
end
