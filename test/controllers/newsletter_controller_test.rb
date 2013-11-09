require 'test_helper'

class NewsletterControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get success" do
    get :success
    assert_response :success
  end

  test "should get error" do
    get :error
    assert_response :success
  end

end
