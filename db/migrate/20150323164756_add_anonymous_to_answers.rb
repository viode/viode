class AddAnonymousToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :anonymous, :boolean, default: false
  end
end
