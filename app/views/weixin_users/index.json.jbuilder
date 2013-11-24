json.array!(@weixin_users) do |weixin_user|
  json.extract! weixin_user, :user_id, :name, :delete_flag
  json.url weixin_user_url(weixin_user, format: :json)
end
