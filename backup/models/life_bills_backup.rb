# encoding: utf-8

##
# Backup Generated: life_bills_backup
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t life_bills_backup [-c <path_to_configuration_file>]
#
Model.new(:life_bills_backup, 'backup life_bills data') do
  ##
  # Split [Splitter]
  #
  # Split the backup file in to chunks of 250 megabytes
  # if the backup file size exceeds 250 megabytes
  #
  split_into_chunks_of 250

  ##
  # MongoDB [Database]
  #
  database MongoDB do |db|
    db.name               = "life_bills_production"
    db.host               = "localhost"
    db.port               = 27017
    db.ipv6               = false
    # db.only_collections   = ["bills", "users", "accounts"]
    db.additional_options = []
    db.lock               = true
    db.oplog              = false
  end

  ##
  # Dropbox File Hosting Service [Storage]
  #
  # Access Type:
  #
  #  - :app_folder (Default)
  #  - :dropbox
  #
  # Note:
  #
  #  Initial backup must be performed manually to authorize
  #  this machine with your Dropbox account.
  #
  store_with Dropbox do |db|
    db.api_key     = "cgpl3kqjkf6oxj3"
    db.api_secret  = "z48vxycsos6t6vn"
    db.access_type = :app_folder
    db.path        = "/life_bills/backups"
    db.keep        = 25
  end

  ##
  # RSync::Push [Syncer]
  #
  # The default `mode` is :ssh, which does not require the use
  # of an rsync daemon on the remote. If you wish to connect
  # directly to an rsync daemon, or via SSH using daemon features,
  # :rsync_daemon and :ssh_daemon modes are also available.
  # See the documentation on the Wiki for details.
  # https://github.com/meskyanichi/backup/wiki/Syncers
  #
  # sync_with RSync::Push do |rsync|
  #   rsync.mode     = :ssh
  #   rsync.host     = "123.45.678.90"
  #   rsync.path     = "~/backups"
  #   rsync.mirror   = true
  #   rsync.compress = true

  #   rsync.directories do |directory|
  #     directory.add "/var/apps/my_app/public/uploads"
  #     directory.add "/var/apps/my_app/logs"

  #     # Exclude files/folders.
  #     # Each pattern will be passed to rsync's `--exclude` option.
  #     #
  #     # Note: rsync is run using the `--archive` option,
  #     #       so be sure to read the `FILTER RULES` in `man rsync`.
  #     directory.exclude '*~'
  #     directory.exclude 'tmp/'
  #   end
  # end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip

  ##
  # Mail [Notifier]
  #
  # The default delivery method for Mail Notifiers is 'SMTP'.
  # See the Wiki for other delivery options.
  # https://github.com/meskyanichi/backup/wiki/Notifiers
  #
  notify_by Mail do |mail|
    mail.on_success           = true
    mail.on_warning           = true
    mail.on_failure           = true

    mail.from                 = "fumes4774@163.com"
    mail.to                   = "arnkorty.fu@gmail.com"
    mail.address              = "smtp.163.com"
    mail.port                 =  25
    mail.domain               = "163.com"
    mail.user_name            = "fumes4774"
    mail.password             = "477464974"
    mail.authentication       = "plain"
    mail.encryption           = :starttls
  end

end
