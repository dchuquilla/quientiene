require_relative '../../../rails_helper'

RSpec.describe User, type: :model do
  context 'Devise features' do
    describe 'database authenticatable' do
      it 'is database authenticable' do
        user = create(:user) # Use FactoryBot with shortcuts of rails_helpr.rb
        aggregate_failures do
          expect(user.valid_password?('Test123')).to be_truthy
          expect(user.valid_password?('Test1234')).not_to be_truthy
        end
      end
    end
  end
end
