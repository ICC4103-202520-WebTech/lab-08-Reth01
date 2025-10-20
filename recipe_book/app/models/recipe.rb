class Recipe < ApplicationRecord
    belongs_to :user
    has_rich_text :instructions

    validates :title, presence: true
    validates :cook_time, numericality: { only_integer: true, greater_than: 0 }
    validates :difficulty, inclusion: { in: ['Easy', 'Medium', 'Hard'] }

    default_scope -> { order(created_at: :desc) }
end
