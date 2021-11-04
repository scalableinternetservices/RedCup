class Comment < ApplicationRecord
  belongs_to :vlog
  belongs_to :user
end
