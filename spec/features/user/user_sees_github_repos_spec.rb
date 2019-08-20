require 'rails_helper'

describe 'As a logged in user' do
  describe 'When I visit /dashboard' do
    describe 'Then I should see a section for Github' do
      it 'should see a list of 5 repositories with the name of each Repo linking to the repo on Github', :js, :vcr do
        user = create(:user, github_username: "froydroyce")

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit dashboard_path

        within(first(".github")) do
          expect(page).to have_content("Github")
          expect(page).to have_link("brownfield-of-dreams")
          expect(page).to have_link("rales_engine")
          expect(page).to have_link("jungle_beats")
          expect(page).to have_link("here-be-dragons")
          expect(page).to have_link("monster_shop_reroute")
        end
      end
    end
  end
end
