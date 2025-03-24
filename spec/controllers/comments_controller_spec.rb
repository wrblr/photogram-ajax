require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  render_views

  describe "create" do
    it "responds to js requests with js", points: 1 do
      owner = User.create(
        username: "test",
        email: "test@example.com",
        password: "password",
        avatar_image: "https://robohash.org/test.png"
      )

      author = User.create(
        username: "author",
        email: "author@example.com",
        password: "password",
        avatar_image: "https://robohash.org/author.png"
      )

      photo = Photo.create(
        caption: "hi there :3",
        image: "https://robohash.org/photo.png",
        owner: owner
      )

      sign_in author

      params = {
        comment: {
          author_id: author.id,
          photo_id: photo.id,
          body: "hi there"
        }
      }

      post :create, params: params, as: :js

      expect(response.media_type).to eq Mime[:js]
      expect(response.body).not_to be_blank
    end
  end

  describe "edit" do
    it "responds to js requests with js", points: 1 do
      owner = User.create(
        username: "test",
        email: "test@example.com",
        password: "password",
        avatar_image: "https://robohash.org/test.png"
      )

      author = User.create(
        username: "author",
        email: "author@example.com",
        password: "password",
        avatar_image: "https://robohash.org/author.png"
      )

      photo = Photo.create(
        caption: "hi there :3",
        image: "https://robohash.org/photo.png",
        owner: owner
      )

      comment = Comment.create(
        body: "comment body text",
        photo: photo,
        author: author
      )

      sign_in author

      get :edit, params: { id: comment.id }, as: :js, xhr: true

      expect(response.media_type).to eq Mime[:js]
      expect(response.body).not_to be_blank
    end
  end

  describe "update" do
    routes { Rails.application.routes }

    it "responds to js requests with js", points: 1 do
      owner = User.create(
        username: "test",
        email: "test@example.com",
        password: "password",
        avatar_image: "https://robohash.org/test.png"
      )

      author = User.create(
        username: "author",
        email: "author@example.com",
        password: "password",
        avatar_image: "https://robohash.org/author.png"
      )

      photo = Photo.create(
        caption: "hi there :3",
        image: "https://robohash.org/photo.png",
        owner: owner
      )

      comment = Comment.create(
        body: "comment body text",
        photo: photo,
        author: author
      )

      sign_in author

      params = {
        id: comment.id,
        comment: {
          body: "comment body text (updated)"
        }
      }

      patch :update, params: params, as: :js, xhr: true

      expect(response.media_type).to eq Mime[:js]
      expect(response.body).not_to be_blank
    end
  end

  describe "destroy" do
    it "responds to js requests with js", points: 1 do
      owner = User.create(
        username: "test",
        email: "test@example.com",
        password: "password",
        avatar_image: "https://robohash.org/test.png"
      )

      author = User.create(
        username: "author",
        email: "author@example.com",
        password: "password",
        avatar_image: "https://robohash.org/author.png"
      )

      photo = Photo.create(
        caption: "hi there :3",
        image: "https://robohash.org/photo.png",
        owner: owner
      )

      comment = Comment.create(photo: photo, author: author, body: "hi there!")

      sign_in author

      delete :destroy, params: { id: comment.id }, as: :js

      expect(response.media_type).to eq Mime[:js]
      expect(response.body).not_to be_blank
    end
  end
end
