class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.gsub(/\s/, '-')
  end

  def self.find_by_slug(slug_username)
     @username = slug_username.gsub(/[-]/, ' ')
     @username
     #self.find_by(username: @username)
  end

end
