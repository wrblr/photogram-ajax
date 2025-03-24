require "rails_helper"

RSpec.describe FollowRequestsController, type: :controller do
  render_views

  describe "create" do
    it "responds to js requests with js", points: 1 do
      sender = User.create(
        username: "sender",
        email: "sender@example.com",
        password: "password",
        avatar_image: "https://robohash.org/sender.png"
      )

      recipient = User.create(
        username: "recipient",
        email: "recipient@example.com",
        password: "password",
        avatar_image: "https://robohash.org/recipient.png"
      )

      sign_in sender

      params = { follow_request: { recipient_id: recipient.id, status: "pending" } }

      post :create, params: params, as: :js

      expect(response.media_type).to eq Mime[:js]
      expect(response.body).not_to be_blank
    end
  end

  describe "destroy" do
    it "responds to js requests with js", points: 1 do
      sender = User.create(
        username: "sender",
        email: "sender@example.com",
        password: "password",
        avatar_image: "https://robohash.org/sender.png"
      )

      recipient = User.create(
        username: "recipient",
        email: "recipient@example.com",
        password: "password",
        avatar_image: "https://robohash.org/recipient.png"
      )

      follow_request = FollowRequest.create(
        sender: sender,
        recipient: recipient,
        status: "pending"
      )

      sign_in sender

      delete :destroy, params: { id: follow_request.id }, as: :js

      expect(response.media_type).to eq Mime[:js]
      expect(response.body).not_to be_blank
    end
  end
end
