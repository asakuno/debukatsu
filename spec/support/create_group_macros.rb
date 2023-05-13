module CreateGroupMacros
  def create_group(user)
    visit new_group_path
    fill_in 'group_group_name', with: "testケース成功"
    fill_in 'maximum_amount_value', with: 1100
    choose "group_publish_true"
    click_button '全チェック'
    click_button '登録する'
  end
end