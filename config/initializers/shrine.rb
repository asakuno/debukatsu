require 'shrine'
require 'shrine/storage/file_system'
require "shrine/storage/s3"

if Rails.env.production?
  s3_options = Rails.application.credentials.aws
  Shrine.storages = {
      cache: Shrine::Storage::S3.new(prefix: 'cache', **s3_options),
      store: Shrine::Storage::S3.new(prefix: 'store', **s3_options)}
else
  Shrine.storages = {
      cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
      store: Shrine::Storage::FileSystem.new("public", prefix: "uploads/store")}

end

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
