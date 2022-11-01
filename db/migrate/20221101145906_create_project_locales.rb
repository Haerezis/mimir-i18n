class CreateProjectLocales < ActiveRecord::Migration[7.0]
  def change
    create_table :project_locales do |t|
      t.timestamps

      t.string :code, null: false
      t.references :project, foreign_key: true
    end
  end
end
