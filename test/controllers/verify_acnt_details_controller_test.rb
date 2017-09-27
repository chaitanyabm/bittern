require 'test_helper'

class VerifyAcntDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get email" do
    get verify_acnt_details_email_url
    assert_response :success
  end

  test "should get phone" do
    get verify_acnt_details_phone_url
    assert_response :success
  end

end
