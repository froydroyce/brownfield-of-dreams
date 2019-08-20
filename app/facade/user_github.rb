class UserGithub
  def initialize(username)
    @username = username
  end

  def repos
    user_repos(@username).map do |repo|
      Repo.new(repo)
    end.first(5)

  end

  private

  def user_repos(username)
    @_user_repos ||= service.repos_by_updated_at(username)
  end

  def service
    @_service ||= GithubService.new
  end
end
