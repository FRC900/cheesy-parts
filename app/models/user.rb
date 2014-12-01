class User < ActiveRecord::Base
  before_validation :encrypt_password
  
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :permission, :enabled

  attr_accessor :password
  
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :first_name
  validates_presence_of :last_name

  
  PERMISSION_MAP = { "readonly" => "Read-only", "editor" => "Editor", "admin" => "Administrator" }
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  def can_edit?
    ["editor", "admin"].include?(self.permission)
  end

  def can_administer?
    self.permission == "admin"
  end
end
