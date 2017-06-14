class Token
  PAYLOAD_INDEX = 0

  def initialize
    @jwt_secret = ENV['JWT_SECRET']
  end

  def encode(user)
    JWT.encode(user.instance_values, @jwt_secret, JWT_ALGORITHM)
  end

  def decode(token)
    decoded_token = JWT.decode(token, @jwt_secret, JWT_ALGORITHM)[PAYLOAD_INDEX]
    User.new(decoded_token['email'])
  end
end
