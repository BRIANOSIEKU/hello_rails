class CreateFacts < ActiveRecord::Migration[7.0]
  def change
    create_table :facts do |t|
      t.text :fact, null: false
      t.integer :likes, default: 0, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
