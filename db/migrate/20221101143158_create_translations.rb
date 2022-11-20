class CreateTranslations < ActiveRecord::Migration[7.0]
  def change
    create_table :translations do |t|
      t.references :project, foreign_key: true

      t.text :locale
      t.string :key
      t.text :value

      t.timestamps

      t.index [:project_id, :locale, :key], unique: true
    end
  end
end
