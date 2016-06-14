class AddBleu < ActiveRecord::Migration
  def change
    add_column :wing_orders, :bleu_cheese, :boolean, default: false
  end
end
