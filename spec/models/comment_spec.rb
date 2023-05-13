require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { FactoryBot.create(:comment) }
  describe 'validation' do
    context 'コメント内容が入力されているとき' do
      it 'エラーが起こらない' do
        expect(comment).to be_valid
        expect(comment.errors).to be_empty
      end
    end
    context 'コメント内容が未入力の時' do
      it 'エラーが起こる' do
        comment_without_coment_body = build(:comment, body:"") 
        expect(comment_without_coment_body).to be_invalid
        expect { comment_without_coment_body.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
    context 'コメント内容が101文字以上の時' do
      it 'エラーが起こる' do
        comment_over_coment_body = build(:comment, body: Faker::Lorem.characters(number: 101)) 
        expect(comment_over_coment_body).to be_invalid
        expect { comment_over_coment_body.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
