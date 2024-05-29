class Api::V1::InnRoomsController < Api::V1::ApiController
  def show
    inn_room = InnRoom.find(params[:id])
    render status: 200, json: inn_room.as_json(except: [:created_at, :updated_at])
  end
end
