require 'rails_helper'

RSpec.describe "Foods", type: :system do
  let(:user)  { create(:user) }
  describe '食べ物の新規登録' do
    before { login_as(user) }
    context 'フォームの入力値が正常' do
      it '食べ物の新規作成が成功する' do
        visit new_food_path
        fill_in 'food_food_name', with: "パン"
        fill_in 'food_calorie', with: 110
        fill_in 'food_price', with: 100
        fill_in 'food_protein', with: 10
        fill_in 'food_lipid', with: 10
        fill_in 'food_sugar', with: 10
        fill_in 'food_dietary_fiber', with: 10
        fill_in 'food_table_salt', with:10
        click_button '登録する'
        expect(page).to have_content '食品を追加しました'
        expect(current_path).to eq foods_path
      end
    end

    context '名前が未入力' do
      it '食べ物の新規作成が失敗する' do
        visit new_food_path
        fill_in 'food_food_name', with: ""
        fill_in 'food_calorie', with: 110
        fill_in 'food_price', with: 100
        fill_in 'food_protein', with: 10
        fill_in 'food_lipid', with: 10
        fill_in 'food_sugar', with: 10
        fill_in 'food_dietary_fiber', with: 10
        fill_in 'food_table_salt', with:10
        expect(page).to have_content '食品名を入力してください'
        expect(current_path).to eq new_food_path
      end
    end

    context '食品名が20文字以上' do
      it '食べ物の新規作成が失敗する' do
        visit new_food_path
        fill_in 'food_food_name', with: "これは20文字以上が弾かれるかどうかを確認するテストです。"
        fill_in 'food_calorie', with: 110
        fill_in 'food_price', with: 100
        fill_in 'food_protein', with: 10
        fill_in 'food_lipid', with: 10
        fill_in 'food_sugar', with: 10
        fill_in 'food_dietary_fiber', with: 10
        fill_in 'food_table_salt', with:10
        click_button '登録する'
        expect(page).to have_no_selector("登録する")
        expect(page).to have_content '食品の追加に失敗しました'
      end
    end

    context 'カロリーが未入力' do
      it '食べ物の新規作成が失敗する' do
        visit new_food_path
        fill_in 'food_food_name', with: "パン"
        fill_in 'food_calorie', with: ''
        fill_in 'food_price', with: 100
        fill_in 'food_protein', with: 10
        fill_in 'food_lipid', with: 10
        fill_in 'food_sugar', with: 10
        fill_in 'food_dietary_fiber', with: 10
        fill_in 'food_table_salt', with:10
        expect(page).to have_no_selector("登録する")
        expect(current_path).to eq new_food_path
      end
    end

    context '値段が未入力' do
      it '食べ物の新規作成が失敗する' do
        visit new_food_path
        fill_in 'food_food_name', with: "パン"
        fill_in 'food_calorie', with: 110
        fill_in 'food_price', with: ''
        fill_in 'food_protein', with: 10
        fill_in 'food_lipid', with: 10
        fill_in 'food_sugar', with: 10
        fill_in 'food_dietary_fiber', with: 10
        fill_in 'food_table_salt', with:10
        expect(page).to have_no_selector("登録する")
        expect(current_path).to eq new_food_path
      end
    end
  end
end
