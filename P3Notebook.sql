CREATE DATABASE P3Final
GO
USE P3Final
GO


-- User
CREATE TABLE [user] (
    userID INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);


-- userPreferences
CREATE TABLE userPreferences (
    userID INT,
    preferences VARCHAR(MAX),
    PRIMARY KEY (userID),
    FOREIGN KEY (userID) REFERENCES [user](userID)
);


-- Recipe
CREATE TABLE recipe (
    recipeID INT IDENTITY(1,1) PRIMARY KEY,
    userID INT,
    name VARCHAR(255) NOT NULL,
    instructions VARCHAR(MAX) NOT NULL,
    protein DECIMAL(5,2) DEFAULT 0,
    fats DECIMAL(5,2) DEFAULT 0,
    carbs DECIMAL(5,2) DEFAULT 0,
    calories DECIMAL(6,2) DEFAULT 0,
    origin VARCHAR(100),
    cuisine VARCHAR(100),
    FOREIGN KEY (userID) REFERENCES [user](userID)
);


-- recipeTags
CREATE TABLE recipeTags (
    recipeID INT,
    tags VARCHAR(255) NOT NULL,
    PRIMARY KEY (recipeID, tags),
    FOREIGN KEY (recipeID) REFERENCES recipe(recipeID)
);


-- recipeCookingSupplies
CREATE TABLE recipeCookingSupplies (
    recipeID INT,
    cookingSupplies VARCHAR(255) NOT NULL,
    PRIMARY KEY (recipeID, cookingSupplies),
    FOREIGN KEY (recipeID) REFERENCES recipe(recipeID)
);


-- Review
CREATE TABLE review (
    reviewID INT IDENTITY(1,1) PRIMARY KEY,
    recipeID INT,
    userID INT,
    rating INT,
    date DATE NOT NULL,
    [public] BIT DEFAULT 1, -- Using BIT for boolean values
    comment VARCHAR(MAX),
    FOREIGN KEY (recipeID) REFERENCES recipe(recipeID),
    FOREIGN KEY (userID) REFERENCES [user](userID)
);


-- Plan
CREATE TABLE [plan] (
    planID INT IDENTITY(1,1) PRIMARY KEY,
    recipeID INT,
    date DATE NOT NULL,
    time TIME NOT NULL,
    FOREIGN KEY (recipeID) REFERENCES recipe(recipeID)
);


-- Ingredient
CREATE TABLE ingredient (
    ingredientID INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(100)
);


-- planIngredients
CREATE TABLE planIngredients (
    planID INT,
    ingredientID INT,
    amountNeeded VARCHAR(50) NOT NULL,
    PRIMARY KEY (planID, ingredientID),
    FOREIGN KEY (planID) REFERENCES [plan](planID),
    FOREIGN KEY (ingredientID) REFERENCES ingredient(ingredientID)
);


-- Saved
CREATE TABLE saved (
    userID INT,
    recipeID INT,
    tried BIT DEFAULT 0, -- Using BIT for boolean values
    PRIMARY KEY (userID, recipeID),
    FOREIGN KEY (userID) REFERENCES [user](userID),
    FOREIGN KEY (recipeID) REFERENCES recipe(recipeID)
);


-- userIngredients
CREATE TABLE userIngredients (
    userID INT,
    ingredientID INT,
    userAmount VARCHAR(50) NOT NULL,
    PRIMARY KEY (userID, ingredientID),
    FOREIGN KEY (userID) REFERENCES [user](userID),
    FOREIGN KEY (ingredientID) REFERENCES ingredient(ingredientID)
);


-- recipeIngredients
CREATE TABLE recipeIngredients (
    recipeID INT,
    ingredientID INT,
    recipeAmount VARCHAR(50) NOT NULL,
    PRIMARY KEY (recipeID, ingredientID),
    FOREIGN KEY (recipeID) REFERENCES recipe(recipeID),
    FOREIGN KEY (ingredientID) REFERENCES ingredient(ingredientID)
);


-- Substitutions
CREATE TABLE substitutions (
    ingredientID INT,
    substituteIngredientID INT,
    ratio DECIMAL(5,2) NOT NULL,
    PRIMARY KEY (ingredientID, substituteIngredientID),
    FOREIGN KEY (ingredientID) REFERENCES ingredient(ingredientID),
    FOREIGN KEY (substituteIngredientID) REFERENCES ingredient(ingredientID)
);
-- Check Constraints
ALTER TABLE review
ADD CONSTRAINT chk_rating CHECK (rating BETWEEN 1 AND 5);


ALTER TABLE recipe
ADD CONSTRAINT chk_calories CHECK (calories >= 0);


ALTER TABLE substitutions
ADD CONSTRAINT chk_positive_ratio CHECK (ratio > 0);


-- insertions


INSERT INTO [user] (name, username, password) VALUES
('Alice Johnson', 'alicej', 'pass123'),
('Bob Smith', 'bobsmith', 'mypassword'),
('Charlie Brown', 'charlieb', 'qwerty'),
('Diana Prince', 'dianap', 'wonderwoman'),
('Ethan Hunt', 'ethanh', 'secret'),
('Fiona Gallagher', 'fionag', 'shameless'),
('George Clark', 'georgec', 'passw0rd'),
('Hannah Baker', 'hannahb', 'reasons'),
('Isaac Newton', 'isaacn', 'gravity'),
('Jack Daniels', 'jackd', 'whiskey'),
('Mona Lisa', 'monalisa', 'artlover'),
('Nina Simone', 'ninas', 'music123'),
('Oscar Wilde', 'oscarw', 'bookworm'),
('Peter Parker', 'peterp', 'spidey'),
('Quinn Fabray', 'quinnf', 'glee'),
('Rachel Green', 'rachelg', 'fashion'),
('Tina Fey', 'tinaf', 'comedy'),
('Uma Thurman', 'umath', 'killbill'),
('Victor Hugo', 'victorh', 'lesmis'),
('Wanda Maximoff', 'wandam', 'scarletwitch'),
('Xander Harris', 'xanderh', 'vampires'),
('Yara Greyjoy', 'yarag', 'ironborn'),
('Zoe Saldana', 'zoes', 'starfleet'),
('Adam Driver', 'adamd', 'kylo'),
('Bella Swan', 'bellas', 'vampires2'),
('Cameron Diaz', 'camerond', 'actress'),
('Daniel Craig', 'danielc', 'bond007'),
('Emma Watson', 'emmaw', 'hermione'),
('Finn Hudson', 'finnh', 'singing'),
('Gina Rodriguez', 'ginar', 'latina'),
('Hugh Jackman', 'hughj', 'wolverine'),
('Iggy Azalea', 'iggya', 'rap'),
('Jenna Ortega', 'jenno', 'acting'),
('Keanu Reeves', 'keanur', 'matrix'),
('Lucy Liu', 'lucyl', 'charliesangels');


