class User < ActiveRecord::Base
  after_destroy :ensure_andmin_remains

  validates :name, :presence => true, :uniqueness => :true
  validates :password, :confirmation => true

  attr_accessor :password_confirmation
  attr_reader :password

  validate :password_must_be_present

  def User.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + "wibble" + salt)
  end

  def password=(password)
    @password = password

    if password.present?
      generate_salt
      self.hasched_password = self.class.encrypt_password(password, salt)
    end
  end

  def User.authenticate(name, password)
    if user = find_by_name(name)
      if user.hasched_password == encrypt_password(password, user.salt)
        user
      end
    end
  end

  private

  def password_must_be_present
    errors.add(:password, "missing password") unless hasched_password.present?
  end

  def generate_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  def ensure_andmin_remains
    if User.count.zero?
      raise "Can't delete last user "
    end
  end
  
end
