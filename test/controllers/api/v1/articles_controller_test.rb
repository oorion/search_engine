require "test_helper"

class Api::V1::ArticlesControllerTest < ActionController::TestCase
  include Capybara::DSL

  test "can respond with all articles when an API call is made" do
    FactoryGirl.create_list(:article, 10)
    Api::V1::ArticlesController.any_instance.stubs(:authenticate).returns(true)
    get :index, { format: :json }

    assert_equal 200, response.status
    articles = JSON.parse(response.body)

    assert_equal Article.first.title, articles.first["title"]
    assert_equal Article.first.description, articles.first["description"]
  end

  test "can respond when user searches using api" do
    FactoryGirl.create_list(:article, 10)
    Api::V1::ArticlesController.any_instance.stubs(:authenticate).returns(true)

    post :search, {:search => Article.first.title, format: :json }

    assert_equal 200, response.status
    search_results = JSON.parse(response.body)

    assert_equal Article.first.title, search_results.first["title"]
    assert_equal Article.first.description, search_results.first["description"]
  end

  test "user can access index if authenticated" do
    skip
    FactoryGirl.create(:article)
    user = User.create(email: 'test@example.com', password: 'password')

    stub_request(:get, "user:pass@localhost:3000")
    Net::HTTP.start('localhost:3000') do |http|
      req = Net::HTTP::Get.new('/')
      req.basic_auth 'test@example.com', 'password'
      http.request(req)
    end
    binding.pry
    articles = JSON.parse(response.body)

    #get :index, { email: 'test@example.com', password: 'password', format: :json }
    assert_equal 200, response.status
    assert page.has_content?(articles.first["title"])
  end

  test "user cannot access index without authenticating" do

    get :index, { format: :json }

    assert_equal 401, response.status
    assert_includes response.body, "HTTP Basic: Access denied.\n"
  end
end