INSERT INTO userPreferences (userID, preferences) VALUES
(1, 'Vegetarian'),
(2, 'Low-carb'),
(3, 'Vegan'),
(4, 'Healthy'),
(5, 'Mexican'),
(6, 'Italian'),
(7, 'Dessert'),
(8, 'Quick Meals'),
(9, 'Seafood'),
(10, 'Breakfast'),
(11, 'Paleo'),
(12, 'Mediterranean'),
(13, 'Gluten-free'),
(14, 'Dairy-free'),
(15, 'Keto'),
(16, 'Comfort Food'),
(17, 'Asian'),
(18, 'Spicy'),
(19, 'Brunch'),
(20, 'Barbecue'),
(21, 'Farm-to-table'),
(22, 'Whole30'),
(23, 'Low-sugar'),
(24, 'Fermented Foods'),
(25, 'Fresh Herbs'),
(26, 'Superfoods'),
(27, 'Snacks'),
(28, 'Soups'),
(29, 'Salads'),
(30, 'Casseroles'),
(31, 'Baking'),
(32, 'Smoothies'),
(33, 'Savory'),
(34, 'Pasta'),
(35, 'Street Food');


INSERT INTO recipe (userID, name, instructions, protein, fats, carbs, calories, origin, cuisine) VALUES
(1, 'Stuffed Peppers', 'Fill peppers with quinoa and beans.', 8.00, 2.00, 25.00, 180.00, 'USA', 'Vegetarian'),
(2, 'Cauliflower Rice', 'Pulse cauliflower until rice-like.', 2.00, 0.50, 5.00, 30.00, 'India', 'Low-carb'),
(3, 'Chickpea Curry', 'Cook chickpeas with spices and tomatoes.', 10.00, 5.00, 45.00, 300.00, 'India', 'Vegan'),
(4, 'Grilled Chicken Salad', 'Grill chicken and serve with greens.', 30.00, 5.00, 10.00, 250.00, 'USA', 'Healthy'),
(5, 'Tacos', 'Fill tortillas with meat and toppings.', 25.00, 15.00, 30.00, 450.00, 'Mexico', 'Mexican'),
(6, 'Pasta Primavera', 'Toss pasta with fresh vegetables.', 15.00, 5.00, 75.00, 400.00, 'Italy', 'Italian'),
(7, 'Chocolate Cake', 'Bake a rich chocolate cake.', 5.00, 20.00, 50.00, 400.00, 'USA', 'Dessert'),
(8, 'Smoothie Bowl', 'Blend fruits and serve in a bowl.', 5.00, 5.00, 30.00, 250.00, 'USA', 'Quick Meals'),
(9, 'Grilled Salmon', 'Cook salmon with herbs.', 30.00, 15.00, 0.00, 350.00, 'Norway', 'Seafood'),
(10, 'Pancakes', 'Cook pancakes and serve with syrup.', 6.00, 8.00, 60.00, 300.00, 'USA', 'Breakfast'),
(11, 'Grilled Steak', 'Cook steak to preference.', 30.00, 20.00, 0.00, 400.00, 'USA', 'Paleo'),
(12, 'Greek Salad', 'Mix cucumber, tomato, and feta.', 4.00, 12.00, 15.00, 150.00, 'Greece', 'Mediterranean'),
(13, 'Almond Flour Cookies', 'Bake cookies using almond flour.', 5.00, 10.00, 15.00, 200.00, 'USA', 'Gluten-free'),
(14, 'Cauliflower Pizza Crust', 'Make a pizza crust using cauliflower.', 4.00, 2.00, 20.00, 180.00, 'USA', 'Dairy-free'),
(15, 'Zucchini Chips', 'Bake zucchini slices until crispy.', 3.00, 2.00, 8.00, 50.00, 'USA', 'Keto'),
(16, 'Mac and Cheese', 'Cook pasta and mix with cheese.', 10.00, 10.00, 60.00, 500.00, 'USA', 'Comfort Food'),
(17, 'Sushi Rolls', 'Roll rice with fish and vegetables.', 20.00, 5.00, 40.00, 350.00, 'Japan', 'Asian'),
(18, 'Chili Ramen', 'Prepare ramen with spicy broth.', 15.00, 8.00, 40.00, 300.00, 'Japan', 'Spicy'),
(19, 'French Toast', 'Dip bread in egg and cook.', 10.00, 8.00, 45.00, 350.00, 'USA', 'Brunch'),
(20, 'BBQ Ribs', 'Cook ribs with barbecue sauce.', 30.00, 20.00, 15.00, 600.00, 'USA', 'Barbecue'),
(21, 'Farmers Market Salad', 'Combine fresh local vegetables.', 4.00, 3.00, 12.00, 100.00, 'USA', 'Farm-to-table'),
(22, 'Zucchini Noodles with Meat Sauce', 'Serve zucchini noodles with meat sauce.', 25.00, 10.00, 15.00, 300.00, 'USA', 'Whole30'),
(23, 'Avocado Toast', 'Serve avocado on whole-grain bread.', 4.00, 10.00, 20.00, 300.00, 'USA', 'Low-sugar'),
(24, 'Kimchi Fried Rice', 'Fry rice with kimchi and vegetables.', 5.00, 1.00, 35.00, 250.00, 'Korea', 'Fermented Foods'),
(25, 'Herb-Infused Olive Oil', 'Infuse olive oil with fresh herbs.', 0.00, 14.00, 0.00, 120.00, 'Italy', 'Fresh Herbs'),
(26, 'Chia Seed Pudding', 'Soak chia seeds in almond milk.', 5.00, 10.00, 15.00, 150.00, 'USA', 'Superfoods'),
(27, 'Trail Mix', 'Combine nuts and dried fruits.', 5.00, 15.00, 30.00, 300.00, 'USA', 'Snacks'),
(28, 'Tomato Basil Soup', 'Blend tomatoes and basil.', 4.00, 2.00, 15.00, 100.00, 'USA', 'Soups'),
(29, 'Greek Salad', 'Combine cucumbers, tomatoes, and feta.', 4.00, 12.00, 15.00, 150.00, 'Greece', 'Salads'),
(30, 'Lasagna', 'Layer pasta, cheese, and meat.', 20.00, 15.00, 40.00, 600.00, 'Italy', 'Casseroles'),
(31, 'Banana Bread', 'Mix bananas and bake into bread.', 4.00, 5.00, 35.00, 250.00, 'USA', 'Baking'),
(32, 'Berry Smoothie', 'Blend berries with yogurt.', 4.00, 2.00, 20.00, 150.00, 'USA', 'Smoothies'),
(33, 'Herbed Rice', 'Cook rice with fresh herbs.', 4.00, 1.00, 20.00, 120.00, 'USA', 'Savory'),
(34, 'Spaghetti Aglio e Olio', 'Cook spaghetti with garlic and olive oil.', 8.00, 5.00, 40.00, 350.00, 'Italy', 'Pasta'),
(35, 'Falafel', 'Deep fry spiced chickpea balls.', 12.00, 10.00, 30.00, 250.00, 'Middle East', 'Street Food');


