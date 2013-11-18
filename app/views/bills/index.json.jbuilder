json.array!(@bills) do |bill|
  json.extract! bill, :bill_type_id, :item_id, :account_id, :money, :person_id, :bill_time, :remark
  json.url bill_url(bill, format: :json)
end
