json.array!(@projects) do |project|
  json.extract! project, :id, :name, :username, :status
  json.url project_url(project, format: :json)
end
