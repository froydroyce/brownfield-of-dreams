require 'rails_helper'

describe GithubService do
  context "instance methods" do
    context "#repos_by_updated_at" do
      it "returns repo data" , :js, :vcr do
        repos = subject.repos_by_updated_at("froydroyce")

        expect(repos).to be_a Array
        expect(repos[0]).to be_an Hash
        expect(repos.count).to eq 30
        repo_data = repos.first

        expect(repo_data).to have_key :name
        expect(repo_data).to have_key :html_url
      end
    end
  end
end
