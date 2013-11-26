if defined?(Rails::Console)
  # if Moped.logger == Rails.logger
  #   Moped.
  Moped.logger = Logger.new($stdout)
end