class AddProvinceToCustomers < ActiveRecord::Migration[7.0]
  def change
    add_reference :customers, :province, null: true, foreign_key: true
  end
end