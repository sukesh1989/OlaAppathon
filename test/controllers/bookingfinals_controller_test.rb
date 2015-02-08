require 'test_helper'

class BookingfinalsControllerTest < ActionController::TestCase
  setup do
    @bookingfinal = bookingfinals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bookingfinals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bookingfinal" do
    assert_difference('Bookingfinal.count') do
      post :create, bookingfinal: { tripid: @bookingfinal.tripid, useremail: @bookingfinal.useremail }
    end

    assert_redirected_to bookingfinal_path(assigns(:bookingfinal))
  end

  test "should show bookingfinal" do
    get :show, id: @bookingfinal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bookingfinal
    assert_response :success
  end

  test "should update bookingfinal" do
    patch :update, id: @bookingfinal, bookingfinal: { tripid: @bookingfinal.tripid, useremail: @bookingfinal.useremail }
    assert_redirected_to bookingfinal_path(assigns(:bookingfinal))
  end

  test "should destroy bookingfinal" do
    assert_difference('Bookingfinal.count', -1) do
      delete :destroy, id: @bookingfinal
    end

    assert_redirected_to bookingfinals_path
  end
end
