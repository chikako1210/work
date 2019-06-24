class Book < ApplicationRecord

	belongs_to :user

	validates :title, presence: true
	validates :body, {presence: true, length: { minimum: 2, maximum: 199 }}
end
