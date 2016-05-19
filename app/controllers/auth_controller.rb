class AuthController < ApplicationController
  respond_to :json

  def new
    e = params[:email]
    p = params[:password]
    u = User.find_by_email(e)
    if u && u.valid_password?(p)
      t = '' # TODO generate token. save token.
      render json: {token: t}
    else
      head :bad_request
    end
  end
end
