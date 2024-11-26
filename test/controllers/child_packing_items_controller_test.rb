require "test_helper"

class ChildPackingItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get child_packing_items_index_url
    assert_response :success
  end
end
