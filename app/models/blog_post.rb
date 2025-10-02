class BlogPost < ApplicationRecord
  has_rich_text :body
  has_one_attached :meta_image
  has_one_attached :banner_image
  # 允許搜尋的欄位
  def self.ransackable_attributes(auth_object = nil)
    %w[id title meta_title meta_description tags created_at updated_at]
  end

  # 允許搜尋的關聯
  def self.ransackable_associations(auth_object = nil)
    %w[rich_text_body meta_image_attachment meta_image_blob banner_image_attachment banner_image_blob]
  end
end
