require 'test_helper'

class VisitorCanRemoveItemFromCartTest < ActionDispatch::IntegrationTest
  def visitor_adds_item_to_cart
    @city = City.create(name: "Vail",
                       image_path: "www.vail.jpeg")

    @city.categories.create(name: "Outdoor fun",
                           price: 100,
                           description: "biking",
                           image_path: "www.biking.jpeg")

    visit city_categories_path(@city)

    click_link "Add to Cart"
  end

  test "visitor can remove item from cart" do
    visitor_adds_item_to_cart

    assert page.has_content? "My Trips (1)"

    visit cart_path
    click_link "Remove"

    assert_equal cart_path, current_path
    assert page.has_content? "Successfully removed Outdoor fun from your cart."
    assert page.has_content? "My Trips (0)"
    assert page.has_link? "Outdoor fun"
  end

  test "visitor can visit path to category they just removed" do
    visitor_adds_item_to_cart
 
    assert page.has_content? "My Trips (1)"

    visit cart_path
    click_link "Remove"

    assert page.has_link? "Outdoor fun"

    click_link "Outdoor fun"

    assert_equal city_categories_path(@city.id), current_path
  end
end