INSERT INTO recipeTags (recipeID, tags) VALUES
(1, 'Vegetarian'),
(2, 'Low-carb'),
(3, 'Vegan'),
(4, 'Healthy'),
(5, 'Mexican'),
(6, 'Italian'),
(7, 'Dessert'),
(8, 'Quick Meals'),
(9, 'Seafood'),
(10, 'Breakfast'),
(11, 'Paleo'),
(12, 'Mediterranean'),
(13, 'Gluten-free'),
(14, 'Dairy-free'),
(15, 'Keto'),
(16, 'Comfort Food'),
(17, 'Asian'),
(18, 'Spicy'),
(19, 'Brunch'),
(20, 'Barbecue'),
(21, 'Farm-to-table'),
(22, 'Whole30'),
(23, 'Low-sugar'),
(24, 'Fermented Foods'),
(25, 'Fresh Herbs'),
(26, 'Superfoods'),
(27, 'Snacks'),
(28, 'Soups'),
(29, 'Salads'),
(30, 'Casseroles'),
(31, 'Baking'),
(32, 'Smoothies'),
(33, 'Savory'),
(34, 'Pasta'),
(35, 'Street Food');


-- Inserting into recipeCookingSupplies
INSERT INTO recipeCookingSupplies (recipeID, cookingSupplies) VALUES
(1, 'Baking dish, Knife, Cutting board, Spoon'),
(2, 'Food processor, Knife, Bowl, Measuring cups'),
(3, 'Pot, Knife, Cutting board, Spoon'),
(4, 'Grill pan, Tongs, Knife, Salad bowl'),
(5, 'Skillet, Spatula, Knife, Serving plate'),
(6, 'Pot, Mixing bowl, Spoon, Knife'),
(7, 'Baking pan, Mixing bowl, Whisk, Measuring cups'),
(8, 'Blender, Bowl, Spoon, Knife'),
(9, 'Baking sheet, Grill, Tongs, Knife'),
(10, 'Skillet, Spatula, Mixing bowl, Measuring cups'),
(11, 'Grill pan, Tongs, Meat thermometer, Knife'),
(12, 'Salad bowl, Knife, Cutting board, Spoon'),
(13, 'Baking sheet, Mixing bowl, Whisk, Measuring cups'),
(14, 'Baking sheet, Knife, Grater, Mixing bowl'),
(15, 'Baking sheet, Knife, Oven, Bowl'),
(16, 'Pot, Baking dish, Measuring cups, Spoon'),
(17, 'Bamboo mat, Knife, Cutting board, Bowl'),
(18, 'Pot, Ladle, Knife, Bowl'),
(19, 'Skillet, Whisk, Mixing bowl, Measuring cups'),
(20, 'Grill, Tongs, Basting brush, Knife'),
(21, 'Salad bowl, Knife, Cutting board, Spoon'),
(22, 'Skillet, Knife, Spiralizer, Spoon'),
(23, 'Toaster, Knife, Cutting board, Bowl'),
(24, 'Wok, Spoon, Knife, Bowl'),
(25, 'Jar, Knife, Cutting board, Measuring cups'),
(26, 'Bowl, Measuring cups, Spoon, Fridge container'),
(27, 'Mixing bowl, Spoon, Container for storage'),
(28, 'Blender, Pot, Spoon, Knife'),
(29, 'Salad bowl, Knife, Spoon, Measuring cups'),
(30, 'Baking dish, Knife, Cutting board, Spoon'),
(31, 'Loaf pan, Mixing bowl, Measuring cups, Spoon'),
(32, 'Blender, Bowl, Spoon, Measuring cups'),
(33, 'Pot, Knife, Cutting board, Spoon'),
(34, 'Pot, Knife, Spoon, Strainer'),
(35, 'Frying pan, Spoon, Knife, Mixing bowl');


-- Inserting into review
INSERT INTO review (recipeID, userID, rating, date, [public], comment) VALUES
(1, 1, 5, '2024-10-01', 1, 'Delicious and easy to make!'),
(2, 2, 4, '2024-10-02', 1, 'Great low-carb option.'),
(3, 3, 5, '2024-10-03', 1, 'Best curry I’ve ever made!'),
(4, 4, 4, '2024-10-04', 1, 'A healthy and filling salad.'),
(5, 5, 3, '2024-10-05', 1, 'Good, but a bit too salty for my taste.'),
(6, 6, 4, '2024-10-06', 1, 'Love the fresh veggies in this!'),
(7, 7, 5, '2024-10-07', 1, 'Decadent and rich. Perfect dessert!'),
(8, 8, 4, '2024-10-08', 1, 'Quick and refreshing breakfast option.'),
(9, 9, 5, '2024-10-09', 1, 'Absolutely fantastic salmon!'),
(10, 10, 4, '2024-10-10', 1, 'Fluffy and delicious pancakes.'),
(11, 11, 5, '2024-10-11', 1, 'Perfectly cooked steak every time.'),
(12, 12, 4, '2024-10-12', 1, 'Fresh and flavorful Greek salad.'),
(13, 13, 5, '2024-10-13', 1, 'A fantastic gluten-free treat!'),
(14, 14, 3, '2024-10-14', 1, 'Interesting take on pizza crust.'),
(15, 15, 5, '2024-10-15', 1, 'Crispy and tasty chips!'),
(16, 16, 4, '2024-10-16', 1, 'Comfort food at its best!'),
(17, 17, 5, '2024-10-17', 1, 'Amazing sushi rolls, very authentic!'),
(18, 18, 4, '2024-10-18', 1, 'Spicy and satisfying ramen.'),
(19, 19, 5, '2024-10-19', 1, 'A perfect brunch dish!'),
(20, 20, 4, '2024-10-20', 1, 'Great flavor, but very rich.'),
(21, 21, 5, '2024-10-21', 1, 'Fresh and light salad!'),
(22, 22, 4, '2024-10-22', 1, 'Creative and healthy dish.'),
(23, 23, 5, '2024-10-23', 1, 'Simple yet delicious!'),
(24, 24, 4, '2024-10-24', 1, 'A fun and flavorful dish!'),
(25, 25, 5, '2024-10-25', 1, 'Perfect for enhancing flavors!'),
(26, 26, 4, '2024-10-26', 1, 'Nutritious and tasty pudding.'),
(27, 27, 5, '2024-10-27', 1, 'Great snack for any time!'),
(28, 28, 4, '2024-10-28', 1, 'Comforting and delicious soup.'),
(29, 29, 5, '2024-10-29', 1, 'Classic and very refreshing!'),
(30, 30, 5, '2024-10-30', 1, 'A family favorite!'),
(31, 31, 4, '2024-10-31', 1, 'Moist and flavorful bread.'),
(32, 32, 5, '2024-11-01', 1, 'Berry delicious!'),
(33, 33, 4, '2024-11-02', 1, 'Savory and aromatic rice.'),
(34, 34, 5, '2024-11-03', 1, 'A delightful pasta dish!'),
(35, 35, 4, '2024-11-04', 1, 'Crispy and flavorful falafel.');


