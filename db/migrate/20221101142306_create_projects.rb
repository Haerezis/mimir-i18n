class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.timestamps

      t.string :name, null: false
    end
  end
end
