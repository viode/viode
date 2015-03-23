class AddAnonymousToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :anonymous, :boolean, default: false
  end
end
