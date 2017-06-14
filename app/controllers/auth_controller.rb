require 'jwt'

class AuthController < ApplicationController
  skip_before_action :require_sign_in!, only: [:saml_callback]

  def initialize
    @token = Token.new
  end

  def saml_callback
    auth = request.env['omniauth.auth']
    user = User.new(auth[:uid])
    jwt = @token.encode(user)
    redirect_to('http://localhost:3006/auth/' + jwt)
  end
end
