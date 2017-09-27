class CreateTexts < ActiveRecord::Migration[5.0]
  def change
    create_table :texts do |t|
    	t.string :status, null: false, default: "pending"
    	t.string :to, null: false
    	t.string :from, null: false
    	t.text :body, null: false
    	t.text :error
      t.timestamps
    end

    add_index :texts, [:status]
  end
end
