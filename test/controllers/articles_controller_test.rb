require "test_helper"

class ArticlesControllerTest < ActionController::TestCase

  before do
    @user = users(:shane)
    sign_in @user
    @options = {
      title: 'Do not adjust your television',
      body: 'This is only a test'
    }
  end

  def test_index
    get :index
    assert_response :success
  end

  def test_new
    get :new
    assert_response :success
  end

  test 'NEW: does not render if user is not logged in' do
    sign_out @user
    get :new
    assert_redirected_to new_user_session_path
  end

  test 'SHOW: Renders for Logged In user' do
    get :show, id: articles(:two).id
    assert_response :success
  end

  test 'SHOW: Renders for Non-Signed In Guest' do
    sign_out @user
    get :show, id: articles(:two).id
    assert_response :success
  end

  test "CREATE: Signed in Users can create a new article" do
    assert_difference('Article.count') do
      get :create, article: @options
    end
    assert_equal "Article was successfully created", flash[:notice]
  end

  test 'CREATE: Non logged Users can not create a new article' do
    sign_out @user
    get :create, article: @options
    assert_redirected_to new_user_session_path
  end

  test 'PATCH: User can Edit their articles' do
    put :update, id: articles(:two).id, article: @options
    assert_redirected_to article_path(assigns(:article))
    assert_equal "Article was succesffully updated.", flash[:notice]
  end

  test 'PATCH: Non-Signed in Users can not edit Articles' do
    sign_out @user
    put :update, id: articles(:two).id, article: @options
    assert_redirected_to new_user_session_path
  end

  test 'PATCH: User can not edit another Users Article' do
    put :update, id: articles(:one).id, article: @options
    assert_redirected_to articles_path
    assert_equal 'A New Article Title', articles(:one).title
  end

  test 'DELETE: A user can delete an existing Article' do
    assert_difference 'Article.count',-1 do
      delete :destroy, id: articles(:two)
      assert_equal "Article was successfully deleted.", flash[:notice]
    end
  end

  test 'DELETE: Non Signed-In Users can not delete existing Article' do
    sign_out @user
    delete :destroy, id: articles(:two)
    assert_redirected_to new_user_session_path
  end

  test 'DELETE: Signed in Users can not delete another users Article' do
    assert_equal 2, Article.count
    delete :destroy, id: articles(:one)
    assert_redirected_to articles_path
    assert_equal 2, Article.count
  end

  test 'ACTS_AS_VOTABLE: Article 1 has one like vote' do
    @request.env['HTTP_REFERER'] = 'http://test.host/articles'
    assert_equal 0, articles(:one).get_upvotes.size
    put :upvote, id: articles(:one)
    assert_redirected_to articles_path
    assert_equal 1, articles(:one).get_upvotes.size
  end

  test 'ACTS_AS_VOTABLE: Article 1 has one down vote' do
    @request.env['HTTP_REFERER'] = 'http://test.host/articles'
    assert_equal 0, articles(:one).get_downvotes.size
    put :downvote, id: articles(:one)
    assert_redirected_to articles_path
    assert_equal 1, articles(:one).get_downvotes.size
  end

  test 'ACTS_AS_VOTABLE: Article 2 has 0 votes after one up and one down' do
    @request.env['HTTP_REFERER'] = 'http://test.host/articles'
    put :upvote, id: articles(:two)
    put :downvote, id: articles(:two)
    assert_redirected_to articles_path
    assert_equal 0, articles(:one).get_downvotes.size
  end

  test 'ACTS_AS_VOTABLE: Article 2 has 0 votes after user tries 2 upvotes' do
    @request.env['HTTP_REFERER'] = 'http://test.host/articles'
    put :upvote, id: articles(:two)
    put :upvote, id: articles(:two)
    assert_redirected_to articles_path
    assert_equal 0, articles(:one).get_downvotes.size
  end
end
