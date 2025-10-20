module RecipesHelper
    def difficulty_color(difficulty)
        case difficulty
        when 'Easy' then 'success'
        when 'Medium' then 'warning'
        when 'Hard' then 'danger'
        else 'secondary'
        end
    end
end
