class CreateTodos < ActiveRecord::Migration
  def self.up
    create_table :todos do |t|
      t.integer :user_id
      t.string :title
      t.string :desc
      t.integer :parent_id
      t.datetime :due_at
      t.boolean :has_time_due
      t.integer :journal_id
      t.integer :story_id
      t.boolean :is_complete
      t.datetime :completed_date

      t.timestamps
    end
    add_index :todos, [:user_id, :due_at]
    add_index :todos, [:journal_id, :due_at]
    add_index :todos, [:story_id, :due_at]
    add_index :todos, [:due_at, :parent_id, :id]
  end

  def self.down
    drop_table :todos
  end
end
