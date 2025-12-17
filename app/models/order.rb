class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy

  enum status: { new_order: "new_order", processing: "processing", shipped: "shipped", completed: "completed", cancelled: "cancelled" }

  validates :number, presence: true, uniqueness: true
  def human_status
    I18n.t("orders.statuses.#{status}")
  end

  def delivery_address_text
    return "Адреса не вказана" if shipping_address.blank?

    parts = []

    # Отримувач
    recipient = [
      shipping_address["first_name"],
      shipping_address["last_name"]
    ].compact.join(" ")

    parts << recipient if recipient.present?

    parts << "Тел: #{shipping_address["phone"]}" if shipping_address["phone"].present?
    parts << "Пошта: #{shipping_address["phone"]}" if shipping_address["email"].present?

    if shipping_address["delivery_type"].present?
      parts << case shipping_address["delivery_type"]
               when "courier" then "Курʼєр"
               when "branch" then "У відділення"
               when "postomat" then "У поштомат"
               else shipping_address["delivery_type"]
               end
    end

    if shipping_address["carrier"].present?
      parts << case shipping_address["carrier"]
               when "nova_poshta" then "Нова Пошта"
               when "ukrposhta" then "Укрпошта"
               else shipping_address["carrier"]
               end
    end

    address_parts = []

    address_parts << "м. #{shipping_address["city"]}" if shipping_address["city"].present?
    address_parts << "вул. #{shipping_address["street"]}" if shipping_address["street"].present?
    address_parts << "буд. #{shipping_address["house"]}" if shipping_address["house"].present?
    address_parts << " #{shipping_address["postal_code"]}" if shipping_address["postal_code"].present?

    if shipping_address["branch_number"].present?
      address_parts << "№ #{shipping_address["branch_number"]}"
    end

    parts << address_parts.join(", ") if address_parts.any?

    parts.join(" . ")
  end
end
