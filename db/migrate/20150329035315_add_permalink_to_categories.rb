class AddPermalinkToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :permalink, :string
    add_index :categories, :permalink
  end
end
