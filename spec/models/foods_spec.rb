require 'rails_helper'

RSpec.describe Food, type: :model do
  context '食品画像' do
    it '画像が添付できること' do
      food = build(:food)
      food.image_data = Rack::Test::UploadFile.new(File.join(Rails.root, 'spec/fixtures/images/test.png'))
      is_expected.to eq true
    end
  end
end