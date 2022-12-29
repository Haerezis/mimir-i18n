class CreateUserProjectPermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :user_project_permissions do |t|
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true

      t.boolean :readonly, default: true

      t.timestamps
    end
  end
end
