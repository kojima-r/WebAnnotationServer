class Label < ActiveRecord::Base
  has_many :local_labels
  has_many :projects, through: :local_labels
end
