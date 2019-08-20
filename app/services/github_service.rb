class GithubService
  def repos_by_updated_at(username)
    get_json("/users/#{username}/repos?sort=updated_at&quantity")
  end

  private

  def conn
    Faraday.new(url: "https://api.github.com") do |f|
      f.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
