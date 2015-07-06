require "test_helper"

class ArticleTest < ActiveSupport::TestCase

  before do
    @article = articles(:one)
  end

  test 'Valid Article' do
    assert @article.valid?
  end

  test 'Presence of Title' do
    @article.title = ''
    refute @article.valid?
  end

  test 'Presence of Body' do
    @article.body = ''
    refute @article.valid?
  end

end
