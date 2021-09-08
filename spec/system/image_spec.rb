require "rails_helper"

RSpec.feature "Image", :type => :feature do
  let(:user) { User.create(email: "test@example.com", password: "L0rem123#")}

  scenario "User should be logged in to add a new image" do
    visit new_image_path
    expect(current_path).to eq new_user_session_path 
  end

  context "Image upload" do 
    scenario "Logged in user can access image upload page" do
      sign_in user
      visit new_image_path
      expect(current_path).to eq new_image_path
    end

    scenario "Logged in user can access image upload page" do
      sign_in user
      visit new_image_path
      expect(current_path).to eq new_image_path
    end

    scenario "Logged in user can upload image" do
      sign_in user
      visit new_image_path
      image_name = "Sample Image "
      fill_in "image_name", with: image_name
      fill_in "image_tag_list", with: "Rainbow, color"
      attach_file("image_gif_file", Rails.root + "spec/fixtures/test_image.gif")

      click_on "Submit"
      expect(current_path).to eq images_path
      expect(page).to have_content image_name
    end

    
  end 
end