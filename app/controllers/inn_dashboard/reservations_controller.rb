class InnDashboard::ReservationsController < InnDashboard::InnDashboardController
  def new
    @reservation = @inn.reservations.build
  end

  def create
    @reservation = @inn.reservations.build(reservation_params)
    if @reservation.save
      redirect_to inn_dashboard_reservation_path(@reservation), notice: 'Reserva cadastrada com sucesso'
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  private

  def reservation_params
    params.require(:reservation).permit(:name, :start_date, :end_date)
  end
end
