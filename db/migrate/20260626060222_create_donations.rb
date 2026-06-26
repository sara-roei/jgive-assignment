class CreateDonations < ActiveRecord::Migration[8.1]
  def change
    create_table :donations do |t|
      t.references :campaign, null: false, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.string :donor_name
      t.string :display_preference, default: "full_name", null: false
      t.boolean :recurring, default: false, null: false
      t.text :dedication
      t.string :status, default: "pending", null: false

      t.timestamps
    end
  end
end
