class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    self.username.split(' ').join('-')
  end

  def self.find_by_slug(user_slug)
    self.all.find{ |user| user.slug == user_slug}
  end
  
end
