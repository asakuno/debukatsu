require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it 'すべての要素が入力されている' do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    it '名前が空欄の時' do
      user_without_name = build(:user, name:"")
      expect(user_without_name).to be_invalid
      expect { user_without_name.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'パスワードが空欄の時' do
      user_without_password = build(:user, password:"")
      expect(user_without_password).to be_invalid
      expect { user_without_password.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'パスワード再確認が空欄の時' do
      user_without_password_confirmation = build(:user , password:"")
      expect(user_without_password_confirmation).to be_invalid
      expect { user_without_password_confirmation.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    context '同じパスワードでユーザーを作成したとき' do
      let(:user1) { FactoryBot.create(:user) }
      let(:user2) { FactoryBot.build(:user, email: user1.email) }
      it 'エラーが起こる' do
        expect { user2.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end