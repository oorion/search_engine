require 'test_helper'

class ArticlesTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  test "all articles show on index page" do
    FactoryGirl.create_list(:article, 10)

    visit articles_path

    assert page.has_content?(Article.first.title)
    refute page.has_content?(Article.first.description)
    assert page.has_content?(Article.last.title)
    refute page.has_content?(Article.last.description)
  end

  test "can view a single article" do
    FactoryGirl.create :article

    visit articles_path
    click_link(Article.first.title)
    assert_equal current_path, article_path(Article.first.id)
    assert page.has_content?(Article.first.title)
    assert page.has_content?(Article.first.description)
  end

  test "can search for articles by title" do
    FactoryGirl.create_list(:article, 10)

    visit articles_path
    fill_in 'search', :with => Article.first.title
    click_link_or_button("Search")

    assert_equal current_path, article_search_path
    assert page.has_link?(Article.first.title)
  end
end
