class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, 'in progress', :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_discounted_amount
    invoice_items.sum do |invoice_item|
      bulk_discount = invoice_item.item.merchant.bulk_discounts
                                           .where("bulk_discounts.quantity_threshold <= ?", invoice_item.quantity)
                                           .order(percentage_discount: :desc)
                                           .first
      bulk_discount ? (invoice_item.quantity * invoice_item.unit_price * bulk_discount.percentage_discount) : 0
    end
  end
  

  def total_discounted_revenue
    total_revenue - total_discounted_amount
  end
end
