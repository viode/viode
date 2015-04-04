class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :subscribable_id
      t.string :subscribable_type
      t.integer :subscriber_id

      t.timestamps null: false
    end
    add_index :subscriptions, :subscriber_id
    add_index :subscriptions, [:subscribable_id, :subscribable_type]
  end
end
