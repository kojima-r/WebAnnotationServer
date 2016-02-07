class AddParamsFieldsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :tf, :string
    add_column :projects, :loc_src_num, :integer
    add_column :projects, :loc_thresh, :float
    add_column :projects, :loc_lowest_freq, :string
    add_column :projects, :sep_pause, :integer
    add_column :projects, :sep_min_interval, :integer
    add_column :projects, :sep_lowest_freq, :integer
  end

end
