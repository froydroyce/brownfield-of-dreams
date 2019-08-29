require 'rails_helper'

describe 'As a registered user' do
  describe 'When I visit the dashboard' do
    it "I can send an email invitation" do
      user_1 = create(:user)
      user_2 = create(:user, email: 'rfcasco@gmail.com')
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
      repo_response = File.open("./fixtures/github_repos.json")
      stub_request(:get, "https://api.github.com/user/repos?sort=updated_at&access_token=#{ENV['GITHUB_TEST_TOKEN']}").
        to_return(status: 200, body: repo_response)
      follower_response = File.open("./fixtures/github_followers.json")
      stub_request(:get, "https://api.github.com/user/followers?access_token=#{ENV['GITHUB_TEST_TOKEN']}").
        to_return(status: 200, body: follower_response)
      following_response = File.open("./fixtures/github_following.json")
      stub_request(:get, "https://api.github.com/user/following?access_token=#{ENV['GITHUB_TEST_TOKEN']}").
        to_return(status: 200, body: following_response)
      github_user_response = File.open("./fixtures/github_user.json")
      stub_request(:get, "https://api.github.com/users/renecasco?access_token=#{ENV['GITHUB_TEST_TOKEN']}").
        to_return(status: 200, body: github_user_response)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit dashboard_path

      click_button 'Connect to Github'

      click_button 'Send an Invite'

      expect(current_path).to eq(new_invite_path)

      fill_in 'Github Username', with: "renecasco"

      click_button 'Send Invite'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Successfully sent invite!')

      email = open_email(user_2.email)
      expect(email).to deliver_to(user_2.email)

      visit new_invite_path

      fill_in 'Github Username', with: "not_rene"

      click_button 'Send Invite'

      expect(current_path).to eq('/invites')
      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
    end
  end
end
