require "./connect_db.rb"
connect_db!

#"migration" - anycommand that modifies the structure of the database, like creating tables, or adding and removing columns from anexisting table,
ActiveRecord::Migration.create_table(:todos) do |t|
  t.column :todo_text, :text
  t.column :due_date, :date
  t.column :completed, :bool
end
