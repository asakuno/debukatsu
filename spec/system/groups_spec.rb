require 'rails_helper'

RSpec.describe "Groups", type: :system do

  let(:user)  { create(:user) }
  let(:group) { create(:group) }
  10.times do
    before { create(:food) }
  end
  describe '食べ合わせの新規登録' do
    before { login_as(user) }
    context 'フォームの入力値が正常' do
      it '食べ物の新規作成が成功し、groupsでも確認できる' do
        visit new_group_path
        fill_in 'group_group_name', with: "testケース成功"
        fill_in 'maximum_amount_value', with: 1100
        choose "group_publish_true"
        click_button '全チェック'
        click_button '登録する'
        expect(page).to have_content('作成に成功しました')
        expect(page).to have_content('testケース成功')

        visit groups_path
        expect(page).to have_content(user.name)
        expect(page).to have_content('testケース成功')
      end
      it '食べ物の新規作成が成功し、groupsでも確認できない(no_publish)' do
        visit new_group_path
        fill_in 'group_group_name', with: "testケース成功"
        fill_in 'maximum_amount_value', with: 1100
        choose "group_publish_false"
        click_button '全チェック'
        click_button '登録する'
        expect(page).to have_content('作成に成功しました')
        expect(page).to have_content('testケース成功')

        visit groups_path
        expect(page).not_to have_content(user.name)
        expect(page).not_to have_content('testケース成功')
      end
      it '食べ物の新規作成が成功し、groups/mineで確認できる(no_publish)' do
        visit new_group_path
        fill_in 'group_group_name', with: "testケース成功"
        fill_in 'maximum_amount_value', with: 1100
        choose "group_publish_false"
        click_button '全チェック'
        click_button '登録する'
        expect(page).to have_content('作成に成功しました')
        expect(page).to have_content('testケース成功')

        visit mine_groups_path
        expect(page).to have_content(user.name)
        expect(page).to have_content('testケース成功')
      end
    end
  end
  describe '食べ合わせの削除' do
    let!(:group) { create(:group, user: user) }
    context '正常系' do
      it '自分の食べ合わせが削除できる' do
        login_as(group.user)
        visit groups_path
        expect(page).to have_content(group.group_name)
        expect(page).to have_content(group.user.name)
        expect(page).to have_content('削除')
        find('#group_delete_button').click
        expect(page.accept_confirm).to eq "削除してもよろしいですか？"
        expect(page).to have_content "食べ合わせを削除しました"
        expect(current_path).to eq groups_path
        expect(page).not_to have_content group.group_name
      end
      it '他人の食べ合わせが削除できない' do
        another_user = FactoryBot.create(:user)
        login_as(another_user)
        visit groups_path
        expect(page).to have_content(group.group_name)
        expect(page).to have_content(group.user.name)
        expect(page).not_to have_content('削除')
      end
    end
  end
end