-- Inserting into plan
INSERT INTO [plan] (recipeID, date, time) VALUES
(1, '2024-10-01', '18:00:00'), -- Dinner
(2, '2024-10-02', '12:00:00'), -- Lunch
(3, '2024-10-03', '19:30:00'), -- Dinner
(4, '2024-10-04', '13:00:00'), -- Lunch
(5, '2024-10-05', '18:30:00'), -- Dinner
(6, '2024-10-06', '12:30:00'), -- Lunch
(7, '2024-10-07', '19:00:00'), -- Dinner
(8, '2024-10-08', '08:00:00'), -- Breakfast
(9, '2024-10-09', '19:00:00'), -- Dinner
(10, '2024-10-10', '08:30:00'), -- Breakfast
(11, '2024-10-11', '18:00:00'), -- Dinner
(12, '2024-10-12', '12:00:00'), -- Lunch
(13, '2024-10-13', '15:00:00'), -- Snack
(14, '2024-10-14', '18:30:00'), -- Dinner
(15, '2024-10-15', '10:00:00'), -- Snack
(16, '2024-10-16', '19:00:00'), -- Dinner
(17, '2024-10-17', '13:30:00'), -- Lunch
(18, '2024-10-18', '19:00:00'), -- Dinner
(19, '2024-10-19', '10:30:00'), -- Breakfast
(20, '2024-10-20', '18:00:00'), -- Dinner
(21, '2024-10-21', '12:00:00'), -- Lunch
(22, '2024-10-22', '18:00:00'), -- Dinner
(23, '2024-10-23', '08:00:00'), -- Breakfast
(24, '2024-10-24', '13:00:00'), -- Lunch
(25, '2024-10-25', '18:00:00'), -- Dinner
(26, '2024-10-26', '15:00:00'), -- Snack
(27, '2024-10-27', '12:00:00'), -- Lunch
(28, '2024-10-28', '19:00:00'), -- Dinner
(29, '2024-10-29', '12:00:00'), -- Lunch
(30, '2024-10-30', '18:00:00'), -- Dinner
(31, '2024-10-31', '10:00:00'), -- Snack
(32, '2024-11-01', '08:00:00'), -- Breakfast
(33, '2024-11-02', '12:00:00'), -- Lunch
(34, '2024-11-03', '19:00:00'), -- Dinner
(35, '2024-11-04', '12:00:00'); -- Lunch


INSERT INTO ingredient (name, type) VALUES
('Bell Peppers', 'Vegetable'),
('Quinoa', 'Grain'),
('Black Beans', 'Legume'),
('Cauliflower', 'Vegetable'),
('Olive Oil', 'Oil'),
('Chickpeas', 'Legume'),
('Tomatoes', 'Fruit'),
('Spices', 'Spice'),
('Chicken Breast', 'Meat'),
('Mixed Greens', 'Vegetable'),
('Olive Oil', 'Oil'),
('Tortillas', 'Grain'),
('Ground Beef', 'Meat'),
('Lettuce', 'Vegetable'),
('Pasta', 'Grain'),
('Mixed Vegetables', 'Vegetable'),
('Olive Oil', 'Oil'),
('Flour', 'Grain'),
('Cocoa Powder', 'Baking'),
('Sugar', 'Sweetener'),
('Bananas', 'Fruit'),
('Berries', 'Fruit'),
('Yogurt', 'Dairy'),
('Salmon', 'Fish'),
('Herbs', 'Herb'),
('Flour', 'Grain'),
('Eggs', 'Dairy'),
('Milk', 'Dairy'),
('Steak', 'Meat'),
('Spices', 'Spice'),
('Cucumber', 'Vegetable'),
('Tomato', 'Fruit'),
('Feta Cheese', 'Dairy'),
('Almond Flour', 'Grain'),
('Sugar', 'Sweetener'),
('Eggs', 'Dairy'),
('Cauliflower', 'Vegetable'),
('Cheese', 'Dairy'),
('Egg', 'Dairy'),
('Zucchini', 'Vegetable'),
('Olive Oil', 'Oil'),
('Pasta', 'Grain'),
('Cheese', 'Dairy'),
('Milk', 'Dairy'),
('Sushi Rice', 'Grain'),
('Nori', 'Seaweed'),
('Fish', 'Fish'),
('Ramen Noodles', 'Grain'),
('Broth', 'Liquid'),
('Spices', 'Spice'),
('Bread', 'Grain'),
('Eggs', 'Dairy'),
('Cinnamon', 'Spice'),
('Pork Ribs', 'Meat'),
('BBQ Sauce', 'Condiment'),
('Mixed Greens', 'Vegetable'),
('Tomatoes', 'Fruit'),
('Cucumbers', 'Vegetable'),
('Zucchini', 'Vegetable'),
('Ground Beef', 'Meat'),
('Tomato Sauce', 'Condiment'),
('Whole Grain Bread', 'Grain'),
('Avocado', 'Fruit'),
('Rice', 'Grain'),
('Kimchi', 'Fermented'),
('Vegetables', 'Vegetable'),
('Olive Oil', 'Oil'),
('Fresh Herbs', 'Herb'),
('Chia Seeds', 'Seed'),
('Almond Milk', 'Dairy'),
('Nuts', 'Nut'),
('Dried Fruit', 'Fruit'),
('Tomatoes', 'Fruit'),
('Basil', 'Herb'),
('Broth', 'Liquid'),
('Cucumber', 'Vegetable'),
('Tomato', 'Fruit'),
('Feta Cheese', 'Dairy'),
('Lasagna Noodles', 'Grain'),
('Cheese', 'Dairy'),
('Ground Beef', 'Meat'),
('Bananas', 'Fruit'),
('Flour', 'Grain'),
('Sugar', 'Sweetener'),
('Berries', 'Fruit'),
('Yogurt', 'Dairy'),
('Milk', 'Dairy'),
('Rice', 'Grain'),
('Fresh Herbs', 'Herb'),
('Spaghetti', 'Grain'),
('Garlic', 'Vegetable'),
('Olive Oil', 'Oil'),
('Chickpeas', 'Legume'),
('Herbs', 'Herb'),
('Spices', 'Spice');


