class CreateTranslationValues < ActiveRecord::Migration[7.0]
  def change
    create_table :translation_values do |t|
      t.references :translation_key, foreign_key: true

      t.text :locale
      t.text :value

      t.timestamps

      t.index [:translation_key_id, :locale], unique: true
    end
  end
end
