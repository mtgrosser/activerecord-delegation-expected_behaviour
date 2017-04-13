ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do
  
  create_table :foos, :force => true do |t|
    t.string :name
  end
  
  create_table :bars, :force => true do |t|
    t.references :foo
    t.string :name
    t.integer :number
  end
  
end
