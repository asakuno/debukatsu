require 'rails_helper'

RSpec.describe "Groups", type: :system do
  describe 'FactoryBot' do
    it 'creates a valid group' do
      20.times do
        FactoryBot.create(:food)
      end
      group = FactoryBot.create(:group)
      
      expect(group).to be_valid
      expect(group.group_name).to be_present
      expect(group.maximum_amount).to be_present
      expect(group.publish).to be_in([true, false])
      expect(group.user).to be_present
    end
  end

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
end
