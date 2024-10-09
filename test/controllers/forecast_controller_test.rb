require "test_helper"

class ForecastControllerTest < ActionDispatch::IntegrationTest
  ZIP_CODE = "48116"
  BAD_ZIP_CODE = "badname"
  test "index url works" do
    get root_url
    assert_response :success
  end

  test "forecast succeeds with a valid zip code" do
    get forecast_path(zip_code: ZIP_CODE, format: :turbo_stream)
    assert_response :success
  end

  test "forecast fails with an invalid zip code" do
    get forecast_path(zip_code: BAD_ZIP_CODE, format: :turbo_stream)
    assert_redirected_to root_path
  end
end
