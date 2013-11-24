module MongoidExtensions
  def order(*args)
    begin 
      desc(*args)
    rescue => e 
      Rails.logger.warn e.to_s      
      self
    end
  end
end
# module Mongoid
#   class Criteria
#     include Mongoid::Extensions
#   end
# end