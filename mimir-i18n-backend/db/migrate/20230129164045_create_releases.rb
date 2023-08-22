class CreateReleases < ActiveRecord::Migration[7.0]
  def change
    create_table :releases do |t|
      t.references :project, foreign_key: true

      t.string :sha, comment: "export_data SHA hash"
      t.text :message, null: false, comment: "commit message"
      t.text :export_data, null: false, comment: "I18n json file"

      t.timestamps
    end
  end
end
