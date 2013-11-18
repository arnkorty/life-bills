json.array!(@items) do |item|
  json.extract! item, :name, :parent_id
  json.url item_url(item, format: :json)
end
