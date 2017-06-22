require 'jwt'
class ApplicationController < ActionController::API
  include ActionController::Serialization
  include Exceptions

  before_action :require_sign_in!
  rescue_from JWT::DecodeError, with: :redirect_to_auth

  def require_sign_in!
    encoded_token = request.headers['Token']
    redirect_to_auth && return if encoded_token.nil?
    token = Token.new
    @user = token.decode(encoded_token)
  end

  def verify_admin!
    if (@user.rol != "admin")
      render json: { status: :unauthorized, error: "No tiene permisos" }, status: :unauthorized
    end
  end

  def redirect_to_auth
    render json: "/auth/saml?redirectUrl=#{URI.encode(request.path)}", status: :see_other
  end
end
