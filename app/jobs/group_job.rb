class GroupJob < ApplicationJob
  queue_as :default

  def perform(*args)
    p 'Hello Rails.com'
  end
end
