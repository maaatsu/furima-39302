class RemoveUserIdFromItems < ActiveRecord::Migration[6.0]
  def change
    def change
      remove_index :items, name: "index_items_on_user_id"
      remove_column :items, :user_id
    end   
  end
end