INSERT INTO planIngredients (planID, ingredientID, amountNeeded) VALUES
(1, 1, '2 whole'),               -- Stuffed Peppers: Bell Peppers
(1, 2, '1 cup'),                 -- Stuffed Peppers: Quinoa
(1, 3, '1 cup'),                 -- Stuffed Peppers: Black Beans
(2, 4, '1 medium'),              -- Cauliflower Rice: Cauliflower
(2, 5, '1 tbsp'),                -- Cauliflower Rice: Olive Oil
(3, 6, '1 can'),                 -- Chickpea Curry: Chickpeas
(3, 7, '1 can'),                 -- Chickpea Curry: Tomatoes
(3, 8, '2 tbsp'),                -- Chickpea Curry: Spices
(4, 9, '1 breast'),              -- Grilled Chicken Salad: Chicken Breast
(4, 10, '2 cups'),               -- Grilled Chicken Salad: Mixed Greens
(4, 5, '1 tbsp'),                -- Grilled Chicken Salad: Olive Oil


(5, 11, '4 tortillas'),           -- Tacos: Tortillas
(5, 12, '1 lb'),                 -- Tacos: Ground Beef
(5, 13, '1 cup'),                -- Tacos: Lettuce
(6, 14, '2 cups'),               -- Pasta Primavera: Pasta
(6, 15, '2 cups'),               -- Pasta Primavera: Mixed Vegetables
(6, 5, '1 tbsp'),                -- Pasta Primavera: Olive Oil
(7, 16, '1.5 cups'),             -- Chocolate Cake: Flour
(7, 17, '0.75 cup'),             -- Chocolate Cake: Cocoa Powder
(7, 18, '1 cup'),                -- Chocolate Cake: Sugar
(8, 19, '2 large'),              -- Smoothie Bowl: Bananas
(8, 20, '1 cup'),                -- Smoothie Bowl: Berries
(8, 21, '0.5 cup'),              -- Smoothie Bowl: Yogurt
(9, 22, '1 fillet'),             -- Grilled Salmon: Salmon
(9, 23, '0.5 tbsp'),             -- Grilled Salmon: Herbs
(10, 24, '1 cup'),               -- Pancakes: Flour
(10, 25, '1 large'),             -- Pancakes: Eggs
(10, 26, '0.5 cup'),             -- Pancakes: Milk
(11, 27, '1 steak'),             -- Grilled Steak: Steak
(11, 8, '1/4 tsp'),              -- Grilled Steak: Spices
(12, 28, '1 medium'),            -- Greek Salad: Cucumber
(12, 29, '1 medium'),            -- Greek Salad: Tomato
(12, 30, '0.5 cup'),             -- Greek Salad: Feta Cheese
(13, 31, '1 cup'),               -- Almond Flour Cookies: Almond Flour
(13, 18, '0.5 cup'),             -- Almond Flour Cookies: Sugar
(13, 25, '1 large'),             -- Almond Flour Cookies: Eggs
(14, 4, '1 medium'),             -- Cauliflower Pizza Crust: Cauliflower
(14, 30, '0.5 cup'),             -- Cauliflower Pizza Crust: Cheese
(14, 25, '1 large'),             -- Cauliflower Pizza Crust: Egg
(15, 32, '2 medium'),            -- Zucchini Chips: Zucchini
(15, 5, '1 tbsp'),               -- Zucchini Chips: Olive Oil
(16, 14, '2 cups'),              -- Mac and Cheese: Pasta
(16, 30, '2 cups'),              -- Mac and Cheese: Cheese
(16, 26, '1 cup'),               -- Mac and Cheese: Milk
(17, 33, '2 cups'),              -- Sushi Rolls: Sushi Rice
(17, 34, '0.5 sheets'),          -- Sushi Rolls: Nori
(17, 22, '0.5 lb'),              -- Sushi Rolls: Fish
(18, 35, '1 package'),           -- Chili Ramen: Ramen Noodles
(18, 36, '1 cup'),               -- Chili Ramen: Broth
(18, 8, '1 tbsp'),               -- Chili Ramen: Spices


(19, 37, '2 slices'),            -- French Toast: Bread
(19, 25, '1 large'),             -- French Toast: Eggs
(19, 8, '1/2 tsp'),              -- French Toast: Cinnamon
(20, 38, '2 lbs'),               -- BBQ Ribs: Pork Ribs
(20, 39, '0.5 cup'),             -- BBQ Ribs: BBQ Sauce
(21, 40, '2 cups'),              -- Farmers Market Salad: Mixed Greens
(21, 7, '1 medium'),             -- Farmers Market Salad: Tomatoes
(21, 28, '1 medium'),            -- Farmers Market Salad: Cucumbers
(22, 32, '2 medium'),            -- Zucchini Noodles with Meat Sauce: Zucchini
(22, 12, '1 lb'),                -- Zucchini Noodles with Meat Sauce: Ground Beef
(22, 40, '0.5 cup'),             -- Zucchini Noodles with Meat Sauce: Tomato Sauce
(23, 41, '2 slices'),            -- Avocado Toast: Whole Grain Bread
(23, 42, '1 whole'),             -- Avocado Toast: Avocado
(24, 43, '1 cup'),               -- Kimchi Fried Rice: Rice
(24, 44, '0.5 cup'),             -- Kimchi Fried Rice: Kimchi
(24, 15, '1 cup'),               -- Kimchi Fried Rice: Vegetables
(25, 5, '1 cup'),                -- Herb-Infused Olive Oil: Olive Oil
(25, 23, '0.5 cup'),             -- Herb-Infused Olive Oil: Fresh Herbs
(26, 45, '1/4 cup'),             -- Chia Seed Pudding: Chia Seeds
(26, 46, '1 cup'),               -- Chia Seed Pudding: Almond Milk
(27, 47, '1 cup'),               -- Trail Mix: Nuts
(27, 48, '0.5 cup'),             -- Trail Mix: Dried Fruit
(28, 7, '2 cups'),               -- Tomato Basil Soup: Tomatoes
(28, 49, '0.5 cup'),             -- Tomato Basil Soup: Basil
(28, 36, '1 cup'),               -- Tomato Basil Soup: Broth
(29, 40, '1 medium'),            -- Greek Salad: Cucumber
(29, 7, '1 medium'),             -- Greek Salad: Tomato
(29, 30, '0.5 cup'),             -- Greek Salad: Feta Cheese
(30, 50, '2 cups'),              -- Lasagna: Lasagna Noodles
(30, 30, '2 cups'),              -- Lasagna: Cheese
(30, 12, '1 lb'),                -- Lasagna: Ground Beef
(31, 19, '2 ripe'),              -- Banana Bread: Bananas
(31, 16, '1.5 cups'),            -- Banana Bread: Flour
(31, 18, '0.5 cup'),             -- Banana Bread: Sugar
(32, 20, '1 cup'),               -- Berry Smoothie: Berries
(32, 21, '0.5 cup'),             -- Berry Smoothie: Yogurt
(32, 26, '0.5 cup'),             -- Berry Smoothie: Milk
(33, 43, '1 cup'),               -- Rice Bowl: Rice
(33, 23, '0.5 cup'),             -- Rice Bowl: Fresh Herbs
(34, 14, '1 lb'),                -- Garlic Pasta: Spaghetti
(34, 50, '2 cloves'),            -- Garlic Pasta: Garlic
(34, 5, '1/4 cup'),              -- Garlic Pasta: Olive Oil
(35, 6, '1 can'),                -- Spiced Chickpeas: Chickpeas
(35, 23, '1 tsp'),               -- Spiced Chickpeas: Herbs
(35, 8, '1/2 tsp');              -- Spiced Chickpeas: Spices




