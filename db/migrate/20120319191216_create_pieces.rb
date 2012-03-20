class CreatePieces < ActiveRecord::Migration
  def self.up
    create_table :pieces do |t|
      t.integer :user_id
      t.string :title
      t.text :desc
      t.string :genre

      t.timestamps
    end
    add_index :pieces, [:user_id]
    add_index :pieces, [:title]
  end
  
  def self.down
    drop_table :pieces
  end
end
