require "test_helper"

class UserCanViewPastTrips < ActionDispatch::IntegrationTest
  def user_orders_trips
    user = User.create(username: "BikeBro",
                       password: "password")
    city = City.create(name: "Vail",
                       image_path: "Vail.jpg")

    trip = city.trips.create(name: "Outdoor Adventure",
                             description: "Oh so fun!",
                             price: 125,
                             image_path: "www.biking.jpeg")
    second_trip = city.trips.create(name: "Telluride Trek",
                                   description: "Wow!",
                                   price: 70,
                                   image_path: "telluride.jpg")
    order = user.orders.create
    order.order_trips.create(trip_id: trip.id,
                             quantity: 2)
    order.order_trips.create(trip_id: second_trip.id,
                             quantity: 1)
  end

  def user_logs_in
    visit login_path
    fill_in "Username", with: "BikeBro"
    fill_in "Password", with: "password"
    click_button "Login"
  end

  test 'user can view past trips' do
    user_orders_trips
    user_logs_in

    visit orders_path

    assert page.has_content? "Outdoor Adventure"
    assert page.has_content? "Oh so fun!"
    assert page.has_content? "125"
    assert page.has_content? "www.biking.jpeg"

    assert page.has_content? "Telluride Trek"
    assert page.has_content? "Wow!"
    assert page.has_content? "70"
    assert page.has_content? "telluride.jpg"
  end
end
