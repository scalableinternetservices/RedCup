class Vlog < ApplicationRecord
	belongs_to :user
	has_many :comments
	has_many :likes
	validates :title, :content, presence: true
	has_one_attached :file
end
