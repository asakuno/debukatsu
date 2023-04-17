require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    describe 'ユーザー新規登録' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの新規作成が成功する' do
          visit new_user_path
          fill_in 'user_name', with: user.name
          fill_in 'user_email', with: "rspec@rspec.com"
          fill_in 'user_password', with: 'password'
          fill_in 'user_password_confirmation', with: 'password'
          click_button '登録する'
          expect(page).to have_content 'ユーザーの作成に成功しました'
          expect(current_path).to eq root_path
        end
      end

      context '名前が未入力' do
        it 'ユーザーの新規作成が失敗する' do
          visit new_user_path
          fill_in 'user_name', with: ''
          fill_in 'user_email', with: user.email
          fill_in 'user_password', with: 'password'
          fill_in 'user_password_confirmation', with: 'password'
          expect(page).to have_content 'ユーザー名を入力してください'
        end
      end

      context 'メールアドレスが未入力' do
        it 'ユーザーの新規作成が失敗する' do
          visit new_user_path
          fill_in 'user_name', with: user.name
          fill_in 'user_email', with: ''
          fill_in 'user_password', with: 'password'
          fill_in 'user_password_confirmation', with: 'password'
          expect(page).to have_content 'メールアドレスを入力してください'
        end
      end

      context 'メールアドレスが異なるフォーマット' do
        it 'ユーザーの新規作成が失敗する' do
          visit new_user_path
          fill_in 'user_name', with: user.name
          fill_in 'user_email', with: 'a'
          fill_in 'user_password', with: 'password'
          fill_in 'user_password_confirmation', with: 'password'
          expect(page).to have_content '有効なメールアドレスを入力してください'
        end
      end

      context '登録済のメールアドレスを使用' do
        it 'ユーザーの新規作成が失敗する' do
          existed_user = create(:user)
          visit new_user_path
          fill_in 'user_name', with: existed_user.name
          fill_in 'user_email', with: existed_user.email
          fill_in 'user_password', with: 'password'
          fill_in 'user_password_confirmation', with: 'password'
          click_button '登録する'
          expect(page).to have_content '1 error prohibited this user from being saved'
          expect(page).to have_content 'メールアドレスはすでに存在します'
          expect(current_path).to eq users_path
        end
      end
    end

    describe 'マイページ' do
      context 'ログインしていない状態' do
        it '利用規約へのアクセスが成功する' do
          visit service_homes_path
          expect(page).to have_content('利用規約')
        end

        it 'プライバシーポリシーへのアクセスが成功する' do
          visit privacy_homes_path
          expect(page).to have_content('プライバシーポリシー')
        end

        it 'マイページへのアクセスが失敗する' do
          visit mypage_profile_path
          expect(page).to have_content('ログインしてください')
          expect(current_path).to eq login_path
        end

        it 'カレンダーへのアクセスが失敗する' do
          visit mypage_calendars_path
          expect(page).to have_content('ログインしてください')
          expect(current_path).to eq login_path
        end

        it 'いいね一覧へのアクセスが失敗する' do
          visit mypage_likes_path
          expect(page).to have_content('ログインしてください')
          expect(current_path).to eq login_path
        end

        it '食品一覧へのアクセスが失敗する' do
          visit foods_path
          expect(page).to have_content('ログインしてください')
          expect(current_path).to eq login_path
        end

        it '食べ合わせ一覧へのアクセスが失敗する' do
          visit groups_path
          expect(page).to have_content('ログインしてください')
          expect(current_path).to eq login_path
        end
      end
    end
  end

  describe 'ログイン後' do
    before { login_as(user) }

    describe 'ユーザー編集' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの編集が成功する' do
          visit edit_mypage_profile_path
          fill_in 'user_name', with: 'update_user'
          find("#user_age").find("option[value='school_child']").select_option
          find("#user_gender").find("option[value='male']").select_option
          find("#user_weight").find("option[value='low']").select_option
          fill_in 'user_profile_attributes_momentum', with: 5
          click_button '更新する'
          expect(page).to have_content('ユーザー情報を更新しました')
          expect(current_path).to eq mypage_profile_path
        end
      end

      context '名前が未入力' do
        it 'ユーザーの編集が失敗する' do
          visit edit_mypage_profile_path
          fill_in 'user_name', with: ''
          find("#user_age").find("option[value='school_child']").select_option
          find("#user_gender").find("option[value='male']").select_option
          find("#user_weight").find("option[value='low']").select_option
          fill_in 'user_profile_attributes_momentum', with: 5
          click_button '更新する'
          expect(page).to have_content('1 error prohibited this user from being saved')
          expect(page).to have_content('名前を入力してください')
          expect(current_path).to eq mypage_profile_path
        end
      end

      context '増やしたい体重量が未入力' do
        it 'ユーザーの編集が失敗する' do
          visit edit_mypage_profile_path
          fill_in 'user_name', with: 'update_user'
          find("#user_age").find("option[value='school_child']").select_option
          find("#user_gender").find("option[value='male']").select_option
          find("#user_weight").find("option[value='low']").select_option
          fill_in 'user_profile_attributes_momentum', with: ''
          click_button '更新する'
          expect(page).to have_content('1 error prohibited this user from being saved')
          expect(page).to have_content('増やしたい体重量は数値で入力してください')
          expect(current_path).to eq mypage_profile_path
        end
      end
    end
  end
end