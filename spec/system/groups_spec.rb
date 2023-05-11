require 'rails_helper'

RSpec.describe "Groups", type: :system do
  describe 'FactoryBot' do
    it 'creates a valid group' do
      10.times do
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
end
