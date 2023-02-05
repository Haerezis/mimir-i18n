class CreateReleases < ActiveRecord::Migration[7.0]
  def change
    create_table :releases do |t|
      t.references :project, foreign_key: true

      t.text :export_data, null: false, comment: "I18n json file"

      t.timestamps
    end
  end
end
