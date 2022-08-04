require "application_system_test_case"

class MintersTest < ApplicationSystemTestCase
  setup do
    @minter = minters(:one)
  end

  test "visiting the index" do
    visit minters_url
    assert_selector "h1", text: "Minters"
  end

  test "should create minter" do
    visit minters_url
    click_on "New minter"

    click_on "Create Minter"

    assert_text "Minter was successfully created"
    click_on "Back"
  end

  test "should update Minter" do
    visit minter_url(@minter)
    click_on "Edit this minter", match: :first

    click_on "Update Minter"

    assert_text "Minter was successfully updated"
    click_on "Back"
  end

  test "should destroy Minter" do
    visit minter_url(@minter)
    click_on "Destroy this minter", match: :first

    assert_text "Minter was successfully destroyed"
  end
end
