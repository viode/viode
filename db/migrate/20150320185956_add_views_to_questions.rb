class AddViewsToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :views, :integer, default: 0
  end
end
