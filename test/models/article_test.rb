require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  should validate_presence_of :title
  should validate_presence_of :description
end
