class ApplicationController < ActionController::API
  def root
    render json: {
      status: "SUCCESS"
    }
  end
end
