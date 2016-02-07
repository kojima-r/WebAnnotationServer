class AddUsernameToProduct < ActiveRecord::Migration
  def change
    add_column :products, :username, :string
  end
end
