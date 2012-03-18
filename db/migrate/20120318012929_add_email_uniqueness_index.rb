class AddEmailUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_index :users, :email, :unique => true
  end

  def self.down
    remove_index :users, :email
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
  end
end
