class ChangeLocLowestFreqToProject < ActiveRecord::Migration
  def change
    change_column :projects, :loc_lowest_freq, :integer, null: false
  end
end
