json.array!(@weixin_web_bills) do |weixin_web_bill|
  json.extract! weixin_web_bill, 
  json.url weixin_web_bill_url(weixin_web_bill, format: :json)
end
