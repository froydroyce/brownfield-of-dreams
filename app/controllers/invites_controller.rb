class InvitesController < ApplicationController
  def new
  end

  def create
    github = UserGithub.new(github_token, params[:username])
    if github.github_user.email
      InvitesMailer.invite(github, current_user).deliver_now
      flash[:notice] = "Successfully sent invite!"
      redirect_to dashboard_path
    else
      flash[:alert] = "The Github user you selected doesn't have an email address associated with their account."
      render :new
    end
  end
end
