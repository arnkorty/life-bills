APP_ROOT = '/var/www/life_bills/current'
pidfile "#{APP_ROOT}/tmp/pids/puma.pid"
state_path "#{APP_ROOT}/tmp/pids/puma.state"
# access_log "#{APP_ROOT}/log/puma.access.log"
# error_log "#{APP_ROOT}/log/puma.error.log"
bind 'tcp://0.0.0.0:8977'
daemonize true
workers 2
threads 0,16
preload_app!
