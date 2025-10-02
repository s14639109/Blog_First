module BlogPostsHelper
  def blog_banner_img(blog_post)
    if blog_post.banner_image.attached?
      image_tag blog_post.banner_image , class: "h-64 object-cover rounded-lg"
    else
      image_tag "noIMG.png", class:"h-64 object-cover rounded-t-lg"
    end
  end
end
