class CreatePorts < ActiveRecord::Migration[7.0]
  def change
    create_table :ports do |t|
      t.string :name
      t.text :description
      t.string :summary
      t.string :url
      t.integer :category_id

      t.timestamps
    end
  end
end
