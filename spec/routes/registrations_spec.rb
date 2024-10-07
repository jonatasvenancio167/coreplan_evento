require 'rails_helper'

RSpec.describe "routes for Registrations", type: :routing do
  it "routes /registrations to the registrations controller" do
    expect(get: "/registrations").to route_to("registrations#index")
    expect(post: "/registrations").to route_to("registrations#create")
  end

  it "routes /registrations/:id to the registrations controller" do
    expect(get: "/registrations/1").to route_to("registrations#show", id: "1")
    expect(patch: "/registrations/1").to route_to("registrations#update", id: "1")
    expect(put: "/registrations/1").to route_to("registrations#update", id: "1")
    expect(delete: "/registrations/1").to route_to("registrations#destroy", id: "1")
  end
end
