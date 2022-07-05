class Category < ApplicationRecord
  has_many :ports, dependent: :destroy
end
