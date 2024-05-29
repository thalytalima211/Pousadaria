class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :return_404
  rescue_from ActiveRecord::QueryCanceled, with: :return_500

  private

  def return_404
    render status: 404, json: ''
  end

  def return_500
    render status: 500, json: ''
  end
end
