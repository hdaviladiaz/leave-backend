class Token
  PAYLOAD_INDEX = 0

  def initialize
    @jwt_secret = ENV['JWT_SECRET']
  end

  def encode(user)
    token = JWT.encode(user.instance_values, @jwt_secret, JWT_ALGORITHM)
    token + (user.admin ? '1' : '0')
  end

  def decode(token)
    decoded_token = JWT.decode(token[0...-1], @jwt_secret, JWT_ALGORITHM)[PAYLOAD_INDEX]
    User.new(decoded_token['email'])
  end
end
