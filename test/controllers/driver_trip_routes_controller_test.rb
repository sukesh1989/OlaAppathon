require 'test_helper'

class DriverTripRoutesControllerTest < ActionController::TestCase
  setup do
    @driver_trip_route = driver_trip_routes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:driver_trip_routes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create driver_trip_route" do
    assert_difference('DriverTripRoute.count') do
      post :create, driver_trip_route: { DriverTrip_id: @driver_trip_route.DriverTrip_id, pointlat: @driver_trip_route.pointlat, pointlong: @driver_trip_route.pointlong }
    end

    assert_redirected_to driver_trip_route_path(assigns(:driver_trip_route))
  end

  test "should show driver_trip_route" do
    get :show, id: @driver_trip_route
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @driver_trip_route
    assert_response :success
  end

  test "should update driver_trip_route" do
    patch :update, id: @driver_trip_route, driver_trip_route: { DriverTrip_id: @driver_trip_route.DriverTrip_id, pointlat: @driver_trip_route.pointlat, pointlong: @driver_trip_route.pointlong }
    assert_redirected_to driver_trip_route_path(assigns(:driver_trip_route))
  end

  test "should destroy driver_trip_route" do
    assert_difference('DriverTripRoute.count', -1) do
      delete :destroy, id: @driver_trip_route
    end

    assert_redirected_to driver_trip_routes_path
  end
end
