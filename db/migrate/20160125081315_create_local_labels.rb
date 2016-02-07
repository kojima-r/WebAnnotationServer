class CreateLocalLabels < ActiveRecord::Migration
  def change
    create_table :local_labels do |t|
      t.integer :project_id
      t.integer :label_id
      t.integer :index
      t.string :color

      t.timestamps null: false
    end
  end
end
