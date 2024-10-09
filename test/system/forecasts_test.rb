require "application_system_test_case"

class ForecastsTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit root_url

    assert_selector "#no_results"
    assert_selector "#search"
  end

  test "searching for a valid zip code" do
    visit root_url

    fill_in "zip_code", with: "48116"
    click_on "Search"

    assert_selector ".forecast"
    assert_no_selector "#no_results"
  end

  test "searching for an invalid zip code" do
    visit root_url

    fill_in "zip_code", with: "badname"
    click_on "Search"

    assert_selector "#no_results"
    assert_no_selector ".forecast"
  end

  test "7 day forecast" do
    visit root_url

    fill_in "zip_code", with: "48116"
    click_on "Search"

    assert_selector ".forecast", count: 7
  end

  test "pulls from cache" do
    visit root_url

    fill_in "zip_code", with: "48116"
    click_on "Search"

    click_on "Search"

    assert_text "Results from cache"
  end

  tests "displays current temperature" do
    visit root_url

    fill_in "zip_code", with: "48116"
    click_on "Search"

    assert_selector "#current_temperature"
  end
end
