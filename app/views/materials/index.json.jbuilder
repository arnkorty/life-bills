json.array!(@materials) do |material|
  json.extract! material, :name, :content, :rule, :key_word, :delete_flag
  json.url material_url(material, format: :json)
end
