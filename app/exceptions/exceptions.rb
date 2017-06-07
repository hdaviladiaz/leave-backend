module Exceptions
  extend ActiveSupport::Concern
  
  included do
    rescue_from RestClient::Unauthorized, with: :msg_error_unauthorized
  end

  def msg_error_unauthorized(error)
    render json: { status: :unauthorized, error: error}, status: :unauthorized
  end
end
