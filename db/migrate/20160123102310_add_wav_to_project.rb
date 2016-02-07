class AddWavToProject < ActiveRecord::Migration
  def change
    add_column :projects, :wav, :string
  end
end
