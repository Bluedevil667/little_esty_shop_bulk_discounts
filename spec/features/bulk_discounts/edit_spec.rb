require 'rails_helper'

RSpec.describe 'Bulk Discount Edit Page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @bulk_discount1 = BulkDiscount.create!(percentage_discount: 0.2, quantity_threshold: 10, promo_name: "20% off 10 items", merchant_id: @merchant1.id)
    @bulk_discount2 = BulkDiscount.create!(percentage_discount: 0.1, quantity_threshold: 5, promo_name: "10% off 5 items", merchant_id: @merchant1.id)
  end

  describe 'when I visit the bulk discount edit page' do
    it 'I can edit the bulk discount' do
      visit edit_merchant_bulk_discount_path(@merchant1, @bulk_discount1)
      fill_in 'Percentage Discount', with: 0.15
      fill_in 'Quantity Threshold', with: 15
      fill_in 'Name', with: 'Buy 15, Get 15% Off'
      
      click_button 'Submit'
      
      expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @bulk_discount1))
      expect(page).to have_content("Buy 15, Get 15% Off")
      expect(page).to have_content("15.0%")
      expect(page).to have_content(15)
    end
  end
end