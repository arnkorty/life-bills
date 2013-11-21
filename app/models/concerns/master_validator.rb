class MasterValidator < ActiveModel::Validator
  def validate(record)
    return if record.user_id.blank? || record.name.blank?
    h = {:item=>:items, :person=>:people, :account=>:accounts}
    result = record.user.send(h[record.class.to_s.downcase.to_sym ]).where(name: record.name)    
    result = result.where(:id.ne => record.id) unless record.new_record?
    unless result.blank?
      record.errors[:name ] << 'name must uniq'
    end
  end
end