INSERT INTO saved (userID, recipeID, tried) VALUES
(1, 1, 0),   -- User 1 saves Stuffed Peppers
(1, 3, 1),   -- User 1 tries Chickpea Curry
(2, 4, 0),   -- User 2 saves Grilled Chicken Salad
(2, 10, 1),  -- User 2 tries Pancakes
(3, 15, 0),  -- User 3 saves Zucchini Chips
(3, 2, 0),   -- User 3 saves Cauliflower Rice
(4, 5, 0),   -- User 4 saves Tacos
(5, 6, 1),   -- User 5 tries Pasta Primavera
(5, 12, 1),  -- User 5 tries Greek Salad
(5, 20, 0),  -- User 5 saves BBQ Ribs
(6, 7, 1),   -- User 6 tries Chocolate Cake
(6, 9, 0),   -- User 6 saves Grilled Salmon
(7, 18, 1),  -- User 7 tries Chili Ramen
(8, 22, 0),  -- User 8 saves Zucchini Noodles with Meat Sauce
(9, 29, 0),  -- User 9 saves Greek Salad
(10, 8, 1),  -- User 10 tries Smoothie Bowl
(14, 11, 0), -- User 14 saves Grilled Steak
(14, 13, 0), -- User 14 saves Almond Flour Cookies
(14, 17, 1), -- User 14 tries Sushi Rolls
(14, 30, 0), -- User 14 saves Lasagna
(15, 14, 0), -- User 15 saves Cauliflower Pizza Crust
(16, 16, 1), -- User 16 tries Mac and Cheese
(20, 19, 0), -- User 20 saves French Toast
(35, 24, 1), -- User 35 tries Kimchi Fried Rice
(25, 26, 0); -- User 25 saves Chia Seed Pudding




INSERT INTO userIngredients (userID, ingredientID, userAmount) VALUES
(1, 1, '3 whole'),           -- Bell Peppers
(1, 4, '1/2 cup'),           -- Olive Oil
(1, 10, '2 cups'),           -- Flour
(1, 12, '200 g'),            -- Feta Cheese


(2, 2, '1 cup'),             -- Quinoa
(2, 3, '1 can'),             -- Chickpeas
(2, 7, '100 g'),             -- Cocoa Powder
(2, 19, '1 loaf'),           -- Bread
(3, 5, '250 g'),             -- Ground Beef
(3, 8, '2 medium'),          -- Bananas
(3, 14, '1 head'),           -- Cauliflower
(4, 6, '200 g'),             -- Pasta
(4, 15, '3 small'),          -- Zucchini
(4, 20, '1 bottle'),         -- BBQ Sauce
(5, 17, '300 g'),            -- Sushi Rice
(5, 18, '2 packs'),          -- Ramen Noodles
(5, 26, '100 g'),            -- Chia Seeds
(6, 11, '6 large'),          -- Eggs
(6, 9, '2 fillets'),         -- Salmon
(6, 22, '3 medium'),         -- Zucchini
(7, 4, '1 cup'),             -- Olive Oil
(7, 21, '150 g'),            -- Mixed Greens
(7, 23, '2 slices'),         -- Whole Grain Bread
(8, 12, '150 g'),            -- Feta Cheese
(8, 28, '1 bunch'),          -- Basil
(8, 24, '1 cup'),            -- Rice
(9, 14, '2 heads'),          -- Cauliflower
(9, 16, '200 g'),            -- Cheese
(9, 25, '1 bottle'),         -- Olive Oil
(10, 30, '250 g'),           -- Lasagna Noodles
(10, 15, '2 medium'),        -- Zucchini
(10, 20, '1 jar'),           -- BBQ Sauce
(11, 1, '4 whole'),          -- Bell Peppers
(11, 3, '1 bag'),            -- Chickpeas
(11, 19, '1 loaf'),          -- Bread
(12, 2, '1/2 cup'),          -- Quinoa
(12, 5, '1 kg'),             -- Ground Beef
(12, 7, '300 g'),            -- Cocoa Powder
(13, 6, '200 g'),            -- Pasta
(13, 8, '5 medium'),         -- Bananas
(13, 26, '50 g'),            -- Chia Seeds
(14, 10, '500 g'),           -- Flour
(14, 21, '200 g'),           -- Mixed Greens
(14, 30, '1 packet'),        -- Lasagna Noodles
(15, 15, '2 medium'),        -- Zucchini
(15, 18, '1 pack'),          -- Ramen Noodles
(15, 24, '1 cup'),           -- Rice
(16, 9, '3 fillets'),        -- Salmon
(16, 17, '1 pack'),          -- Sushi Rice
(16, 22, '4 medium'),        -- Zucchini
(17, 11, '6 large'),         -- Eggs
(17, 4, '1/2 cup'),          -- Olive Oil
(17, 23, '2 slices'),        -- Whole Grain Bread
(18, 12, '150 g'),           -- Feta Cheese
(18, 14, '1 head'),          -- Cauliflower
(18, 28, '1 bunch'),         -- Basil
(19, 6, '250 g'),            -- Pasta
(19, 3, '1 can'),            -- Chickpeas
(19, 19, '1 loaf'),          -- Bread
(20, 2, '1 cup'),            -- Quinoa
(20, 5, '500 g'),            -- Ground Beef
(20, 30, '250 g'),           -- Lasagna Noodles
(21, 15, '3 medium'),        -- Zucchini
(21, 22, '3 medium'),        -- Zucchini
(21, 17, '200 g'),           -- Sushi Rice
(22, 10, '300 g'),           -- Flour
(22, 12, '250 g'),           -- Feta Cheese
(22, 4, '1 cup'),            -- Olive Oil
(23, 8, '4 medium'),         -- Bananas
(23, 1, '4 whole'),          -- Bell Peppers
(23, 19, '1 loaf'),          -- Bread
(24, 11, '6 large'),         -- Eggs
(24, 16, '150 g'),           -- Cheese
(24, 30, '1 packet'),        -- Lasagna Noodles
(25, 18, '2 packs'),         -- Ramen Noodles
(25, 3, '1 bag'),            -- Chickpeas
(25, 26, '100 g'),           -- Chia Seeds
(26, 14, '2 heads'),         -- Cauliflower
(26, 2, '1/2 cup'),          -- Quinoa
(26, 20, '1 jar'),           -- BBQ Sauce
(27, 7, '200 g'),            -- Cocoa Powder
(27, 23, '2 slices'),        -- Whole Grain Bread
(27, 4, '1 cup'),            -- Olive Oil
(28, 9, '2 fillets'),        -- Salmon
(28, 21, '150 g'),           -- Mixed Greens
(28, 15, '2 medium'),        -- Zucchini
(29, 10, '500 g'),           -- Flour
(29, 8, '5 medium'),         -- Bananas
(29, 22, '4 medium'),        -- Zucchini
(30, 6, '250 g'),            -- Pasta
(30, 12, '150 g'),           -- Feta Cheese
(30, 19, '1 loaf'),          -- Bread
(31, 17, '1 pack'),          -- Sushi Rice
(31, 3, '1 can'),            -- Chickpeas
(31, 30, '250 g'),           -- Lasagna Noodles
(32, 26, '100 g'),           -- Chia Seeds
(32, 4, '1/2 cup'),          -- Olive Oil
(32, 5, '500 g'),            -- Ground Beef
(33, 15, '2 medium'),        -- Zucchini
(33, 22, '3 medium'),        -- Zucchini
(33, 28, '1 bunch'),         -- Basil
(34, 1, '3 whole'),          -- Bell Peppers
(34, 18, '1 pack'),          -- Ramen Noodles
(34, 30, '250 g'),           -- Lasagna Noodles
(35, 2, '1 cup'),            -- Quinoa
(35, 6, '200 g'),            -- Pasta
(35, 11, '6 large');         -- Eggs




