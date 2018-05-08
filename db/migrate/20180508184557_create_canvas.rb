class CreateCanvas < ActiveRecord::Migration[5.2]
  def change
    create_table :canvas do |t|
      t.jsonb :pixels

      t.timestamps
    end
  end
end
