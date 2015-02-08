require 'test_helper'

class DriverTripsControllerTest < ActionController::TestCase
  setup do
    @driver_trip = driver_trips(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:driver_trips)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create driver_trip" do
    assert_difference('DriverTrip.count') do
      post :create, driver_trip: { Driver_id: @driver_trip.Driver_id, currentPosition: @driver_trip.currentPosition, end: @driver_trip.end, isCurrent: @driver_trip.isCurrent, start: @driver_trip.start }
    end

    assert_redirected_to driver_trip_path(assigns(:driver_trip))
  end

  test "should show driver_trip" do
    get :show, id: @driver_trip
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @driver_trip
    assert_response :success
  end

  test "should update driver_trip" do
    patch :update, id: @driver_trip, driver_trip: { Driver_id: @driver_trip.Driver_id, currentPosition: @driver_trip.currentPosition, end: @driver_trip.end, isCurrent: @driver_trip.isCurrent, start: @driver_trip.start }
    assert_redirected_to driver_trip_path(assigns(:driver_trip))
  end

  test "should destroy driver_trip" do
    assert_difference('DriverTrip.count', -1) do
      delete :destroy, id: @driver_trip
    end

    assert_redirected_to driver_trips_path
  end
end
