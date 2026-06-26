class CreateCampaigns < ActiveRecord::Migration[8.1]
  def change
    create_table :campaigns do |t|
      t.string :title, null: false
      t.text :description
      t.string :cover_image_url
      t.decimal :goal_amount, precision: 12, scale: 2, null: false

      t.timestamps
    end
  end
end
