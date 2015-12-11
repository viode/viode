class AddClosedToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :closed, :boolean, default: false, null: false
  end
end
