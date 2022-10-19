require_relative '../../../rails_helper'

RSpec.describe User, type: :model do
  context 'Model DB constraints' do
    describe '::uniqueness' do
      it 'should validate email' do
        user = create(:user)
        user2 = create(:user)
        expect(user.email).not_to eq(user2.email)
      end
    end
  end
end
