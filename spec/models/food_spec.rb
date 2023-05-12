require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:food) { FactoryBot.create(:food) }
  describe 'validation' do
    context 'すべての要素が入力されている時' do
      it 'エラーが起こらない' do
        expect(food).to be_valid
        expect(food.errors).to be_empty
      end
    end

    context 'food_nameが未入力の時' do
      it 'エラーが起こる' do
        food_without_food_name = build(:food, food_name:"") 
        expect(food_without_food_name).to be_invalid
        expect { food_without_food_name.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'calorieが未入力の時' do
      it 'エラーが起こる' do
        food_without_calorie = build(:food, calorie:"") 
        expect(food_without_calorie).to be_invalid
        expect { food_without_calorie.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'priceが未入力の時' do
      it 'エラーが起こる' do
        food_without_price = build(:food, price:"") 
        expect(food_without_price).to be_invalid
        expect { food_without_price.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'proteinが未入力の時' do
      it 'エラーが起こらない' do
        food_without_protein = build(:food, protein:"") 
        expect(food_without_protein).to be_valid
        expect(food_without_protein.errors).to be_empty
      end
    end

    context 'liqidが未入力の時' do
      it 'エラーが起こらない' do
        food_without_lipid = build(:food, lipid:"") 
        expect(food_without_lipid).to be_valid
        expect(food_without_lipid.errors).to be_empty
      end
    end

    context 'sugarが未入力の時' do
      it 'エラーが起こらない' do
        food_without_sugar = build(:food, sugar:"") 
        expect(food_without_sugar).to be_valid
        expect(food_without_sugar.errors).to be_empty
      end
    end

    context 'dietary_fiberが未入力の時' do
      it 'エラーが起こらない' do
        food_without_dietary_fiber = build(:food, dietary_fiber:"") 
        expect(food_without_dietary_fiber).to be_valid
        expect(food_without_dietary_fiber.errors).to be_empty
      end
    end

    context 'table_saltが未入力の時' do
      it 'エラーが起こらない' do
        food_without_table_salt = build(:food, table_salt:"") 
        expect(food_without_table_salt).to be_valid
        expect(food_without_table_salt.errors).to be_empty
      end
    end
  end
end