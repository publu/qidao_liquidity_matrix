require "test_helper"

class MintersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @minter = minters(:one)
  end

  test "should get index" do
    get minters_url
    assert_response :success
  end

  test "should get new" do
    get new_minter_url
    assert_response :success
  end

  test "should create minter" do
    assert_difference("Minter.count") do
      post minters_url, params: { minter: {  } }
    end

    assert_redirected_to minter_url(Minter.last)
  end

  test "should show minter" do
    get minter_url(@minter)
    assert_response :success
  end

  test "should get edit" do
    get edit_minter_url(@minter)
    assert_response :success
  end

  test "should update minter" do
    patch minter_url(@minter), params: { minter: {  } }
    assert_redirected_to minter_url(@minter)
  end

  test "should destroy minter" do
    assert_difference("Minter.count", -1) do
      delete minter_url(@minter)
    end

    assert_redirected_to minters_url
  end
end
