class CreatePermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :permissions do |t|
      t.string :name
      t.boolean :add
      t.boolean :edit
      t.boolean :remove

      t.timestamps
    end
  end
end
