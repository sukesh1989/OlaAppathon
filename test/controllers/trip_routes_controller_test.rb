require 'test_helper'

class TripRoutesControllerTest < ActionController::TestCase
  setup do
    @trip_route = trip_routes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trip_routes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trip_route" do
    assert_difference('TripRoute.count') do
      post :create, trip_route: { DriverTrip_id: @trip_route.DriverTrip_id, pointlat: @trip_route.pointlat, pointlong: @trip_route.pointlong }
    end

    assert_redirected_to trip_route_path(assigns(:trip_route))
  end

  test "should show trip_route" do
    get :show, id: @trip_route
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trip_route
    assert_response :success
  end

  test "should update trip_route" do
    patch :update, id: @trip_route, trip_route: { DriverTrip_id: @trip_route.DriverTrip_id, pointlat: @trip_route.pointlat, pointlong: @trip_route.pointlong }
    assert_redirected_to trip_route_path(assigns(:trip_route))
  end

  test "should destroy trip_route" do
    assert_difference('TripRoute.count', -1) do
      delete :destroy, id: @trip_route
    end

    assert_redirected_to trip_routes_path
  end
end
