require_relative '../../../rails_helper'

RSpec.describe User, type: :model do
  context 'Relationships' do
    describe 'Vehicles' do
      it 'should associate to vehicles' do
        user = create(:user) do |user|
          user.vehicles.create
        end
        expect(user.vehicles).not_to eq(nil)
      end
    end
  end
end
