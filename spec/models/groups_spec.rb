require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:group) { FactoryBot.create(:group) }
  describe 'validation' do
    context 'すべての要素が入力されている時' do
      it 'エラーが起こらない' do
        expect(group).to be_valid
        expect(group.errors).to be_empty
      end
    end

    context 'group_nameが未入力の時' do
      it 'エラーが起こる' do
        group_without_group_name = build(:group, group_name:"") 
        expect(group_without_group_name).to be_invalid
        expect { group_without_group_name.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'maximum_amountが未入力の時' do
      it 'エラーが起こる' do
        group_without_maximum_amount = build(:group, maximum_amount:"") 
        expect(group_without_maximum_amount).to be_invalid
        expect { group_without_maximum_amount.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'publishが未入力の時' do
      it 'エラーが起こる' do
        group_without_publish = build(:group, publish:"") 
        expect(group_without_publish).to be_invalid
        expect { group_without_publish.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
