class MasterValidator < ActiveModel::Validator
  def validate(record)
    return if record.user_id.blank? || record.name.blank?
    h = {:item=>:items, :person=>:people, :account=>:accounts}
    unless record.user.send(h[record.class.to_s.downcase.to_sym ]).where(name: record.name).blank?
      record.errors[:name ] << 'name must uniq'
    end
  end
end
