class InvitesMailer < ApplicationMailer
  def invite(github, current_user)
    @inviter = current_user.github_credentials.username
    @invitee = github.github_user.username
    mail(to: github.github_user.email, subject: "Invitation to Join Turing Tutorials")
  end
end
