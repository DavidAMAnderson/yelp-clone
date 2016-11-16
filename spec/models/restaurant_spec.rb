require "rails_helper"
describe "Restaurant", type: :model do
  it "is not valid with a name shorter than 3 chars" do
    restaurant = Restaurant.new(name: "kf")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it "is not valid unless the name is unique" do
    user = User.create(email: 'joe@joe.com', password: 'joejoe', password_confirmation: 'joejoe')
    Restaurant.create(name: "Chicken Inn", user_id: user.id)
    restaurant = Restaurant.new(name: "Chicken Inn")
    expect(restaurant).to have(1).error_on :name
  end

end
