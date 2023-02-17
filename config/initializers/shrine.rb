require 'shrine/storage/file_system'
require 'shrine/storage/s3'
 
# アップロードするディレクトリの指定

  s3_options = {
      access_key_id:     'AKIAYO2Q2AFXMXP6WDXS',
      secret_access_key: '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',
      region:            'ap-northeast-1',
      bucket:            'debukatsu',
  }
 
  Shrine.storages = {
      cache: Shrine::Storage::S3.new(prefix: 'cache', **s3_options),
      store: Shrine::Storage::S3.new(prefix: 'store', **s3_options),
  }
 
# 使用するプラグインの宣言
Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data # for forms
Shrine.plugin :restore_cached_data
