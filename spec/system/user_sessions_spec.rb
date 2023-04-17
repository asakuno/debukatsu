require 'rails_helper'

RSpec.describe 'UserSessions', type: :system do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    context 'フォームの入力値が正常' do
      it 'ログイン処理が成功する' do
        visit login_path
        fill_in 'email', with: user.email
        fill_in 'password', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインに成功しました'
        expect(current_path).to eq foods_path
      end
    end

    context 'フォームが未入力' do
      it 'ログイン処理が失敗する' do
        visit login_path
        fill_in 'email', with: ''
        fill_in 'password', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインに失敗しました'
        expect(current_path).to eq login_path
      end
    end
  end

  describe 'ログイン後', js: true do
    context 'ログアウトボタンをクリック' do
      it 'ログアウト処理が成功する' do
        login_as(user)
        find('label#menu-button').click
        click_link 'ログアウト'
        begin
        page.accept_confirm do
          click_on :logout_button
        end
        rescue Selenium::WebDriver::Error::UnexpectedAlertOpenError
        sleep 1
        page.accept_confirm do
          click_on :logout_button
        end
      end
        expect(page).to have_content 'ログアウトしました'
        expect(current_path).to eq root_path
      end
    end
  end
end