INSERT INTO recipeIngredients (recipeID, ingredientID, recipeAmount) VALUES
(1, 1, '3 whole'),               -- Bell Peppers
(1, 2, '1 cup'),                 -- Quinoa
(1, 3, '1 can'),                 -- Black Beans
(2, 4, '1 head'),                -- Cauliflower
(2, 5, '2 tbsp'),                -- Olive Oil
(3, 6, '1 can'),                 -- Chickpeas
(3, 7, '2 medium'),              -- Tomatoes
(3, 8, '1 tbsp'),                -- Spices
(4, 9, '2 breasts'),             -- Chicken Breast
(4, 10, '4 cups'),               -- Mixed Greens
(4, 5, '2 tbsp'),                -- Olive Oil
(5, 11, '8 tortillas'),           -- Tortillas
(5, 12, '500 g'),                -- Ground Beef
(5, 13, '1 cup'),                -- Lettuce
(6, 14, '300 g'),                -- Pasta
(6, 15, '2 cups'),               -- Mixed Vegetables
(6, 5, '2 tbsp'),                -- Olive Oil
(7, 16, '2 cups'),               -- Flour
(7, 17, '1 cup'),                -- Cocoa Powder
(7, 18, '1 cup'),                -- Sugar
(8, 19, '2 bananas'),            -- Bananas
(8, 20, '1 cup'),                -- Berries
(8, 21, '1 cup'),                -- Yogurt
(9, 22, '2 fillets'),            -- Salmon
(9, 23, '1 bunch'),              -- Herbs
(10, 16, '1 cup'),               -- Flour
(10, 24, '2 eggs'),              -- Eggs
(10, 25, '1 cup'),               -- Milk
(11, 26, '2 steaks'),            -- Steak
(11, 8, '1 tbsp'),               -- Spices
(12, 27, '1 cucumber'),          -- Cucumber
(12, 28, '2 tomatoes'),          -- Tomato
(12, 29, '100 g'),               -- Feta Cheese
(13, 30, '2 cups'),              -- Almond Flour
(13, 18, '1 cup'),               -- Sugar
(13, 24, '2 eggs'),              -- Eggs
(14, 4, '1 head'),               -- Cauliflower
(14, 31, '1 cup'),               -- Cheese
(14, 24, '1 egg'),               -- Egg
(15, 32, '2 zucchinis'),         -- Zucchini
(15, 5, '2 tbsp'),               -- Olive Oil
(16, 14, '250 g'),               -- Pasta
(16, 31, '1 cup'),               -- Cheese
(16, 24, '1 cup'),               -- Milk
(17, 33, '1 cup'),               -- Sushi Rice
(17, 34, '4 sheets'),            -- Nori
(17, 22, '150 g'),               -- Fish
(18, 35, '2 packs'),             -- Ramen Noodles
(18, 36, '4 cups'),              -- Broth
(18, 8, '1 tbsp'),               -- Spices
(19, 37, '4 slices'),            -- Bread
(19, 24, '2 eggs'),              -- Eggs
(19, 8, '1 tsp'),                -- Cinnamon


(20, 38, '2 kg'),                -- Pork Ribs
(20, 39, '1 cup'),               -- BBQ Sauce
(21, 10, '4 cups'),              -- Mixed Greens
(21, 27, '2 tomatoes'),          -- Tomatoes
(21, 38, '1 cucumber'),          -- Cucumbers
(22, 32, '2 zucchinis'),         -- Zucchini
(22, 12, '500 g'),               -- Ground Beef
(22, 39, '1 cup'),               -- Tomato Sauce
(23, 40, '4 slices'),            -- Whole Grain Bread
(23, 41, '2 avocados'),          -- Avocado
(24, 14, '2 cups'),              -- Rice
(24, 42, '1 cup'),               -- Kimchi
(24, 15, '1 cup'),               -- Vegetables
(25, 5, '1 cup'),                -- Olive Oil
(25, 43, '1 cup'),               -- Fresh Herbs
(26, 44, '1/2 cup'),             -- Chia Seeds
(26, 24, '2 cups'),              -- Almond Milk
(27, 45, '1 cup'),               -- Nuts
(27, 46, '1 cup'),               -- Dried Fruit
(28, 47, '4 tomatoes'),          -- Tomatoes
(28, 48, '1/2 cup'),             -- Basil
(28, 49, '2 cups'),              -- Broth
(29, 27, '1 cucumber'),          -- Cucumber
(29, 28, '2 tomatoes'),          -- Tomato
(29, 29, '100 g'),               -- Feta Cheese
(30, 50, '250 g'),               -- Lasagna Noodles
(30, 31, '500 g'),               -- Cheese
(30, 12, '250 g'),               -- Ground Beef
(31, 51, '3 bananas'),           -- Bananas
(31, 16, '2 cups'),              -- Flour
(31, 18, '1 cup'),               -- Sugar
(32, 20, '2 cups'),              -- Berries
(32, 24, '1 cup'),               -- Yogurt
(32, 25, '1 cup'),               -- Milk
(33, 14, '2 cups'),              -- Rice
(33, 43, '1/2 cup'),             -- Fresh Herbs
(34, 14, '300 g'),               -- Spaghetti
(34, 52, '3 cloves'),            -- Garlic
(34, 5, '3 tbsp'),               -- Olive Oil
(35, 6, '1 can'),                -- Chickpeas
(35, 53, '1 tbsp'),              -- Herbs
(35, 8, '1 tbsp');               -- Spices


