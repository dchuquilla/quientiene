# frozen_string_literal: true

require_relative '../../../rails_helper'

RSpec.describe Shop, type: :model do
  context 'Model DB constraints' do
    describe '::PRESENCE' do
      let(:user) { create(:user) }

      it 'should validate :name, :address, :ruc, :phone1, presence: true' do
        shop = build(:shop, user: user, name: nil, address: nil, ruc: nil, phone1: nil)

        aggregate_failures do
          expect(shop.valid?).not_to be_truthy
          expect(shop.errors.full_messages).to eq(['Nombre no puede estar en blanco',
                                                   'Dirección no puede estar en blanco',
                                                   'RUC no puede estar en blanco',
                                                   'Telefono celular no puede estar en blanco',
                                                   'RUC solo admite números',
                                                   'Telefono celular no es correcto '])
        end
      end
    end
  end
end
RSpec.describe Shop, type: :model do
  context 'Model DB constraints' do
    describe '::RUC' do
      let(:user) { create(:user) }

      it 'should validate RUC' do
        shop = create(:shop, user: user, ruc: '111')
        shop2 = create(:shop, user: user)
        shop_r = build(:shop, user: user, ruc: '111')
        shop_a = build(:shop, user: user, ruc: '11A')

        aggregate_failures do
          expect(shop.ruc).not_to eq(shop2.ruc)
          expect(shop_r.valid?).not_to be_truthy
          expect(shop_r.errors.full_messages).to eq(['RUC ya está en uso'])
          expect(shop_a.valid?).not_to be_truthy
          expect(shop_a.errors.full_messages).to eq(['RUC solo admite números'])
        end
      end
    end
  end
end
RSpec.describe Shop, type: :model do
  context 'Model DB constraints' do
    describe '::Phone1' do
      let(:user) { create(:user) }

      it 'should validate Phone1' do
        shop = build(:shop, user: user, phone1: '0222222')

        aggregate_failures do
          expect(shop.valid?).not_to be_truthy
          expect(shop.errors.full_messages).to eq(['Telefono celular no es correcto '])
        end
      end
    end
  end
end
