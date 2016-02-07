class Project < ActiveRecord::Base
  #
  has_many :user_projects
  has_many :users, through: :user_projects
  has_many :local_labels
  has_many :labels, through: :local_labels
  #
  mount_uploader :wav, WavUploader
  validates :name, presence: true, uniqueness: true
  validates :tf, presence: true
  validates :loc_thresh, presence: true
  validates :loc_lowest_freq, presence: true
  validates :sep_pause, presence: true
  validates :sep_min_interval, presence: true
  validates :sep_lowest_freq, presence: true
end
