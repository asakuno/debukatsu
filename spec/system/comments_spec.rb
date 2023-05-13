require 'rails_helper'

RSpec.describe "Comments", type: :system do
  let(:user)  { create(:user) }
  let(:another_user){ create(:user) }
  let(:comment) { create(:comment) }

  before do
    20.times do
      create(:food)
    end
  end

  describe 'コメントの新規投稿' do
    before { login_as(user) }
    context 'フォームの入力値が正常' do
      it '自分の投稿にコメントの新規投稿が成功する' do
        create_group(user)
        fill_in 'js-new-comment-body', with: "コメント投稿テスト"
        click_button 'コメント投稿'
        expect(page).to have_content('コメントの作成に成功しました')
        expect(page).to have_content(user.name)
        expect(page).to have_content('コメント投稿テスト')
      end
      it '他人の投稿にコメントの新規投稿が成功する' do
        group = create(:group, user: another_user)
        visit group_path(group)
        fill_in 'js-new-comment-body', with: "コメント投稿テスト"
        click_button 'コメント投稿'
        expect(page).to have_content('コメントの作成に成功しました')
        expect(page).to have_content(user.name)
        expect(page).to have_content('コメント投稿テスト')
      end
    end
    context 'フォームの入力値が異常' do
      it '投稿欄が空白だと投稿が失敗する' do
        create_group(user)
        fill_in 'js-new-comment-body', with: ""
        click_button 'コメント投稿'
        expect(page).not_to have_content(user.name)
        expect(page).not_to have_content('コメント投稿テスト')
      end
      it '投稿欄が100文字以上だと投稿が失敗する' do
        create_group(user)
        fill_in 'js-new-comment-body', with: Faker::Lorem.characters(number: 101)
        click_button 'コメント投稿'
        expect(page).not_to have_content(user.name)
        expect(page).not_to have_content('コメント投稿テスト')
      end
    end
  end
  describe 'コメントの削除' do
    before { login_as(user) }
    context '正常系' do
      it 'コメントの削除が成功する' do
        group = create(:group, user: user)
        comment = create(:comment, user: user, group: group)
        visit group_path(group)
        find("#js-comment-delete-button-for-#{comment.id}").click
        expect(page).not_to have_content(comment.body)
        expect(page).not_to have_content(comment.user.name)
      end
    end
  end
end
