class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def self.find_by_slug(slug)
    self.all.find do |obj|
      obj.slug == slug
    end
  end

end
