# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Clear existing data
Recipe.destroy_all
User.destroy_all

admin_user = User.create!(
  email: "admin@recipebook.com",
  password: "password123",
  password_confirmation: "password123",
  role: :admin
)

regular_user = User.create!(
  email: "user@recipebook.com",
  password: "password123",
  password_confirmation: "password123",
  role: :regular
)

puts "Created admin user: #{admin_user.email}"
puts "Created regular user: #{regular_user.email}"

# Sample recipes associated with the user
recipes = [
  {
    title: "Classic Chocolate Chip Cookies",
    cook_time: 30,
    difficulty: "Easy",
    instructions: "
      <h3>Ingredients:</h3>
      <ul>
        <li>2 ¼ cups all-purpose flour</li>
        <li>1 teaspoon baking soda</li>
        <li>1 teaspoon salt</li>
        <li>1 cup butter, softened</li>
        <li>¾ cup granulated sugar</li>
        <li>¾ cup packed brown sugar</li>
        <li>2 large eggs</li>
        <li>2 teaspoons vanilla extract</li>
        <li>2 cups chocolate chips</li>
      </ul>
      
      <h3>Instructions:</h3>
      <ol>
        <li>Preheat oven to 375°F (190°C).</li>
        <li>In a small bowl, mix flour, baking soda, and salt.</li>
        <li>In a large bowl, beat butter, granulated sugar, brown sugar, and vanilla until creamy.</li>
        <li>Add eggs one at a time, beating well after each addition.</li>
        <li>Gradually beat in flour mixture.</li>
        <li>Stir in chocolate chips.</li>
        <li>Drop by rounded tablespoon onto ungreased baking sheets.</li>
        <li>Bake for 9 to 11 minutes or until golden brown.</li>
        <li>Cool on baking sheets for 2 minutes; remove to wire racks to cool completely.</li>
      </ol>
    ",
    user: regular_user
  },
 {
    title: "Admin's Special Pasta",
    cook_time: 15,
    difficulty: "Easy",
    instructions: "
      <h3>Ingredients:</h3>
      <ul>
        <li>200g spaghetti</li>
        <li>2 cloves garlic</li>
        <li>3 tbsp olive oil</li>
        <li>1/2 tsp red pepper flakes</li>
        <li>Fresh parsley</li>
        <li>Salt and pepper to taste</li>
      </ul>
      
      <h3>Instructions:</h3>
      <ol>
        <li>Cook spaghetti according to package directions.</li>
        <li>While pasta cooks, sauté garlic in olive oil until fragrant.</li>
        <li>Add red pepper flakes and cook for 1 minute.</li>
        <li>Drain pasta and add to the garlic oil.</li>
        <li>Toss with chopped parsley, salt, and pepper.</li>
        <li>Serve immediately.</li>
      </ol>
    ",
    user: admin_user
  }
]

recipes.each do |recipe_attrs|
  user = recipe_attrs[:user]
  recipe = user.recipes.create!(
    title: recipe_attrs[:title],
    cook_time: recipe_attrs[:cook_time],
    difficulty: recipe_attrs[:difficulty]
  )
  recipe.instructions = recipe_attrs[:instructions]
  recipe.save!
end

puts "Created #{User.count} user and #{Recipe.count} sample recipes!"