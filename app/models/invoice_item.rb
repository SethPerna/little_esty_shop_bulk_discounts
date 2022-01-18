class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item
  has_many :bulk_discounts, through: :item
  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  def match_discount(id)
    bulk_discounts = BulkDiscount.order(:threshold)
    invoice_item = InvoiceItem.find(id)
    discount = nil
    bulk_discounts.each do |d|
      if invoice_item.quantity >= d.threshold
        discount = d
      end
    end
    discount
  end
end
