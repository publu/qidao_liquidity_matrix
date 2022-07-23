require "application_system_test_case"

class TokensTest < ApplicationSystemTestCase
  setup do
    @token = tokens(:one)
  end

  test "visiting the index" do
    visit tokens_url
    assert_selector "h1", text: "Tokens"
  end

  test "should create token" do
    visit tokens_url
    click_on "New token"

    fill_in "Asset", with: @token.asset
    check "Centralized" if @token.centralized
    fill_in "Grade", with: @token.grade
    fill_in "Liquidity", with: @token.liquidity
    fill_in "Symbol", with: @token.symbol
    fill_in "Trade slippage", with: @token.trade_slippage
    fill_in "Volume", with: @token.volume
    click_on "Create Token"

    assert_text "Token was successfully created"
    click_on "Back"
  end

  test "should update Token" do
    visit token_url(@token)
    click_on "Edit this token", match: :first

    fill_in "Asset", with: @token.asset
    check "Centralized" if @token.centralized
    fill_in "Grade", with: @token.grade
    fill_in "Liquidity", with: @token.liquidity
    fill_in "Symbol", with: @token.symbol
    fill_in "Trade slippage", with: @token.trade_slippage
    fill_in "Volume", with: @token.volume
    click_on "Update Token"

    assert_text "Token was successfully updated"
    click_on "Back"
  end

  test "should destroy Token" do
    visit token_url(@token)
    click_on "Destroy this token", match: :first

    assert_text "Token was successfully destroyed"
  end
end
