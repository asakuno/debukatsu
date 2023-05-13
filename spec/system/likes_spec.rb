require 'rails_helper'

RSpec.describe "Groups", type: :system do
  let!(:user){ create(:user) }
  let(:another_user){ create(:user) }

  describe '食べ合わせの新規登録' do
    before { login_as(user) }
    context '正常系' do
      it '他人の投稿にいいねすることができる' do
        food = create(:food, user: another_user)
        visit foods_path
        find("#js-like-button-for-food-#{food.id}").click

        visit mypage_likes_path
        expect(page).to have_content(food.food_name)
        expect(page).to have_content(food.price)
        expect(page).not_to have_link('編集')
        expect(page).not_to have_link('削除')
      end
      it 'いいねした他人の投稿のいいねを消すことができる' do
        food = create(:food, user: another_user)
        visit foods_path
        find("#js-like-button-for-food-#{food.id}").click

        visit mypage_likes_path
        expect(page).to have_content(food.food_name)
        expect(page).to have_content(food.price)
        expect(page).not_to have_link('編集')
        expect(page).not_to have_link('削除')

        visit foods_path
        find("#js-like-button-for-food-#{food.id}").click
        visit mypage_likes_path
        visit mypage_likes_path
        expect(page).not_to have_content(food.food_name)
        expect(page).not_to have_content(food.price)
        expect(page).not_to have_link('編集')
        expect(page).not_to have_link('削除')
      end
    end
    context '異常系' do
      it '自分の投稿にいいねすることができない' do
        food = create(:food, user: user)

        visit foods_path
        expect(page).to have_link('編集')
        expect(page).to have_link('削除')
        expect(page).not_to have_selector("#js-like-button-for-food-#{food.id}")

        visit mypage_likes_path
        expect(page).not_to have_content(food.food_name)
        expect(page).not_to have_content(food.price)
        expect(page).not_to have_link('編集')
        expect(page).not_to have_link('削除')
      end
    end
  end
end
