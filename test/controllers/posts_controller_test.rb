require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get name:string" do
    get posts_name:string_url
    assert_response :success
  end

end
