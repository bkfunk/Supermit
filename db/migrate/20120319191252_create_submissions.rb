class CreateSubmissions < ActiveRecord::Migration
  def self.up
    create_table :submissions do |t|
      t.integer :user_id
      t.integer :piece_id
      t.integer :outlet_id
      t.text :desc
      t.string :submit_method
      t.datetime :submit_date
      t.text :submit_note
      t.string :response
      t.string :response_date
      t.text :response_note

      t.timestamps
    end
    add_index :submissions, [:user_id]
    add_index :submissions, [:submit_date, :response_date]
    add_index :submissions, [:piece_id]
    add_index :submissions, [:outlet_id]
  end
  
  def self.down
    drop_table :submissions
  end
end
