json.array!(@debts) do |debt|
  json.extract! debt, :id, :from, :to, :quantity, :description
  json.url debt_url(debt, format: :json)
end
