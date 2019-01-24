class User < ActiveRecord::Base
  has_many :tweets

  validates :email, presence: true
  validates :username, presence: true

  has_secure_password

  def slug
    self.username.downcase.strip.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.find{|user| user.slug == slug}
  end

end
