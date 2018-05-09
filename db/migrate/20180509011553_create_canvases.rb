class CreateCanvases < ActiveRecord::Migration[5.2]
  def change
    create_table :canvases do |t|
      t.integer :singleton_guard
      t.string :pixels

      t.timestamps null: false
    end

    add_index(:canvases, :singleton_guard, :unique => true)
  end
end
