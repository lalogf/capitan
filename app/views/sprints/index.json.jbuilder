json.array!(@sprints) do |sprint|
  json.extract! sprint, :id, :name, :description
  json.url sprint_url(sprint, format: :json)
end
