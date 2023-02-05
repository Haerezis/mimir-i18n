class CreateAccessKeys < ActiveRecord::Migration[7.0]
  def change
    create_table :access_keys do |t|
      t.references :project, foreign_key: true

      t.string :name, null: false
      t.string :value, null: false

      t.timestamps

      t.index [:project_id, :value], unique: true
    end
  end
end
