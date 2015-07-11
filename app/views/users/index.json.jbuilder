json.array!(@users) do |user|
  json.extract! user, :id, :name, :name, :email, :password, :email, :phone
  json.url user_url(user, format: :json)
end
