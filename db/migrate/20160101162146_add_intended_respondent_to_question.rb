class AddIntendedRespondentToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :intended_respondent_id, :integer

    add_index :questions, :intended_respondent_id
  end
end
