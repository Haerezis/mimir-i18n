class CreateTranslationKeys < ActiveRecord::Migration[7.0]
  def change
    create_table :translation_keys do |t|
      t.references :project, foreign_key: true

      t.string :key

      t.timestamps

      t.index [:project_id, :key], unique: true
    end
  end
end