INSERT INTO substitutions (ingredientID, substituteIngredientID, ratio) VALUES
(1, 4, 1.00),   -- Bell Peppers -> Cauliflower
(2, 29, 1.00),  -- Quinoa -> Almond Flour
(3, 6, 1.00),   -- Black Beans -> Chickpeas
(4, 1, 1.00),   -- Cauliflower -> Bell Peppers
(5, 11, 1.00),  -- Olive Oil -> Tortillas
(6, 3, 1.00),   -- Chickpeas -> Black Beans
(7, 8, 1.00),   -- Tomatoes -> Spices
(8, 7, 1.00),   -- Spices -> Tomatoes
(9, 12, 1.00),  -- Chicken Breast -> Ground Beef
(10, 28, 1.00), -- Mixed Greens -> Feta Cheese
(11, 5, 1.00),  -- Tortillas -> Olive Oil
(12, 9, 1.00),  -- Ground Beef -> Chicken Breast
(13, 4, 1.00),  -- Lettuce -> Cauliflower
(14, 29, 1.00), -- Pasta -> Almond Flour
(15, 6, 1.00),  -- Mixed Vegetables -> Chickpeas
(16, 2, 1.00),  -- Flour -> Quinoa
(17, 18, 1.00), -- Cocoa Powder -> Sugar
(18, 17, 1.00), -- Sugar -> Cocoa Powder
(19, 21, 1.00), -- Bananas -> Yogurt
(20, 19, 1.00), -- Berries -> Bananas
(21, 19, 1.00), -- Yogurt -> Bananas
(22, 34, 1.00), -- Salmon -> Fish
(23, 24, 1.00), -- Herbs -> Eggs
(24, 23, 1.00), -- Eggs -> Herbs
(25, 21, 1.00), -- Milk -> Yogurt
(26, 9, 1.00),  -- Steak -> Chicken Breast
(27, 28, 1.00), -- Cucumber -> Feta Cheese
(28, 27, 1.00), -- Feta Cheese -> Cucumber
(29, 16, 1.00), -- Almond Flour -> Flour
(30, 9, 1.00),  -- Cheese -> Chicken Breast
(31, 4, 1.00),  -- Zucchini -> Cauliflower
(32, 29, 1.00), -- Sushi Rice -> Almond Flour
(33, 5, 1.00),  -- Nori -> Olive Oil
(34, 6, 1.00),  -- Fish -> Chickpeas
(35, 18, 1.00), -- Ramen Noodles -> Sugar
(36, 36, 1.00), -- Broth -> Broth (self-substitution)
(37, 38, 1.00), -- Bread -> Cinnamon
(38, 37, 1.00), -- Cinnamon -> Bread
(39, 48, 1.00), -- Pork Ribs -> Nuts
(40, 41, 1.00), -- BBQ Sauce -> Whole Grain Bread
(41, 40, 1.00), -- Whole Grain Bread -> BBQ Sauce
(42, 7, 1.00),  -- Avocado -> Tomatoes
(43, 16, 1.00), -- Rice -> Flour
(44, 6, 1.00),  -- Kimchi -> Chickpeas
(45, 22, 1.00), -- Fresh Herbs -> Salmon
(46, 44, 1.00), -- Chia Seeds -> Kimchi
(47, 21, 1.00), -- Almond Milk -> Yogurt
(48, 49, 1.00), -- Nuts -> Dried Fruit
(49, 48, 1.00), -- Dried Fruit -> Nuts
(50, 51, 1.00), -- Basil -> Garlic
(51, 50, 1.00); -- Garlic -> Basil


-- 1. Find the total number of users, grouped by their preferences
SELECT p.preferences, COUNT(u.userID) AS total_users
FROM userPreferences p
JOIN [user] u ON p.userID = u.userID
GROUP BY p.preferences;


-- 2. Find the average rating for recipes, grouped by their origin
SELECT r.origin, AVG(rv.rating) AS average_rating
FROM recipe r
JOIN review rv ON r.recipeID = rv.recipeID
GROUP BY r.origin;


-- 3. Find the average calories of recipes, grouped by their tags
SELECT rt.tags, AVG(r.calories) AS average_calories
FROM recipeTags rt
JOIN recipe r ON rt.recipeID = r.recipeID
GROUP BY rt.tags;


-- 4. Count the total number of reviews for each recipe
SELECT r.name,
       (SELECT COUNT(*) FROM review rv WHERE rv.recipeID = r.recipeID) AS total_reviews
FROM recipe r;


-- 5. Get the comment and rating for the highest-rated review for each recipe
SELECT rv.recipeID, rv.comment, rv.rating
FROM review rv
WHERE rv.rating = (SELECT MAX(rating)
                   FROM review
                   WHERE recipeID = rv.recipeID);


-- 6. Find the cuisine type with the highest total rating
SELECT TOP 1 r.cuisine, SUM(rv.rating) AS total_rating
FROM recipe r
JOIN review rv ON r.recipeID = rv.recipeID
GROUP BY r.cuisine
ORDER BY total_rating DESC;


-- 7. Identify the most saved recipe, grouped by its tags
SELECT TOP 1 rt.tags, r.name, COUNT(s.recipeID) AS save_count
FROM recipeTags rt
JOIN saved s ON rt.recipeID = s.recipeID
JOIN recipe r ON rt.recipeID = r.recipeID
GROUP BY rt.tags, r.name
ORDER BY save_count DESC;


-- 8. Retrieve all recipes that have at least 5 reviews
SELECT r.name
FROM recipe r
WHERE (SELECT COUNT(*)
        FROM review rv
        WHERE rv.recipeID = r.recipeID) >= 5;


-- 9. Count of recipes that each ingredient shows up in, sorted descending
SELECT i.name AS ingredient_name, COUNT(ri.recipeID) AS recipe_count
FROM ingredient i
JOIN recipeIngredients ri ON i.ingredientID = ri.ingredientID
GROUP BY i.name
ORDER BY recipe_count DESC;


-- 10. List the top 5 users based on the number of reviews they have written
SELECT TOP 5 u.username, COUNT(rv.reviewID) AS total_reviews
FROM [user] u
JOIN review rv ON u.userID = rv.userID
GROUP BY u.username
ORDER BY total_reviews DESC;
