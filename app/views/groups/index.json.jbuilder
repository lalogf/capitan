json.array!(@groups) do |group|
  json.extract! group, :id, :name, :description, :branch_id
  json.url group_url(group, format: :json)
end
