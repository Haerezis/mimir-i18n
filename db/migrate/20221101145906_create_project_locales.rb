class CreateProjectLocales < ActiveRecord::Migration[7.0]
  def change
    create_table :project_locales do |t|
      t.string :code, null: false
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
