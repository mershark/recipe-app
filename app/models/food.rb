class Food < ApplicationRecord
  belongs_to :user, foreign_key: 'users_id'
  belongs_to :recipe, optional: true
end
