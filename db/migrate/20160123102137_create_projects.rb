class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :username
      t.integer :status

      t.timestamps null: false
    end
  end
end
