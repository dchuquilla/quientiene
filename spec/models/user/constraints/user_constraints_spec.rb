# frozen_string_literal: true

require_relative '../../../rails_helper'

RSpec.describe User, type: :model do
  context 'Model DB constraints' do
    describe '::uniqueness' do
      it 'should validate email' do
        user = create(:user, email: 'testeremail@tests.com')
        user2 = create(:user)
        user_r = build(:user, email: 'testeremail@tests.com')

        aggregate_failures do
          expect(user.email).not_to eq(user2.email)
          expect(user_r.valid?).not_to be_truthy
          expect(user_r.errors.full_messages).to eq(['Correo electrónico ya está en uso'])
        end
      end
    end
  end
end
