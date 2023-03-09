require 'shrine'
require 'shrine/storage/file_system'
require 'shrine/storage/s3'

if Rails.env.production?
  s3_options = Rails.application.credentials.aws
  Shrine.storages = {
    cache: Shrine::Storage::S3.new(prefix: 'cache', **s3_options),
    store: Shrine::Storage::S3.new(prefix: 'store', **s3_options)
  }
else
  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'),
    store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/store')
  }

end

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
Shrine.plugin :presign_endpoint, presign_options: lambda { |request|
  # Uppy will send the "filename" and "type" query parameters
  filename = request.params['filename']
  type     = request.params['type']

  {
    content_disposition: ContentDisposition.inline(filename), # set download filename
    content_type: type, # set content type (defaults to "application/octet-stream")
    content_length_range: 0..(10 * 1024 * 1024)                   # limit upload size to 10 MB
  }
}
