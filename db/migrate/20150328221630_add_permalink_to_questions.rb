class AddPermalinkToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :permalink, :string
    add_index :questions, :permalink
  end
end
