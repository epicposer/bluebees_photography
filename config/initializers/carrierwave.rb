CarrierWave.configure do |config|
  # For Mongodb GridFS storage
  #config.grid_fs_database = "grokphoto_#{Rails.env}"
  #config.grid_fs_host = 'localhost'
  #config.grid_fs_access_url = "/images"
  #config.storage = :grid_fs
  
  # For Amazon S3 storage
  #config.s3_access_key_id = 'xxxxxx'
  #config.s3_secret_access_key = 'xxxxxx'
  #config.s3_bucket = 'name_of_bucket'
end