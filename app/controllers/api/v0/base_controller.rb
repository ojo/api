class Api::V0::BaseController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      puts token
      ENV['METADATA_UPLOAD_API_TOKEN'] == token
    end
  end
end
