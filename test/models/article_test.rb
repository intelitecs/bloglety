require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  setup do
     @article = articles(:one)
  end

   test "has image attribute" do
     assert_respond_to @article,:image,"No attribute image"
   end
end
