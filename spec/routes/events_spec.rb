require 'rails_helper'

RSpec.describe "routes for Events", type: :routing do
  it "routes /events to the events controller" do
    expect(get: "/events").to route_to("events#index")
    expect(post: "/events").to route_to("events#create")
  end

  it "routes /events/:id to the events controller" do
    expect(get: "/events/1").to route_to("events#show", id: "1")
    expect(patch: "/events/1").to route_to("events#update", id: "1")
    expect(put: "/events/1").to route_to("events#update", id: "1")
    expect(delete: "/events/1").to route_to("events#destroy", id: "1")
  end
end
