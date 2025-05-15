require "rails_helper"

RSpec.describe SshkeysController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/sshkeys").to route_to("sshkeys#index")
    end

    it "routes to #show" do
      expect(get: "/sshkeys/1").to route_to("sshkeys#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/sshkeys").to route_to("sshkeys#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/sshkeys/1").to route_to("sshkeys#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/sshkeys/1").to route_to("sshkeys#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/sshkeys/1").to route_to("sshkeys#destroy", id: "1")
    end
  end
end
