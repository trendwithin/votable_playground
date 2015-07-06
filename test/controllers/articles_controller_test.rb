require "test_helper"

class ArticlesControllerTest < ActionController::TestCase

  before do
    @user = users(:shane)
    sign_in @user
  end

  def test_index
    get :index
    assert_response :success
  end

end
