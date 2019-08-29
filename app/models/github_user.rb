class GithubUser
  attr_reader :username, :email

  def initialize(attributes = {})
    @username = attributes[:login]
    @email = attributes[:email]
  end
end
