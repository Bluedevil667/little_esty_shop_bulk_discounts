require 'rails_helper'

RSpec.describe 'Bulk Discounts Show Page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Body Care')
    @merchant3 = Merchant.create!(name: 'Skin Care')
    @merchant4 = Merchant.create!(name: 'Nail Care')

    @discount1 = @merchant1.bulk_discounts.create!(percentage_discount: 0.20, quantity_threshold: 10, promo_name: '20% off 10+')
    @discount2 = @merchant1.bulk_discounts.create!(percentage_discount: 0.30, quantity_threshold: 15, promo_name: '30% off 15+')
    @discount3 = @merchant1.bulk_discounts.create!(percentage_discount: 0.40, quantity_threshold: 20, promo_name: '40% off 20+')
    @discount4 = @merchant1.bulk_discounts.create!(percentage_discount: 0.50, quantity_threshold: 25, promo_name: '50% off 25+')

    visit merchant_bulk_discount_path(@merchant1, @discount1)
  end

  describe 'Bulk Show page' do
    it 'displays the bulk discount quantity threshold and percentage discount' do
      expect(page).to have_content(@discount1.quantity_threshold)
      expect(page).to have_content(@discount1.percentage_discount * 100)
    end

    it 'has a button to edit the bulk discount' do
      expect(page).to have_button('Edit Discount')

      click_button 'Edit Discount'

      expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @discount1))
    end
  end
end