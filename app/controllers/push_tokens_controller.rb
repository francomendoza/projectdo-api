class PushTokensController < ApplicationController
  def create
    token = PushToken.where(value: push_token_params[:token]).first
    if !token.present?
      PushToken.create!(
        value: push_token_params[:token],
      )
    end

    render json: {
      status: 'SUCCESS'
    }
  end

  private
  def push_token_params
    params.permit(:token)
  end
end
