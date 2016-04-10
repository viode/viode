class AddIntendedRespondentToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :intended_respondent, :integer

    add_index :questions, :intended_respondent
  end
end
