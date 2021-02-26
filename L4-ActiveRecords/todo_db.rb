#requires is similar to import
require "active_record"

# Todo class inherits from the ActiveRecord Base class
# name of the class - Singular
# name of the db table - plural

class Todo < ActiveRecord::Base
  def due_today?
    due_date == Date.today
  end

  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{display_status} #{todo_text} #{display_date}"
  end
end
