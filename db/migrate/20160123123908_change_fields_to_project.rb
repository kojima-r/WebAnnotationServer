class ChangeFieldsToProject < ActiveRecord::Migration
  def change
	change_column :projects, :name, :string, null: false
    change_column :projects, :tf, :string, null: false

    change_column :projects, :loc_src_num, :integer, null: false

    change_column :projects, :loc_thresh, :float, null: false

    change_column :projects, :loc_lowest_freq, :string, null: false

    change_column :projects, :sep_pause, :integer, null: false

    change_column :projects, :sep_min_interval, :integer, null: false

    change_column :projects, :sep_lowest_freq, :integer, null: false

 
  end
end
