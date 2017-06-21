class User
  attr_accessor :username, :email, :rol

  def initialize(email)
    @email = email
    @username = email.split('@')[0]
    @rol = admin ? 'admin' : 'user'
  end

  def admin
    admins = ADMIN_USERS.split(',')
    admins.include?(@username)
  end
end
