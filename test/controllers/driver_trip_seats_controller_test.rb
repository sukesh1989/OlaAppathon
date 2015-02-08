require 'test_helper'

class DriverTripSeatsControllerTest < ActionController::TestCase
  setup do
    @driver_trip_seat = driver_trip_seats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:driver_trip_seats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create driver_trip_seat" do
    assert_difference('DriverTripSeat.count') do
      post :create, driver_trip_seat: { from: @driver_trip_seat.from, seatsoccupied: @driver_trip_seat.seatsoccupied, to: @driver_trip_seat.to }
    end

    assert_redirected_to driver_trip_seat_path(assigns(:driver_trip_seat))
  end

  test "should show driver_trip_seat" do
    get :show, id: @driver_trip_seat
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @driver_trip_seat
    assert_response :success
  end

  test "should update driver_trip_seat" do
    patch :update, id: @driver_trip_seat, driver_trip_seat: { from: @driver_trip_seat.from, seatsoccupied: @driver_trip_seat.seatsoccupied, to: @driver_trip_seat.to }
    assert_redirected_to driver_trip_seat_path(assigns(:driver_trip_seat))
  end

  test "should destroy driver_trip_seat" do
    assert_difference('DriverTripSeat.count', -1) do
      delete :destroy, id: @driver_trip_seat
    end

    assert_redirected_to driver_trip_seats_path
  end
end
