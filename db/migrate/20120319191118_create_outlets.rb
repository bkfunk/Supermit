class CreateOutlets < ActiveRecord::Migration
  def self.up
    create_table :outlets do |t|
      t.string :title
      t.text :desc
      t.string :url
      t.string :type
      t.string :genres
      t.string :submit_method
      t.string :affiliation
      t.date :submit_open_date
      t.date :submit_close_date

      t.timestamps
    end
    add_index :outlets, [:title]
  end
  
  def self.down
    drop_table :outlets
  end
end
