# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.7'
# Use mysql as the database for Active Record
gem 'mysql2', '~> 0.5'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rspec-rails'
  gem 'capybara'
  gem 'webdrivers'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'bullet'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'foreman'
  gem 'spring'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'solargraph'
  gem 'annotate'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'rails-i18n'
# 認証機能
gem 'sorcery'
# ページネーション
gem 'kaminari'
# ActiveJob
gem 'sidekiq'
gem 'redis-rails'
# 画像アップロード
gem 'shrine'
gem 'aws-sdk-s3'
# 画像のリサイズ・バリデーション
gem 'image_processing'
gem 'mini_magick'
# バリデーション
gem 'stimulus-rails'
# タグ機能
gem 'acts-as-taggable-on'
# enum機能
gem 'enum_select_rails'
gem 'enum_help'
# データの更新
gem 'seed-fu'
# api通信
gem 'jb'
# チャート描画
gem 'chartkick'
# 検索機能
gem 'ransack'
# 環境変数
gem 'config'
# OGP, メタタグの設定
gem 'meta-tags'
