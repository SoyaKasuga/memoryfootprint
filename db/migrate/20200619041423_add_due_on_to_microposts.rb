class AddDueOnToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :due_on, :date
  end
end
