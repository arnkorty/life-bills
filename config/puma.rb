APP_ROOT = '/var/www/life_bills/current'
PUMA_PIDS_DIR = "#{APP_ROOT}/tmp/pids"
unless File.exist? PUMA_PIDS_DIR
  require 'fileutils'
  FileUtils.mkdir_p PUMA_PIDS_DIR
end
pidfile "#{PUMA_PIDS_DIR}/puma.pid"
state_path "#{PUMA_PIDS_DIR}/puma.state"
# access_log "#{APP_ROOT}/log/puma.access.log"
# error_log "#{APP_ROOT}/log/puma.error.log"
bind  'unix:///tmp/life_bills.socket'
# bind 'tcp://0.0.0.0:8977'
daemonize true
workers 2
threads 4,16
environment 'production'
preload_app!
