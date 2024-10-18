{
    "metadata": {
        "kernelspec": {
            "name": "SQL",
            "display_name": "SQL",
            "language": "sql"
        },
        "language_info": {
            "name": "sql",
            "version": ""
        }
    },
    "nbformat_minor": 2,
    "nbformat": 4,
    "cells": [
        {
            "cell_type": "code",
            "source": [
                "CREATE DATABASE P3Final\r\n",
                "GO\r\n",
                "USE P3Final\r\n",
                "GO\r\n",
                "\r\n",
                "-- User\r\n",
                "CREATE TABLE [user] (\r\n",
                "    userID INT IDENTITY(1,1) PRIMARY KEY,\r\n",
                "    name VARCHAR(100) NOT NULL,\r\n",
                "    username VARCHAR(50) NOT NULL UNIQUE,\r\n",
                "    password VARCHAR(255) NOT NULL\r\n",
                ");\r\n",
                "\r\n",
                "-- userPreferences\r\n",
                "CREATE TABLE userPreferences (\r\n",
                "    userID INT,\r\n",
                "    preferences VARCHAR(MAX),\r\n",
                "    PRIMARY KEY (userID),\r\n",
                "    FOREIGN KEY (userID) REFERENCES [user](userID)\r\n",
                ");\r\n",
                "\r\n",
                "-- Recipe\r\n",
                "CREATE TABLE recipe (\r\n",
                "    recipeID INT IDENTITY(1,1) PRIMARY KEY,\r\n",
                "    userID INT,\r\n",
                "    name VARCHAR(255) NOT NULL,\r\n",
                "    instructions VARCHAR(MAX) NOT NULL,\r\n",
                "    protein DECIMAL(5,2) DEFAULT 0,\r\n",
                "    fats DECIMAL(5,2) DEFAULT 0,\r\n",
                "    carbs DECIMAL(5,2) DEFAULT 0,\r\n",
                "    calories DECIMAL(6,2) DEFAULT 0,\r\n",
                "    origin VARCHAR(100),\r\n",
                "    cuisine VARCHAR(100),\r\n",
                "    FOREIGN KEY (userID) REFERENCES [user](userID)\r\n",
                ");\r\n",
                "\r\n",
                "-- recipeTags\r\n",
                "CREATE TABLE recipeTags (\r\n",
                "    recipeID INT,\r\n",
                "    tags VARCHAR(255) NOT NULL,\r\n",
                "    PRIMARY KEY (recipeID, tags),\r\n",
                "    FOREIGN KEY (recipeID) REFERENCES recipe(recipeID)\r\n",
                ");\r\n",
                "\r\n",
                "-- recipeCookingSupplies\r\n",
                "CREATE TABLE recipeCookingSupplies (\r\n",
                "    recipeID INT,\r\n",
                "    cookingSupplies VARCHAR(255) NOT NULL,\r\n",
                "    PRIMARY KEY (recipeID, cookingSupplies),\r\n",
                "    FOREIGN KEY (recipeID) REFERENCES recipe(recipeID)\r\n",
                ");\r\n",
                "\r\n",
                "-- Review\r\n",
                "CREATE TABLE review (\r\n",
                "    reviewID INT IDENTITY(1,1) PRIMARY KEY,\r\n",
                "    recipeID INT,\r\n",
                "    userID INT,\r\n",
                "    rating INT,\r\n",
                "    date DATE NOT NULL,\r\n",
                "    [public] BIT DEFAULT 1, -- Using BIT for boolean values\r\n",
                "    comment VARCHAR(MAX),\r\n",
                "    FOREIGN KEY (recipeID) REFERENCES recipe(recipeID),\r\n",
                "    FOREIGN KEY (userID) REFERENCES [user](userID)\r\n",
                ");\r\n",
                "\r\n",
                "-- Plan\r\n",
                "CREATE TABLE [plan] (\r\n",
                "    planID INT IDENTITY(1,1) PRIMARY KEY,\r\n",
                "    recipeID INT,\r\n",
                "    date DATE NOT NULL,\r\n",
                "    time TIME NOT NULL,\r\n",
                "    FOREIGN KEY (recipeID) REFERENCES recipe(recipeID)\r\n",
                ");\r\n",
                "\r\n",
                "-- Ingredient\r\n",
                "CREATE TABLE ingredient (\r\n",
                "    ingredientID INT IDENTITY(1,1) PRIMARY KEY,\r\n",
                "    name VARCHAR(255) NOT NULL,\r\n",
                "    type VARCHAR(100)\r\n",
                ");\r\n",
                "\r\n",
                "-- planIngredients\r\n",
                "CREATE TABLE planIngredients (\r\n",
                "    planID INT,\r\n",
                "    ingredientID INT,\r\n",
                "    amountNeeded VARCHAR(50) NOT NULL,\r\n",
                "    PRIMARY KEY (planID, ingredientID),\r\n",
                "    FOREIGN KEY (planID) REFERENCES [plan](planID),\r\n",
                "    FOREIGN KEY (ingredientID) REFERENCES ingredient(ingredientID)\r\n",
                ");\r\n",
                "\r\n",
                "-- Saved\r\n",
                "CREATE TABLE saved (\r\n",
                "    userID INT,\r\n",
                "    recipeID INT,\r\n",
                "    tried BIT DEFAULT 0, -- Using BIT for boolean values\r\n",
                "    PRIMARY KEY (userID, recipeID),\r\n",
                "    FOREIGN KEY (userID) REFERENCES [user](userID),\r\n",
                "    FOREIGN KEY (recipeID) REFERENCES recipe(recipeID)\r\n",
                ");\r\n",
                "\r\n",
                "-- userIngredients\r\n",
                "CREATE TABLE userIngredients (\r\n",
                "    userID INT,\r\n",
                "    ingredientID INT,\r\n",
                "    userAmount VARCHAR(50) NOT NULL,\r\n",
                "    PRIMARY KEY (userID, ingredientID),\r\n",
                "    FOREIGN KEY (userID) REFERENCES [user](userID),\r\n",
                "    FOREIGN KEY (ingredientID) REFERENCES ingredient(ingredientID)\r\n",
                ");\r\n",
                "\r\n",
                "-- recipeIngredients\r\n",
                "CREATE TABLE recipeIngredients (\r\n",
                "    recipeID INT,\r\n",
                "    ingredientID INT,\r\n",
                "    recipeAmount VARCHAR(50) NOT NULL, \r\n",
                "    PRIMARY KEY (recipeID, ingredientID),\r\n",
                "    FOREIGN KEY (recipeID) REFERENCES recipe(recipeID),\r\n",
                "    FOREIGN KEY (ingredientID) REFERENCES ingredient(ingredientID)\r\n",
                ");\r\n",
                "\r\n",
                "-- Substitutions\r\n",
                "CREATE TABLE substitutions (\r\n",
                "    ingredientID INT,\r\n",
                "    substituteIngredientID INT,\r\n",
                "    ratio DECIMAL(5,2) NOT NULL,\r\n",
                "    PRIMARY KEY (ingredientID, substituteIngredientID),\r\n",
                "    FOREIGN KEY (ingredientID) REFERENCES ingredient(ingredientID),\r\n",
                "    FOREIGN KEY (substituteIngredientID) REFERENCES ingredient(ingredientID)\r\n",
                ");\r\n",
                ""
            ],
            "metadata": {
                "azdata_cell_guid": "87dcd109-18a3-4bd7-a1b5-849b038732b6",
                "language": "sql"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Commands completed successfully."
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Commands completed successfully."
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Commands completed successfully."
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.231"
                    },
                    "metadata": {}
                }
            ],
            "execution_count": 16
        },
        {
            "cell_type": "code",
            "source": [
                "-- Check Constraints\r\n",
                "ALTER TABLE review\r\n",
                "ADD CONSTRAINT chk_rating CHECK (rating BETWEEN 1 AND 5);\r\n",
                "\r\n",
                "ALTER TABLE recipe\r\n",
                "ADD CONSTRAINT chk_calories CHECK (calories >= 0);\r\n",
                "\r\n",
                "ALTER TABLE substitutions\r\n",
                "ADD CONSTRAINT chk_positive_ratio CHECK (ratio > 0);"
            ],
            "metadata": {
                "azdata_cell_guid": "0098a2b6-688f-4d04-a1cd-5b9ff6b15559",
                "language": "sql"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Commands completed successfully."
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.014"
                    },
                    "metadata": {}
                }
            ],
            "execution_count": 17
        },
        {
            "cell_type": "code",
            "source": [
                "-- insertions\r\n",
                "\r\n",
                "INSERT INTO [user] (name, username, password) VALUES\r\n",
                "('Alice Johnson', 'alicej', 'pass123'),\r\n",
                "('Bob Smith', 'bobsmith', 'mypassword'),\r\n",
                "('Charlie Brown', 'charlieb', 'qwerty'),\r\n",
                "('Diana Prince', 'dianap', 'wonderwoman'),\r\n",
                "('Ethan Hunt', 'ethanh', 'secret'),\r\n",
                "('Fiona Gallagher', 'fionag', 'shameless'),\r\n",
                "('George Clark', 'georgec', 'passw0rd'),\r\n",
                "('Hannah Baker', 'hannahb', 'reasons'),\r\n",
                "('Isaac Newton', 'isaacn', 'gravity'),\r\n",
                "('Jack Daniels', 'jackd', 'whiskey'),\r\n",
                "('Mona Lisa', 'monalisa', 'artlover'),\r\n",
                "('Nina Simone', 'ninas', 'music123'),\r\n",
                "('Oscar Wilde', 'oscarw', 'bookworm'),\r\n",
                "('Peter Parker', 'peterp', 'spidey'),\r\n",
                "('Quinn Fabray', 'quinnf', 'glee'),\r\n",
                "('Rachel Green', 'rachelg', 'fashion'),\r\n",
                "('Tina Fey', 'tinaf', 'comedy'),\r\n",
                "('Uma Thurman', 'umath', 'killbill'),\r\n",
                "('Victor Hugo', 'victorh', 'lesmis'),\r\n",
                "('Wanda Maximoff', 'wandam', 'scarletwitch'),\r\n",
                "('Xander Harris', 'xanderh', 'vampires'),\r\n",
                "('Yara Greyjoy', 'yarag', 'ironborn'),\r\n",
                "('Zoe Saldana', 'zoes', 'starfleet'),\r\n",
                "('Adam Driver', 'adamd', 'kylo'),\r\n",
                "('Bella Swan', 'bellas', 'vampires2'),\r\n",
                "('Cameron Diaz', 'camerond', 'actress'),\r\n",
                "('Daniel Craig', 'danielc', 'bond007'),\r\n",
                "('Emma Watson', 'emmaw', 'hermione'),\r\n",
                "('Finn Hudson', 'finnh', 'singing'),\r\n",
                "('Gina Rodriguez', 'ginar', 'latina'),\r\n",
                "('Hugh Jackman', 'hughj', 'wolverine'),\r\n",
                "('Iggy Azalea', 'iggya', 'rap'),\r\n",
                "('Jenna Ortega', 'jenno', 'acting'),\r\n",
                "('Keanu Reeves', 'keanur', 'matrix'),\r\n",
                "('Lucy Liu', 'lucyl', 'charliesangels');\r\n",
                "\r\n",
                "INSERT INTO userPreferences (userID, preferences) VALUES\r\n",
                "(1, 'Vegetarian'),\r\n",
                "(2, 'Low-carb'),\r\n",
                "(3, 'Vegan'),\r\n",
                "(4, 'Healthy'),\r\n",
                "(5, 'Mexican'),\r\n",
                "(6, 'Italian'),\r\n",
                "(7, 'Dessert'),\r\n",
                "(8, 'Quick Meals'),\r\n",
                "(9, 'Seafood'),\r\n",
                "(10, 'Breakfast'),\r\n",
                "(11, 'Paleo'),\r\n",
                "(12, 'Mediterranean'),\r\n",
                "(13, 'Gluten-free'),\r\n",
                "(14, 'Dairy-free'),\r\n",
                "(15, 'Keto'),\r\n",
                "(16, 'Comfort Food'),\r\n",
                "(17, 'Asian'),\r\n",
                "(18, 'Spicy'),\r\n",
                "(19, 'Brunch'),\r\n",
                "(20, 'Barbecue'),\r\n",
                "(21, 'Farm-to-table'),\r\n",
                "(22, 'Whole30'),\r\n",
                "(23, 'Low-sugar'),\r\n",
                "(24, 'Fermented Foods'),\r\n",
                "(25, 'Fresh Herbs'),\r\n",
                "(26, 'Superfoods'),\r\n",
                "(27, 'Snacks'),\r\n",
                "(28, 'Soups'),\r\n",
                "(29, 'Salads'),\r\n",
                "(30, 'Casseroles'),\r\n",
                "(31, 'Baking'),\r\n",
                "(32, 'Smoothies'),\r\n",
                "(33, 'Savory'),\r\n",
                "(34, 'Pasta'),\r\n",
                "(35, 'Street Food');\r\n",
                "\r\n",
                "INSERT INTO recipe (userID, name, instructions, protein, fats, carbs, calories, origin, cuisine) VALUES\r\n",
                "(1, 'Stuffed Peppers', 'Fill peppers with quinoa and beans.', 8.00, 2.00, 25.00, 180.00, 'USA', 'Vegetarian'),\r\n",
                "(2, 'Cauliflower Rice', 'Pulse cauliflower until rice-like.', 2.00, 0.50, 5.00, 30.00, 'India', 'Low-carb'),\r\n",
                "(3, 'Chickpea Curry', 'Cook chickpeas with spices and tomatoes.', 10.00, 5.00, 45.00, 300.00, 'India', 'Vegan'),\r\n",
                "(4, 'Grilled Chicken Salad', 'Grill chicken and serve with greens.', 30.00, 5.00, 10.00, 250.00, 'USA', 'Healthy'),\r\n",
                "(5, 'Tacos', 'Fill tortillas with meat and toppings.', 25.00, 15.00, 30.00, 450.00, 'Mexico', 'Mexican'),\r\n",
                "(6, 'Pasta Primavera', 'Toss pasta with fresh vegetables.', 15.00, 5.00, 75.00, 400.00, 'Italy', 'Italian'),\r\n",
                "(7, 'Chocolate Cake', 'Bake a rich chocolate cake.', 5.00, 20.00, 50.00, 400.00, 'USA', 'Dessert'),\r\n",
                "(8, 'Smoothie Bowl', 'Blend fruits and serve in a bowl.', 5.00, 5.00, 30.00, 250.00, 'USA', 'Quick Meals'),\r\n",
                "(9, 'Grilled Salmon', 'Cook salmon with herbs.', 30.00, 15.00, 0.00, 350.00, 'Norway', 'Seafood'),\r\n",
                "(10, 'Pancakes', 'Cook pancakes and serve with syrup.', 6.00, 8.00, 60.00, 300.00, 'USA', 'Breakfast'),\r\n",
                "(11, 'Grilled Steak', 'Cook steak to preference.', 30.00, 20.00, 0.00, 400.00, 'USA', 'Paleo'),\r\n",
                "(12, 'Greek Salad', 'Mix cucumber, tomato, and feta.', 4.00, 12.00, 15.00, 150.00, 'Greece', 'Mediterranean'),\r\n",
                "(13, 'Almond Flour Cookies', 'Bake cookies using almond flour.', 5.00, 10.00, 15.00, 200.00, 'USA', 'Gluten-free'),\r\n",
                "(14, 'Cauliflower Pizza Crust', 'Make a pizza crust using cauliflower.', 4.00, 2.00, 20.00, 180.00, 'USA', 'Dairy-free'),\r\n",
                "(15, 'Zucchini Chips', 'Bake zucchini slices until crispy.', 3.00, 2.00, 8.00, 50.00, 'USA', 'Keto'),\r\n",
                "(16, 'Mac and Cheese', 'Cook pasta and mix with cheese.', 10.00, 10.00, 60.00, 500.00, 'USA', 'Comfort Food'),\r\n",
                "(17, 'Sushi Rolls', 'Roll rice with fish and vegetables.', 20.00, 5.00, 40.00, 350.00, 'Japan', 'Asian'),\r\n",
                "(18, 'Chili Ramen', 'Prepare ramen with spicy broth.', 15.00, 8.00, 40.00, 300.00, 'Japan', 'Spicy'),\r\n",
                "(19, 'French Toast', 'Dip bread in egg and cook.', 10.00, 8.00, 45.00, 350.00, 'USA', 'Brunch'),\r\n",
                "(20, 'BBQ Ribs', 'Cook ribs with barbecue sauce.', 30.00, 20.00, 15.00, 600.00, 'USA', 'Barbecue'),\r\n",
                "(21, 'Farmers Market Salad', 'Combine fresh local vegetables.', 4.00, 3.00, 12.00, 100.00, 'USA', 'Farm-to-table'),\r\n",
                "(22, 'Zucchini Noodles with Meat Sauce', 'Serve zucchini noodles with meat sauce.', 25.00, 10.00, 15.00, 300.00, 'USA', 'Whole30'),\r\n",
                "(23, 'Avocado Toast', 'Serve avocado on whole-grain bread.', 4.00, 10.00, 20.00, 300.00, 'USA', 'Low-sugar'),\r\n",
                "(24, 'Kimchi Fried Rice', 'Fry rice with kimchi and vegetables.', 5.00, 1.00, 35.00, 250.00, 'Korea', 'Fermented Foods'),\r\n",
                "(25, 'Herb-Infused Olive Oil', 'Infuse olive oil with fresh herbs.', 0.00, 14.00, 0.00, 120.00, 'Italy', 'Fresh Herbs'),\r\n",
                "(26, 'Chia Seed Pudding', 'Soak chia seeds in almond milk.', 5.00, 10.00, 15.00, 150.00, 'USA', 'Superfoods'),\r\n",
                "(27, 'Trail Mix', 'Combine nuts and dried fruits.', 5.00, 15.00, 30.00, 300.00, 'USA', 'Snacks'),\r\n",
                "(28, 'Tomato Basil Soup', 'Blend tomatoes and basil.', 4.00, 2.00, 15.00, 100.00, 'USA', 'Soups'),\r\n",
                "(29, 'Greek Salad', 'Combine cucumbers, tomatoes, and feta.', 4.00, 12.00, 15.00, 150.00, 'Greece', 'Salads'),\r\n",
                "(30, 'Lasagna', 'Layer pasta, cheese, and meat.', 20.00, 15.00, 40.00, 600.00, 'Italy', 'Casseroles'),\r\n",
                "(31, 'Banana Bread', 'Mix bananas and bake into bread.', 4.00, 5.00, 35.00, 250.00, 'USA', 'Baking'),\r\n",
                "(32, 'Berry Smoothie', 'Blend berries with yogurt.', 4.00, 2.00, 20.00, 150.00, 'USA', 'Smoothies'),\r\n",
                "(33, 'Herbed Rice', 'Cook rice with fresh herbs.', 4.00, 1.00, 20.00, 120.00, 'USA', 'Savory'),\r\n",
                "(34, 'Spaghetti Aglio e Olio', 'Cook spaghetti with garlic and olive oil.', 8.00, 5.00, 40.00, 350.00, 'Italy', 'Pasta'),\r\n",
                "(35, 'Falafel', 'Deep fry spiced chickpea balls.', 12.00, 10.00, 30.00, 250.00, 'Middle East', 'Street Food');\r\n",
                "\r\n",
                "INSERT INTO recipeTags (recipeID, tags) VALUES\r\n",
                "(1, 'Vegetarian'),\r\n",
                "(2, 'Low-carb'),\r\n",
                "(3, 'Vegan'),\r\n",
                "(4, 'Healthy'),\r\n",
                "(5, 'Mexican'),\r\n",
                "(6, 'Italian'),\r\n",
                "(7, 'Dessert'),\r\n",
                "(8, 'Quick Meals'),\r\n",
                "(9, 'Seafood'),\r\n",
                "(10, 'Breakfast'),\r\n",
                "(11, 'Paleo'),\r\n",
                "(12, 'Mediterranean'),\r\n",
                "(13, 'Gluten-free'),\r\n",
                "(14, 'Dairy-free'),\r\n",
                "(15, 'Keto'),\r\n",
                "(16, 'Comfort Food'),\r\n",
                "(17, 'Asian'),\r\n",
                "(18, 'Spicy'),\r\n",
                "(19, 'Brunch'),\r\n",
                "(20, 'Barbecue'),\r\n",
                "(21, 'Farm-to-table'),\r\n",
                "(22, 'Whole30'),\r\n",
                "(23, 'Low-sugar'),\r\n",
                "(24, 'Fermented Foods'),\r\n",
                "(25, 'Fresh Herbs'),\r\n",
                "(26, 'Superfoods'),\r\n",
                "(27, 'Snacks'),\r\n",
                "(28, 'Soups'),\r\n",
                "(29, 'Salads'),\r\n",
                "(30, 'Casseroles'),\r\n",
                "(31, 'Baking'),\r\n",
                "(32, 'Smoothies'),\r\n",
                "(33, 'Savory'),\r\n",
                "(34, 'Pasta'),\r\n",
                "(35, 'Street Food');\r\n",
                "\r\n",
                "-- Inserting into recipeCookingSupplies\r\n",
                "INSERT INTO recipeCookingSupplies (recipeID, cookingSupplies) VALUES\r\n",
                "(1, 'Baking dish, Knife, Cutting board, Spoon'),\r\n",
                "(2, 'Food processor, Knife, Bowl, Measuring cups'),\r\n",
                "(3, 'Pot, Knife, Cutting board, Spoon'),\r\n",
                "(4, 'Grill pan, Tongs, Knife, Salad bowl'),\r\n",
                "(5, 'Skillet, Spatula, Knife, Serving plate'),\r\n",
                "(6, 'Pot, Mixing bowl, Spoon, Knife'),\r\n",
                "(7, 'Baking pan, Mixing bowl, Whisk, Measuring cups'),\r\n",
                "(8, 'Blender, Bowl, Spoon, Knife'),\r\n",
                "(9, 'Baking sheet, Grill, Tongs, Knife'),\r\n",
                "(10, 'Skillet, Spatula, Mixing bowl, Measuring cups'),\r\n",
                "(11, 'Grill pan, Tongs, Meat thermometer, Knife'),\r\n",
                "(12, 'Salad bowl, Knife, Cutting board, Spoon'),\r\n",
                "(13, 'Baking sheet, Mixing bowl, Whisk, Measuring cups'),\r\n",
                "(14, 'Baking sheet, Knife, Grater, Mixing bowl'),\r\n",
                "(15, 'Baking sheet, Knife, Oven, Bowl'),\r\n",
                "(16, 'Pot, Baking dish, Measuring cups, Spoon'),\r\n",
                "(17, 'Bamboo mat, Knife, Cutting board, Bowl'),\r\n",
                "(18, 'Pot, Ladle, Knife, Bowl'),\r\n",
                "(19, 'Skillet, Whisk, Mixing bowl, Measuring cups'),\r\n",
                "(20, 'Grill, Tongs, Basting brush, Knife'),\r\n",
                "(21, 'Salad bowl, Knife, Cutting board, Spoon'),\r\n",
                "(22, 'Skillet, Knife, Spiralizer, Spoon'),\r\n",
                "(23, 'Toaster, Knife, Cutting board, Bowl'),\r\n",
                "(24, 'Wok, Spoon, Knife, Bowl'),\r\n",
                "(25, 'Jar, Knife, Cutting board, Measuring cups'),\r\n",
                "(26, 'Bowl, Measuring cups, Spoon, Fridge container'),\r\n",
                "(27, 'Mixing bowl, Spoon, Container for storage'),\r\n",
                "(28, 'Blender, Pot, Spoon, Knife'),\r\n",
                "(29, 'Salad bowl, Knife, Spoon, Measuring cups'),\r\n",
                "(30, 'Baking dish, Knife, Cutting board, Spoon'),\r\n",
                "(31, 'Loaf pan, Mixing bowl, Measuring cups, Spoon'),\r\n",
                "(32, 'Blender, Bowl, Spoon, Measuring cups'),\r\n",
                "(33, 'Pot, Knife, Cutting board, Spoon'),\r\n",
                "(34, 'Pot, Knife, Spoon, Strainer'),\r\n",
                "(35, 'Frying pan, Spoon, Knife, Mixing bowl');\r\n",
                "\r\n",
                "-- Inserting into review\r\n",
                "INSERT INTO review (recipeID, userID, rating, date, [public], comment) VALUES\r\n",
                "(1, 1, 5, '2024-10-01', 1, 'Delicious and easy to make!'),\r\n",
                "(2, 2, 4, '2024-10-02', 1, 'Great low-carb option.'),\r\n",
                "(3, 3, 5, '2024-10-03', 1, 'Best curry I’ve ever made!'),\r\n",
                "(4, 4, 4, '2024-10-04', 1, 'A healthy and filling salad.'),\r\n",
                "(5, 5, 3, '2024-10-05', 1, 'Good, but a bit too salty for my taste.'),\r\n",
                "(6, 6, 4, '2024-10-06', 1, 'Love the fresh veggies in this!'),\r\n",
                "(7, 7, 5, '2024-10-07', 1, 'Decadent and rich. Perfect dessert!'),\r\n",
                "(8, 8, 4, '2024-10-08', 1, 'Quick and refreshing breakfast option.'),\r\n",
                "(9, 9, 5, '2024-10-09', 1, 'Absolutely fantastic salmon!'),\r\n",
                "(10, 10, 4, '2024-10-10', 1, 'Fluffy and delicious pancakes.'),\r\n",
                "(11, 11, 5, '2024-10-11', 1, 'Perfectly cooked steak every time.'),\r\n",
                "(12, 12, 4, '2024-10-12', 1, 'Fresh and flavorful Greek salad.'),\r\n",
                "(13, 13, 5, '2024-10-13', 1, 'A fantastic gluten-free treat!'),\r\n",
                "(14, 14, 3, '2024-10-14', 1, 'Interesting take on pizza crust.'),\r\n",
                "(15, 15, 5, '2024-10-15', 1, 'Crispy and tasty chips!'),\r\n",
                "(16, 16, 4, '2024-10-16', 1, 'Comfort food at its best!'),\r\n",
                "(17, 17, 5, '2024-10-17', 1, 'Amazing sushi rolls, very authentic!'),\r\n",
                "(18, 18, 4, '2024-10-18', 1, 'Spicy and satisfying ramen.'),\r\n",
                "(19, 19, 5, '2024-10-19', 1, 'A perfect brunch dish!'),\r\n",
                "(20, 20, 4, '2024-10-20', 1, 'Great flavor, but very rich.'),\r\n",
                "(21, 21, 5, '2024-10-21', 1, 'Fresh and light salad!'),\r\n",
                "(22, 22, 4, '2024-10-22', 1, 'Creative and healthy dish.'),\r\n",
                "(23, 23, 5, '2024-10-23', 1, 'Simple yet delicious!'),\r\n",
                "(24, 24, 4, '2024-10-24', 1, 'A fun and flavorful dish!'),\r\n",
                "(25, 25, 5, '2024-10-25', 1, 'Perfect for enhancing flavors!'),\r\n",
                "(26, 26, 4, '2024-10-26', 1, 'Nutritious and tasty pudding.'),\r\n",
                "(27, 27, 5, '2024-10-27', 1, 'Great snack for any time!'),\r\n",
                "(28, 28, 4, '2024-10-28', 1, 'Comforting and delicious soup.'),\r\n",
                "(29, 29, 5, '2024-10-29', 1, 'Classic and very refreshing!'),\r\n",
                "(30, 30, 5, '2024-10-30', 1, 'A family favorite!'),\r\n",
                "(31, 31, 4, '2024-10-31', 1, 'Moist and flavorful bread.'),\r\n",
                "(32, 32, 5, '2024-11-01', 1, 'Berry delicious!'),\r\n",
                "(33, 33, 4, '2024-11-02', 1, 'Savory and aromatic rice.'),\r\n",
                "(34, 34, 5, '2024-11-03', 1, 'A delightful pasta dish!'),\r\n",
                "(35, 35, 4, '2024-11-04', 1, 'Crispy and flavorful falafel.');\r\n",
                "\r\n",
                "-- Inserting into plan\r\n",
                "INSERT INTO [plan] (recipeID, date, time) VALUES\r\n",
                "(1, '2024-10-01', '18:00:00'), -- Dinner\r\n",
                "(2, '2024-10-02', '12:00:00'), -- Lunch\r\n",
                "(3, '2024-10-03', '19:30:00'), -- Dinner\r\n",
                "(4, '2024-10-04', '13:00:00'), -- Lunch\r\n",
                "(5, '2024-10-05', '18:30:00'), -- Dinner\r\n",
                "(6, '2024-10-06', '12:30:00'), -- Lunch\r\n",
                "(7, '2024-10-07', '19:00:00'), -- Dinner\r\n",
                "(8, '2024-10-08', '08:00:00'), -- Breakfast\r\n",
                "(9, '2024-10-09', '19:00:00'), -- Dinner\r\n",
                "(10, '2024-10-10', '08:30:00'), -- Breakfast\r\n",
                "(11, '2024-10-11', '18:00:00'), -- Dinner\r\n",
                "(12, '2024-10-12', '12:00:00'), -- Lunch\r\n",
                "(13, '2024-10-13', '15:00:00'), -- Snack\r\n",
                "(14, '2024-10-14', '18:30:00'), -- Dinner\r\n",
                "(15, '2024-10-15', '10:00:00'), -- Snack\r\n",
                "(16, '2024-10-16', '19:00:00'), -- Dinner\r\n",
                "(17, '2024-10-17', '13:30:00'), -- Lunch\r\n",
                "(18, '2024-10-18', '19:00:00'), -- Dinner\r\n",
                "(19, '2024-10-19', '10:30:00'), -- Breakfast\r\n",
                "(20, '2024-10-20', '18:00:00'), -- Dinner\r\n",
                "(21, '2024-10-21', '12:00:00'), -- Lunch\r\n",
                "(22, '2024-10-22', '18:00:00'), -- Dinner\r\n",
                "(23, '2024-10-23', '08:00:00'), -- Breakfast\r\n",
                "(24, '2024-10-24', '13:00:00'), -- Lunch\r\n",
                "(25, '2024-10-25', '18:00:00'), -- Dinner\r\n",
                "(26, '2024-10-26', '15:00:00'), -- Snack\r\n",
                "(27, '2024-10-27', '12:00:00'), -- Lunch\r\n",
                "(28, '2024-10-28', '19:00:00'), -- Dinner\r\n",
                "(29, '2024-10-29', '12:00:00'), -- Lunch\r\n",
                "(30, '2024-10-30', '18:00:00'), -- Dinner\r\n",
                "(31, '2024-10-31', '10:00:00'), -- Snack\r\n",
                "(32, '2024-11-01', '08:00:00'), -- Breakfast\r\n",
                "(33, '2024-11-02', '12:00:00'), -- Lunch\r\n",
                "(34, '2024-11-03', '19:00:00'), -- Dinner\r\n",
                "(35, '2024-11-04', '12:00:00'); -- Lunch\r\n",
                "\r\n",
                "INSERT INTO ingredient (name, type) VALUES\r\n",
                "('Bell Peppers', 'Vegetable'),\r\n",
                "('Quinoa', 'Grain'),\r\n",
                "('Black Beans', 'Legume'),\r\n",
                "('Cauliflower', 'Vegetable'),\r\n",
                "('Olive Oil', 'Oil'),\r\n",
                "('Chickpeas', 'Legume'),\r\n",
                "('Tomatoes', 'Fruit'),\r\n",
                "('Spices', 'Spice'),\r\n",
                "('Chicken Breast', 'Meat'),\r\n",
                "('Mixed Greens', 'Vegetable'),\r\n",
                "('Olive Oil', 'Oil'),\r\n",
                "('Tortillas', 'Grain'),\r\n",
                "('Ground Beef', 'Meat'),\r\n",
                "('Lettuce', 'Vegetable'),\r\n",
                "('Pasta', 'Grain'),\r\n",
                "('Mixed Vegetables', 'Vegetable'),\r\n",
                "('Olive Oil', 'Oil'),\r\n",
                "('Flour', 'Grain'),\r\n",
                "('Cocoa Powder', 'Baking'),\r\n",
                "('Sugar', 'Sweetener'),\r\n",
                "('Bananas', 'Fruit'),\r\n",
                "('Berries', 'Fruit'),\r\n",
                "('Yogurt', 'Dairy'),\r\n",
                "('Salmon', 'Fish'),\r\n",
                "('Herbs', 'Herb'),\r\n",
                "('Flour', 'Grain'),\r\n",
                "('Eggs', 'Dairy'),\r\n",
                "('Milk', 'Dairy'),\r\n",
                "('Steak', 'Meat'),\r\n",
                "('Spices', 'Spice'),\r\n",
                "('Cucumber', 'Vegetable'),\r\n",
                "('Tomato', 'Fruit'),\r\n",
                "('Feta Cheese', 'Dairy'),\r\n",
                "('Almond Flour', 'Grain'),\r\n",
                "('Sugar', 'Sweetener'),\r\n",
                "('Eggs', 'Dairy'),\r\n",
                "('Cauliflower', 'Vegetable'),\r\n",
                "('Cheese', 'Dairy'),\r\n",
                "('Egg', 'Dairy'),\r\n",
                "('Zucchini', 'Vegetable'),\r\n",
                "('Olive Oil', 'Oil'),\r\n",
                "('Pasta', 'Grain'),\r\n",
                "('Cheese', 'Dairy'),\r\n",
                "('Milk', 'Dairy'),\r\n",
                "('Sushi Rice', 'Grain'),\r\n",
                "('Nori', 'Seaweed'),\r\n",
                "('Fish', 'Fish'),\r\n",
                "('Ramen Noodles', 'Grain'),\r\n",
                "('Broth', 'Liquid'),\r\n",
                "('Spices', 'Spice'),\r\n",
                "('Bread', 'Grain'),\r\n",
                "('Eggs', 'Dairy'),\r\n",
                "('Cinnamon', 'Spice'),\r\n",
                "('Pork Ribs', 'Meat'),\r\n",
                "('BBQ Sauce', 'Condiment'),\r\n",
                "('Mixed Greens', 'Vegetable'),\r\n",
                "('Tomatoes', 'Fruit'),\r\n",
                "('Cucumbers', 'Vegetable'),\r\n",
                "('Zucchini', 'Vegetable'),\r\n",
                "('Ground Beef', 'Meat'),\r\n",
                "('Tomato Sauce', 'Condiment'),\r\n",
                "('Whole Grain Bread', 'Grain'),\r\n",
                "('Avocado', 'Fruit'),\r\n",
                "('Rice', 'Grain'),\r\n",
                "('Kimchi', 'Fermented'),\r\n",
                "('Vegetables', 'Vegetable'),\r\n",
                "('Olive Oil', 'Oil'),\r\n",
                "('Fresh Herbs', 'Herb'),\r\n",
                "('Chia Seeds', 'Seed'),\r\n",
                "('Almond Milk', 'Dairy'),\r\n",
                "('Nuts', 'Nut'),\r\n",
                "('Dried Fruit', 'Fruit'),\r\n",
                "('Tomatoes', 'Fruit'),\r\n",
                "('Basil', 'Herb'),\r\n",
                "('Broth', 'Liquid'),\r\n",
                "('Cucumber', 'Vegetable'),\r\n",
                "('Tomato', 'Fruit'),\r\n",
                "('Feta Cheese', 'Dairy'),\r\n",
                "('Lasagna Noodles', 'Grain'),\r\n",
                "('Cheese', 'Dairy'),\r\n",
                "('Ground Beef', 'Meat'),\r\n",
                "('Bananas', 'Fruit'),\r\n",
                "('Flour', 'Grain'),\r\n",
                "('Sugar', 'Sweetener'),\r\n",
                "('Berries', 'Fruit'),\r\n",
                "('Yogurt', 'Dairy'),\r\n",
                "('Milk', 'Dairy'),\r\n",
                "('Rice', 'Grain'),\r\n",
                "('Fresh Herbs', 'Herb'),\r\n",
                "('Spaghetti', 'Grain'),\r\n",
                "('Garlic', 'Vegetable'),\r\n",
                "('Olive Oil', 'Oil'),\r\n",
                "('Chickpeas', 'Legume'),\r\n",
                "('Herbs', 'Herb'),\r\n",
                "('Spices', 'Spice');\r\n",
                "\r\n",
                "INSERT INTO planIngredients (planID, ingredientID, amountNeeded) VALUES\r\n",
                "(1, 1, '2 whole'),               -- Stuffed Peppers: Bell Peppers\r\n",
                "(1, 2, '1 cup'),                 -- Stuffed Peppers: Quinoa\r\n",
                "(1, 3, '1 cup'),                 -- Stuffed Peppers: Black Beans\r\n",
                "(2, 4, '1 medium'),              -- Cauliflower Rice: Cauliflower\r\n",
                "(2, 5, '1 tbsp'),                -- Cauliflower Rice: Olive Oil\r\n",
                "(3, 6, '1 can'),                 -- Chickpea Curry: Chickpeas\r\n",
                "(3, 7, '1 can'),                 -- Chickpea Curry: Tomatoes\r\n",
                "(3, 8, '2 tbsp'),                -- Chickpea Curry: Spices\r\n",
                "(4, 9, '1 breast'),              -- Grilled Chicken Salad: Chicken Breast\r\n",
                "(4, 10, '2 cups'),               -- Grilled Chicken Salad: Mixed Greens\r\n",
                "(4, 5, '1 tbsp'),                -- Grilled Chicken Salad: Olive Oil\r\n",
                "\r\n",
                "(5, 11, '4 tortillas'),           -- Tacos: Tortillas\r\n",
                "(5, 12, '1 lb'),                 -- Tacos: Ground Beef\r\n",
                "(5, 13, '1 cup'),                -- Tacos: Lettuce\r\n",
                "(6, 14, '2 cups'),               -- Pasta Primavera: Pasta\r\n",
                "(6, 15, '2 cups'),               -- Pasta Primavera: Mixed Vegetables\r\n",
                "(6, 5, '1 tbsp'),                -- Pasta Primavera: Olive Oil\r\n",
                "(7, 16, '1.5 cups'),             -- Chocolate Cake: Flour\r\n",
                "(7, 17, '0.75 cup'),             -- Chocolate Cake: Cocoa Powder\r\n",
                "(7, 18, '1 cup'),                -- Chocolate Cake: Sugar\r\n",
                "(8, 19, '2 large'),              -- Smoothie Bowl: Bananas\r\n",
                "(8, 20, '1 cup'),                -- Smoothie Bowl: Berries\r\n",
                "(8, 21, '0.5 cup'),              -- Smoothie Bowl: Yogurt\r\n",
                "(9, 22, '1 fillet'),             -- Grilled Salmon: Salmon\r\n",
                "(9, 23, '0.5 tbsp'),             -- Grilled Salmon: Herbs\r\n",
                "(10, 24, '1 cup'),               -- Pancakes: Flour\r\n",
                "(10, 25, '1 large'),             -- Pancakes: Eggs\r\n",
                "(10, 26, '0.5 cup'),             -- Pancakes: Milk\r\n",
                "(11, 27, '1 steak'),             -- Grilled Steak: Steak\r\n",
                "(11, 8, '1/4 tsp'),              -- Grilled Steak: Spices\r\n",
                "(12, 28, '1 medium'),            -- Greek Salad: Cucumber\r\n",
                "(12, 29, '1 medium'),            -- Greek Salad: Tomato\r\n",
                "(12, 30, '0.5 cup'),             -- Greek Salad: Feta Cheese\r\n",
                "(13, 31, '1 cup'),               -- Almond Flour Cookies: Almond Flour\r\n",
                "(13, 18, '0.5 cup'),             -- Almond Flour Cookies: Sugar\r\n",
                "(13, 25, '1 large'),             -- Almond Flour Cookies: Eggs\r\n",
                "(14, 4, '1 medium'),             -- Cauliflower Pizza Crust: Cauliflower\r\n",
                "(14, 30, '0.5 cup'),             -- Cauliflower Pizza Crust: Cheese\r\n",
                "(14, 25, '1 large'),             -- Cauliflower Pizza Crust: Egg\r\n",
                "(15, 32, '2 medium'),            -- Zucchini Chips: Zucchini\r\n",
                "(15, 5, '1 tbsp'),               -- Zucchini Chips: Olive Oil\r\n",
                "(16, 14, '2 cups'),              -- Mac and Cheese: Pasta\r\n",
                "(16, 30, '2 cups'),              -- Mac and Cheese: Cheese\r\n",
                "(16, 26, '1 cup'),               -- Mac and Cheese: Milk\r\n",
                "(17, 33, '2 cups'),              -- Sushi Rolls: Sushi Rice\r\n",
                "(17, 34, '0.5 sheets'),          -- Sushi Rolls: Nori\r\n",
                "(17, 22, '0.5 lb'),              -- Sushi Rolls: Fish\r\n",
                "(18, 35, '1 package'),           -- Chili Ramen: Ramen Noodles\r\n",
                "(18, 36, '1 cup'),               -- Chili Ramen: Broth\r\n",
                "(18, 8, '1 tbsp'),               -- Chili Ramen: Spices\r\n",
                "\r\n",
                "(19, 37, '2 slices'),            -- French Toast: Bread\r\n",
                "(19, 25, '1 large'),             -- French Toast: Eggs\r\n",
                "(19, 8, '1/2 tsp'),              -- French Toast: Cinnamon\r\n",
                "(20, 38, '2 lbs'),               -- BBQ Ribs: Pork Ribs\r\n",
                "(20, 39, '0.5 cup'),             -- BBQ Ribs: BBQ Sauce\r\n",
                "(21, 40, '2 cups'),              -- Farmers Market Salad: Mixed Greens\r\n",
                "(21, 7, '1 medium'),             -- Farmers Market Salad: Tomatoes\r\n",
                "(21, 28, '1 medium'),            -- Farmers Market Salad: Cucumbers\r\n",
                "(22, 32, '2 medium'),            -- Zucchini Noodles with Meat Sauce: Zucchini\r\n",
                "(22, 12, '1 lb'),                -- Zucchini Noodles with Meat Sauce: Ground Beef\r\n",
                "(22, 40, '0.5 cup'),             -- Zucchini Noodles with Meat Sauce: Tomato Sauce\r\n",
                "(23, 41, '2 slices'),            -- Avocado Toast: Whole Grain Bread\r\n",
                "(23, 42, '1 whole'),             -- Avocado Toast: Avocado\r\n",
                "(24, 43, '1 cup'),               -- Kimchi Fried Rice: Rice\r\n",
                "(24, 44, '0.5 cup'),             -- Kimchi Fried Rice: Kimchi\r\n",
                "(24, 15, '1 cup'),               -- Kimchi Fried Rice: Vegetables\r\n",
                "(25, 5, '1 cup'),                -- Herb-Infused Olive Oil: Olive Oil\r\n",
                "(25, 23, '0.5 cup'),             -- Herb-Infused Olive Oil: Fresh Herbs\r\n",
                "(26, 45, '1/4 cup'),             -- Chia Seed Pudding: Chia Seeds\r\n",
                "(26, 46, '1 cup'),               -- Chia Seed Pudding: Almond Milk\r\n",
                "(27, 47, '1 cup'),               -- Trail Mix: Nuts\r\n",
                "(27, 48, '0.5 cup'),             -- Trail Mix: Dried Fruit\r\n",
                "(28, 7, '2 cups'),               -- Tomato Basil Soup: Tomatoes\r\n",
                "(28, 49, '0.5 cup'),             -- Tomato Basil Soup: Basil\r\n",
                "(28, 36, '1 cup'),               -- Tomato Basil Soup: Broth\r\n",
                "(29, 40, '1 medium'),            -- Greek Salad: Cucumber\r\n",
                "(29, 7, '1 medium'),             -- Greek Salad: Tomato\r\n",
                "(29, 30, '0.5 cup'),             -- Greek Salad: Feta Cheese\r\n",
                "(30, 50, '2 cups'),              -- Lasagna: Lasagna Noodles\r\n",
                "(30, 30, '2 cups'),              -- Lasagna: Cheese\r\n",
                "(30, 12, '1 lb'),                -- Lasagna: Ground Beef\r\n",
                "(31, 19, '2 ripe'),              -- Banana Bread: Bananas\r\n",
                "(31, 16, '1.5 cups'),            -- Banana Bread: Flour\r\n",
                "(31, 18, '0.5 cup'),             -- Banana Bread: Sugar\r\n",
                "(32, 20, '1 cup'),               -- Berry Smoothie: Berries\r\n",
                "(32, 21, '0.5 cup'),             -- Berry Smoothie: Yogurt\r\n",
                "(32, 26, '0.5 cup'),             -- Berry Smoothie: Milk\r\n",
                "(33, 43, '1 cup'),               -- Rice Bowl: Rice\r\n",
                "(33, 23, '0.5 cup'),             -- Rice Bowl: Fresh Herbs\r\n",
                "(34, 14, '1 lb'),                -- Garlic Pasta: Spaghetti\r\n",
                "(34, 50, '2 cloves'),            -- Garlic Pasta: Garlic\r\n",
                "(34, 5, '1/4 cup'),              -- Garlic Pasta: Olive Oil\r\n",
                "(35, 6, '1 can'),                -- Spiced Chickpeas: Chickpeas\r\n",
                "(35, 23, '1 tsp'),               -- Spiced Chickpeas: Herbs\r\n",
                "(35, 8, '1/2 tsp');              -- Spiced Chickpeas: Spices\r\n",
                "\r\n",
                "\r\n",
                "INSERT INTO saved (userID, recipeID, tried) VALUES\r\n",
                "(1, 1, 0),   -- User 1 saves Stuffed Peppers\r\n",
                "(1, 3, 1),   -- User 1 tries Chickpea Curry\r\n",
                "(2, 4, 0),   -- User 2 saves Grilled Chicken Salad\r\n",
                "(2, 10, 1),  -- User 2 tries Pancakes\r\n",
                "(3, 15, 0),  -- User 3 saves Zucchini Chips\r\n",
                "(3, 2, 0),   -- User 3 saves Cauliflower Rice\r\n",
                "(4, 5, 0),   -- User 4 saves Tacos\r\n",
                "(5, 6, 1),   -- User 5 tries Pasta Primavera\r\n",
                "(5, 12, 1),  -- User 5 tries Greek Salad\r\n",
                "(5, 20, 0),  -- User 5 saves BBQ Ribs\r\n",
                "(6, 7, 1),   -- User 6 tries Chocolate Cake\r\n",
                "(6, 9, 0),   -- User 6 saves Grilled Salmon\r\n",
                "(7, 18, 1),  -- User 7 tries Chili Ramen\r\n",
                "(8, 22, 0),  -- User 8 saves Zucchini Noodles with Meat Sauce\r\n",
                "(9, 29, 0),  -- User 9 saves Greek Salad\r\n",
                "(10, 8, 1),  -- User 10 tries Smoothie Bowl\r\n",
                "(14, 11, 0), -- User 14 saves Grilled Steak\r\n",
                "(14, 13, 0), -- User 14 saves Almond Flour Cookies\r\n",
                "(14, 17, 1), -- User 14 tries Sushi Rolls\r\n",
                "(14, 30, 0), -- User 14 saves Lasagna\r\n",
                "(15, 14, 0), -- User 15 saves Cauliflower Pizza Crust\r\n",
                "(16, 16, 1), -- User 16 tries Mac and Cheese\r\n",
                "(20, 19, 0), -- User 20 saves French Toast\r\n",
                "(35, 24, 1), -- User 35 tries Kimchi Fried Rice\r\n",
                "(25, 26, 0); -- User 25 saves Chia Seed Pudding\r\n",
                "\r\n",
                "\r\n",
                "INSERT INTO userIngredients (userID, ingredientID, userAmount) VALUES\r\n",
                "(1, 1, '3 whole'),           -- Bell Peppers\r\n",
                "(1, 4, '1/2 cup'),           -- Olive Oil\r\n",
                "(1, 10, '2 cups'),           -- Flour\r\n",
                "(1, 12, '200 g'),            -- Feta Cheese\r\n",
                "\r\n",
                "(2, 2, '1 cup'),             -- Quinoa\r\n",
                "(2, 3, '1 can'),             -- Chickpeas\r\n",
                "(2, 7, '100 g'),             -- Cocoa Powder\r\n",
                "(2, 19, '1 loaf'),           -- Bread\r\n",
                "(3, 5, '250 g'),             -- Ground Beef\r\n",
                "(3, 8, '2 medium'),          -- Bananas\r\n",
                "(3, 14, '1 head'),           -- Cauliflower\r\n",
                "(4, 6, '200 g'),             -- Pasta\r\n",
                "(4, 15, '3 small'),          -- Zucchini\r\n",
                "(4, 20, '1 bottle'),         -- BBQ Sauce\r\n",
                "(5, 17, '300 g'),            -- Sushi Rice\r\n",
                "(5, 18, '2 packs'),          -- Ramen Noodles\r\n",
                "(5, 26, '100 g'),            -- Chia Seeds\r\n",
                "(6, 11, '6 large'),          -- Eggs\r\n",
                "(6, 9, '2 fillets'),         -- Salmon\r\n",
                "(6, 22, '3 medium'),         -- Zucchini\r\n",
                "(7, 4, '1 cup'),             -- Olive Oil\r\n",
                "(7, 21, '150 g'),            -- Mixed Greens\r\n",
                "(7, 23, '2 slices'),         -- Whole Grain Bread\r\n",
                "(8, 12, '150 g'),            -- Feta Cheese\r\n",
                "(8, 28, '1 bunch'),          -- Basil\r\n",
                "(8, 24, '1 cup'),            -- Rice\r\n",
                "(9, 14, '2 heads'),          -- Cauliflower\r\n",
                "(9, 16, '200 g'),            -- Cheese\r\n",
                "(9, 25, '1 bottle'),         -- Olive Oil\r\n",
                "(10, 30, '250 g'),           -- Lasagna Noodles\r\n",
                "(10, 15, '2 medium'),        -- Zucchini\r\n",
                "(10, 20, '1 jar'),           -- BBQ Sauce\r\n",
                "(11, 1, '4 whole'),          -- Bell Peppers\r\n",
                "(11, 3, '1 bag'),            -- Chickpeas\r\n",
                "(11, 19, '1 loaf'),          -- Bread\r\n",
                "(12, 2, '1/2 cup'),          -- Quinoa\r\n",
                "(12, 5, '1 kg'),             -- Ground Beef\r\n",
                "(12, 7, '300 g'),            -- Cocoa Powder\r\n",
                "(13, 6, '200 g'),            -- Pasta\r\n",
                "(13, 8, '5 medium'),         -- Bananas\r\n",
                "(13, 26, '50 g'),            -- Chia Seeds\r\n",
                "(14, 10, '500 g'),           -- Flour\r\n",
                "(14, 21, '200 g'),           -- Mixed Greens\r\n",
                "(14, 30, '1 packet'),        -- Lasagna Noodles\r\n",
                "(15, 15, '2 medium'),        -- Zucchini\r\n",
                "(15, 18, '1 pack'),          -- Ramen Noodles\r\n",
                "(15, 24, '1 cup'),           -- Rice\r\n",
                "(16, 9, '3 fillets'),        -- Salmon\r\n",
                "(16, 17, '1 pack'),          -- Sushi Rice\r\n",
                "(16, 22, '4 medium'),        -- Zucchini\r\n",
                "(17, 11, '6 large'),         -- Eggs\r\n",
                "(17, 4, '1/2 cup'),          -- Olive Oil\r\n",
                "(17, 23, '2 slices'),        -- Whole Grain Bread\r\n",
                "(18, 12, '150 g'),           -- Feta Cheese\r\n",
                "(18, 14, '1 head'),          -- Cauliflower\r\n",
                "(18, 28, '1 bunch'),         -- Basil\r\n",
                "(19, 6, '250 g'),            -- Pasta\r\n",
                "(19, 3, '1 can'),            -- Chickpeas\r\n",
                "(19, 19, '1 loaf'),          -- Bread\r\n",
                "(20, 2, '1 cup'),            -- Quinoa\r\n",
                "(20, 5, '500 g'),            -- Ground Beef\r\n",
                "(20, 30, '250 g'),           -- Lasagna Noodles\r\n",
                "(21, 15, '3 medium'),        -- Zucchini\r\n",
                "(21, 22, '3 medium'),        -- Zucchini\r\n",
                "(21, 17, '200 g'),           -- Sushi Rice\r\n",
                "(22, 10, '300 g'),           -- Flour\r\n",
                "(22, 12, '250 g'),           -- Feta Cheese\r\n",
                "(22, 4, '1 cup'),            -- Olive Oil\r\n",
                "(23, 8, '4 medium'),         -- Bananas\r\n",
                "(23, 1, '4 whole'),          -- Bell Peppers\r\n",
                "(23, 19, '1 loaf'),          -- Bread\r\n",
                "(24, 11, '6 large'),         -- Eggs\r\n",
                "(24, 16, '150 g'),           -- Cheese\r\n",
                "(24, 30, '1 packet'),        -- Lasagna Noodles\r\n",
                "(25, 18, '2 packs'),         -- Ramen Noodles\r\n",
                "(25, 3, '1 bag'),            -- Chickpeas\r\n",
                "(25, 26, '100 g'),           -- Chia Seeds\r\n",
                "(26, 14, '2 heads'),         -- Cauliflower\r\n",
                "(26, 2, '1/2 cup'),          -- Quinoa\r\n",
                "(26, 20, '1 jar'),           -- BBQ Sauce\r\n",
                "(27, 7, '200 g'),            -- Cocoa Powder\r\n",
                "(27, 23, '2 slices'),        -- Whole Grain Bread\r\n",
                "(27, 4, '1 cup'),            -- Olive Oil\r\n",
                "(28, 9, '2 fillets'),        -- Salmon\r\n",
                "(28, 21, '150 g'),           -- Mixed Greens\r\n",
                "(28, 15, '2 medium'),        -- Zucchini\r\n",
                "(29, 10, '500 g'),           -- Flour\r\n",
                "(29, 8, '5 medium'),         -- Bananas\r\n",
                "(29, 22, '4 medium'),        -- Zucchini\r\n",
                "(30, 6, '250 g'),            -- Pasta\r\n",
                "(30, 12, '150 g'),           -- Feta Cheese\r\n",
                "(30, 19, '1 loaf'),          -- Bread\r\n",
                "(31, 17, '1 pack'),          -- Sushi Rice\r\n",
                "(31, 3, '1 can'),            -- Chickpeas\r\n",
                "(31, 30, '250 g'),           -- Lasagna Noodles\r\n",
                "(32, 26, '100 g'),           -- Chia Seeds\r\n",
                "(32, 4, '1/2 cup'),          -- Olive Oil\r\n",
                "(32, 5, '500 g'),            -- Ground Beef\r\n",
                "(33, 15, '2 medium'),        -- Zucchini\r\n",
                "(33, 22, '3 medium'),        -- Zucchini\r\n",
                "(33, 28, '1 bunch'),         -- Basil\r\n",
                "(34, 1, '3 whole'),          -- Bell Peppers\r\n",
                "(34, 18, '1 pack'),          -- Ramen Noodles\r\n",
                "(34, 30, '250 g'),           -- Lasagna Noodles\r\n",
                "(35, 2, '1 cup'),            -- Quinoa\r\n",
                "(35, 6, '200 g'),            -- Pasta\r\n",
                "(35, 11, '6 large');         -- Eggs\r\n",
                "\r\n",
                "\r\n",
                "INSERT INTO recipeIngredients (recipeID, ingredientID, recipeAmount) VALUES\r\n",
                "(1, 1, '3 whole'),               -- Bell Peppers\r\n",
                "(1, 2, '1 cup'),                 -- Quinoa\r\n",
                "(1, 3, '1 can'),                 -- Black Beans\r\n",
                "(2, 4, '1 head'),                -- Cauliflower\r\n",
                "(2, 5, '2 tbsp'),                -- Olive Oil\r\n",
                "(3, 6, '1 can'),                 -- Chickpeas\r\n",
                "(3, 7, '2 medium'),              -- Tomatoes\r\n",
                "(3, 8, '1 tbsp'),                -- Spices\r\n",
                "(4, 9, '2 breasts'),             -- Chicken Breast\r\n",
                "(4, 10, '4 cups'),               -- Mixed Greens\r\n",
                "(4, 5, '2 tbsp'),                -- Olive Oil\r\n",
                "(5, 11, '8 tortillas'),           -- Tortillas\r\n",
                "(5, 12, '500 g'),                -- Ground Beef\r\n",
                "(5, 13, '1 cup'),                -- Lettuce\r\n",
                "(6, 14, '300 g'),                -- Pasta\r\n",
                "(6, 15, '2 cups'),               -- Mixed Vegetables\r\n",
                "(6, 5, '2 tbsp'),                -- Olive Oil\r\n",
                "(7, 16, '2 cups'),               -- Flour\r\n",
                "(7, 17, '1 cup'),                -- Cocoa Powder\r\n",
                "(7, 18, '1 cup'),                -- Sugar\r\n",
                "(8, 19, '2 bananas'),            -- Bananas\r\n",
                "(8, 20, '1 cup'),                -- Berries\r\n",
                "(8, 21, '1 cup'),                -- Yogurt\r\n",
                "(9, 22, '2 fillets'),            -- Salmon\r\n",
                "(9, 23, '1 bunch'),              -- Herbs\r\n",
                "(10, 16, '1 cup'),               -- Flour\r\n",
                "(10, 24, '2 eggs'),              -- Eggs\r\n",
                "(10, 25, '1 cup'),               -- Milk\r\n",
                "(11, 26, '2 steaks'),            -- Steak\r\n",
                "(11, 8, '1 tbsp'),               -- Spices\r\n",
                "(12, 27, '1 cucumber'),          -- Cucumber\r\n",
                "(12, 28, '2 tomatoes'),          -- Tomato\r\n",
                "(12, 29, '100 g'),               -- Feta Cheese\r\n",
                "(13, 30, '2 cups'),              -- Almond Flour\r\n",
                "(13, 18, '1 cup'),               -- Sugar\r\n",
                "(13, 24, '2 eggs'),              -- Eggs\r\n",
                "(14, 4, '1 head'),               -- Cauliflower\r\n",
                "(14, 31, '1 cup'),               -- Cheese\r\n",
                "(14, 24, '1 egg'),               -- Egg\r\n",
                "(15, 32, '2 zucchinis'),         -- Zucchini\r\n",
                "(15, 5, '2 tbsp'),               -- Olive Oil\r\n",
                "(16, 14, '250 g'),               -- Pasta\r\n",
                "(16, 31, '1 cup'),               -- Cheese\r\n",
                "(16, 24, '1 cup'),               -- Milk\r\n",
                "(17, 33, '1 cup'),               -- Sushi Rice\r\n",
                "(17, 34, '4 sheets'),            -- Nori\r\n",
                "(17, 22, '150 g'),               -- Fish\r\n",
                "(18, 35, '2 packs'),             -- Ramen Noodles\r\n",
                "(18, 36, '4 cups'),              -- Broth\r\n",
                "(18, 8, '1 tbsp'),               -- Spices\r\n",
                "(19, 37, '4 slices'),            -- Bread\r\n",
                "(19, 24, '2 eggs'),              -- Eggs\r\n",
                "(19, 8, '1 tsp'),                -- Cinnamon\r\n",
                "\r\n",
                "(20, 38, '2 kg'),                -- Pork Ribs\r\n",
                "(20, 39, '1 cup'),               -- BBQ Sauce\r\n",
                "(21, 10, '4 cups'),              -- Mixed Greens\r\n",
                "(21, 27, '2 tomatoes'),          -- Tomatoes\r\n",
                "(21, 38, '1 cucumber'),          -- Cucumbers\r\n",
                "(22, 32, '2 zucchinis'),         -- Zucchini\r\n",
                "(22, 12, '500 g'),               -- Ground Beef\r\n",
                "(22, 39, '1 cup'),               -- Tomato Sauce\r\n",
                "(23, 40, '4 slices'),            -- Whole Grain Bread\r\n",
                "(23, 41, '2 avocados'),          -- Avocado\r\n",
                "(24, 14, '2 cups'),              -- Rice\r\n",
                "(24, 42, '1 cup'),               -- Kimchi\r\n",
                "(24, 15, '1 cup'),               -- Vegetables\r\n",
                "(25, 5, '1 cup'),                -- Olive Oil\r\n",
                "(25, 43, '1 cup'),               -- Fresh Herbs\r\n",
                "(26, 44, '1/2 cup'),             -- Chia Seeds\r\n",
                "(26, 24, '2 cups'),              -- Almond Milk\r\n",
                "(27, 45, '1 cup'),               -- Nuts\r\n",
                "(27, 46, '1 cup'),               -- Dried Fruit\r\n",
                "(28, 47, '4 tomatoes'),          -- Tomatoes\r\n",
                "(28, 48, '1/2 cup'),             -- Basil\r\n",
                "(28, 49, '2 cups'),              -- Broth\r\n",
                "(29, 27, '1 cucumber'),          -- Cucumber\r\n",
                "(29, 28, '2 tomatoes'),          -- Tomato\r\n",
                "(29, 29, '100 g'),               -- Feta Cheese\r\n",
                "(30, 50, '250 g'),               -- Lasagna Noodles\r\n",
                "(30, 31, '500 g'),               -- Cheese\r\n",
                "(30, 12, '250 g'),               -- Ground Beef\r\n",
                "(31, 51, '3 bananas'),           -- Bananas\r\n",
                "(31, 16, '2 cups'),              -- Flour\r\n",
                "(31, 18, '1 cup'),               -- Sugar\r\n",
                "(32, 20, '2 cups'),              -- Berries\r\n",
                "(32, 24, '1 cup'),               -- Yogurt\r\n",
                "(32, 25, '1 cup'),               -- Milk\r\n",
                "(33, 14, '2 cups'),              -- Rice\r\n",
                "(33, 43, '1/2 cup'),             -- Fresh Herbs\r\n",
                "(34, 14, '300 g'),               -- Spaghetti\r\n",
                "(34, 52, '3 cloves'),            -- Garlic\r\n",
                "(34, 5, '3 tbsp'),               -- Olive Oil\r\n",
                "(35, 6, '1 can'),                -- Chickpeas\r\n",
                "(35, 53, '1 tbsp'),              -- Herbs\r\n",
                "(35, 8, '1 tbsp');               -- Spices\r\n",
                "\r\n",
                "INSERT INTO substitutions (ingredientID, substituteIngredientID, ratio) VALUES\r\n",
                "(1, 4, 1.00),   -- Bell Peppers -> Cauliflower\r\n",
                "(2, 29, 1.00),  -- Quinoa -> Almond Flour\r\n",
                "(3, 6, 1.00),   -- Black Beans -> Chickpeas\r\n",
                "(4, 1, 1.00),   -- Cauliflower -> Bell Peppers\r\n",
                "(5, 11, 1.00),  -- Olive Oil -> Tortillas\r\n",
                "(6, 3, 1.00),   -- Chickpeas -> Black Beans\r\n",
                "(7, 8, 1.00),   -- Tomatoes -> Spices\r\n",
                "(8, 7, 1.00),   -- Spices -> Tomatoes\r\n",
                "(9, 12, 1.00),  -- Chicken Breast -> Ground Beef\r\n",
                "(10, 28, 1.00), -- Mixed Greens -> Feta Cheese\r\n",
                "(11, 5, 1.00),  -- Tortillas -> Olive Oil\r\n",
                "(12, 9, 1.00),  -- Ground Beef -> Chicken Breast\r\n",
                "(13, 4, 1.00),  -- Lettuce -> Cauliflower\r\n",
                "(14, 29, 1.00), -- Pasta -> Almond Flour\r\n",
                "(15, 6, 1.00),  -- Mixed Vegetables -> Chickpeas\r\n",
                "(16, 2, 1.00),  -- Flour -> Quinoa\r\n",
                "(17, 18, 1.00), -- Cocoa Powder -> Sugar\r\n",
                "(18, 17, 1.00), -- Sugar -> Cocoa Powder\r\n",
                "(19, 21, 1.00), -- Bananas -> Yogurt\r\n",
                "(20, 19, 1.00), -- Berries -> Bananas\r\n",
                "(21, 19, 1.00), -- Yogurt -> Bananas\r\n",
                "(22, 34, 1.00), -- Salmon -> Fish\r\n",
                "(23, 24, 1.00), -- Herbs -> Eggs\r\n",
                "(24, 23, 1.00), -- Eggs -> Herbs\r\n",
                "(25, 21, 1.00), -- Milk -> Yogurt\r\n",
                "(26, 9, 1.00),  -- Steak -> Chicken Breast\r\n",
                "(27, 28, 1.00), -- Cucumber -> Feta Cheese\r\n",
                "(28, 27, 1.00), -- Feta Cheese -> Cucumber\r\n",
                "(29, 16, 1.00), -- Almond Flour -> Flour\r\n",
                "(30, 9, 1.00),  -- Cheese -> Chicken Breast\r\n",
                "(31, 4, 1.00),  -- Zucchini -> Cauliflower\r\n",
                "(32, 29, 1.00), -- Sushi Rice -> Almond Flour\r\n",
                "(33, 5, 1.00),  -- Nori -> Olive Oil\r\n",
                "(34, 6, 1.00),  -- Fish -> Chickpeas\r\n",
                "(35, 18, 1.00), -- Ramen Noodles -> Sugar\r\n",
                "(36, 36, 1.00), -- Broth -> Broth (self-substitution)\r\n",
                "(37, 38, 1.00), -- Bread -> Cinnamon\r\n",
                "(38, 37, 1.00), -- Cinnamon -> Bread\r\n",
                "(39, 48, 1.00), -- Pork Ribs -> Nuts\r\n",
                "(40, 41, 1.00), -- BBQ Sauce -> Whole Grain Bread\r\n",
                "(41, 40, 1.00), -- Whole Grain Bread -> BBQ Sauce\r\n",
                "(42, 7, 1.00),  -- Avocado -> Tomatoes\r\n",
                "(43, 16, 1.00), -- Rice -> Flour\r\n",
                "(44, 6, 1.00),  -- Kimchi -> Chickpeas\r\n",
                "(45, 22, 1.00), -- Fresh Herbs -> Salmon\r\n",
                "(46, 44, 1.00), -- Chia Seeds -> Kimchi\r\n",
                "(47, 21, 1.00), -- Almond Milk -> Yogurt\r\n",
                "(48, 49, 1.00), -- Nuts -> Dried Fruit\r\n",
                "(49, 48, 1.00), -- Dried Fruit -> Nuts\r\n",
                "(50, 51, 1.00), -- Basil -> Garlic\r\n",
                "(51, 50, 1.00); -- Garlic -> Basil\r\n",
                ""
            ],
            "metadata": {
                "azdata_cell_guid": "775079c5-45f5-497e-9b78-d38b7f59f2c2",
                "language": "sql"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(35 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(35 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(35 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(35 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(35 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(35 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(35 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(95 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(95 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(25 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(107 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(95 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(51 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.288"
                    },
                    "metadata": {}
                }
            ],
            "execution_count": 18
        },
        {
            "cell_type": "code",
            "source": [
                "-- 1. Find the total number of users, grouped by their preferences\r\n",
                "SELECT p.preferences, COUNT(u.userID) AS total_users\r\n",
                "FROM userPreferences p\r\n",
                "JOIN [user] u ON p.userID = u.userID\r\n",
                "GROUP BY p.preferences;\r\n",
                "\r\n",
                "-- 2. Find the average rating for recipes, grouped by their origin\r\n",
                "SELECT r.origin, AVG(rv.rating) AS average_rating\r\n",
                "FROM recipe r\r\n",
                "JOIN review rv ON r.recipeID = rv.recipeID\r\n",
                "GROUP BY r.origin;\r\n",
                "\r\n",
                "-- 3. Find the average calories of recipes, grouped by their tags\r\n",
                "SELECT rt.tags, AVG(r.calories) AS average_calories\r\n",
                "FROM recipeTags rt\r\n",
                "JOIN recipe r ON rt.recipeID = r.recipeID\r\n",
                "GROUP BY rt.tags;\r\n",
                "\r\n",
                "-- 4. Count the total number of reviews for each recipe\r\n",
                "SELECT r.name, \r\n",
                "       (SELECT COUNT(*) FROM review rv WHERE rv.recipeID = r.recipeID) AS total_reviews\r\n",
                "FROM recipe r;\r\n",
                "\r\n",
                "-- 5. Get the comment and rating for the highest-rated review for each recipe\r\n",
                "SELECT rv.recipeID, rv.comment, rv.rating\r\n",
                "FROM review rv\r\n",
                "WHERE rv.rating = (SELECT MAX(rating) \r\n",
                "                   FROM review \r\n",
                "                   WHERE recipeID = rv.recipeID);\r\n",
                "\r\n",
                "-- 6. Find the cuisine type with the highest total rating\r\n",
                "SELECT TOP 1 r.cuisine, SUM(rv.rating) AS total_rating\r\n",
                "FROM recipe r\r\n",
                "JOIN review rv ON r.recipeID = rv.recipeID\r\n",
                "GROUP BY r.cuisine\r\n",
                "ORDER BY total_rating DESC;\r\n",
                "\r\n",
                "-- 7. Identify the most saved recipe, grouped by its tags\r\n",
                "SELECT TOP 1 rt.tags, r.name, COUNT(s.recipeID) AS save_count\r\n",
                "FROM recipeTags rt\r\n",
                "JOIN saved s ON rt.recipeID = s.recipeID\r\n",
                "JOIN recipe r ON rt.recipeID = r.recipeID\r\n",
                "GROUP BY rt.tags, r.name\r\n",
                "ORDER BY save_count DESC;\r\n",
                "\r\n",
                "-- 8. Retrieve all recipes that have at least 5 reviews\r\n",
                "SELECT r.name\r\n",
                "FROM recipe r\r\n",
                "WHERE (SELECT COUNT(*) \r\n",
                "        FROM review rv \r\n",
                "        WHERE rv.recipeID = r.recipeID) >= 5;\r\n",
                "\r\n",
                "-- 9. Count of recipes that each ingredient shows up in, sorted descending\r\n",
                "SELECT i.name AS ingredient_name, COUNT(ri.recipeID) AS recipe_count\r\n",
                "FROM ingredient i\r\n",
                "JOIN recipeIngredients ri ON i.ingredientID = ri.ingredientID\r\n",
                "GROUP BY i.name\r\n",
                "ORDER BY recipe_count DESC;\r\n",
                "\r\n",
                "-- 10. List the top 5 users based on the number of reviews they have written\r\n",
                "SELECT TOP 5 u.username, COUNT(rv.reviewID) AS total_reviews\r\n",
                "FROM [user] u\r\n",
                "JOIN review rv ON u.userID = rv.userID\r\n",
                "GROUP BY u.username\r\n",
                "ORDER BY total_reviews DESC;"
            ],
            "metadata": {
                "azdata_cell_guid": "6befc175-d3fd-4dff-b0de-dd083542e8b1",
                "language": "sql"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(35 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(9 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(35 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(35 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(35 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(1 row affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(1 row affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(0 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(40 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(5 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.359"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 19,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "preferences"
                                    },
                                    {
                                        "name": "total_users"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "preferences": "Asian",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Baking",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Barbecue",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Breakfast",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Brunch",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Casseroles",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Comfort Food",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Dairy-free",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Dessert",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Farm-to-table",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Fermented Foods",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Fresh Herbs",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Gluten-free",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Healthy",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Italian",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Keto",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Low-carb",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Low-sugar",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Mediterranean",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Mexican",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Paleo",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Pasta",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Quick Meals",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Salads",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Savory",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Seafood",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Smoothies",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Snacks",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Soups",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Spicy",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Street Food",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Superfoods",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Vegan",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Vegetarian",
                                    "total_users": "1"
                                },
                                {
                                    "preferences": "Whole30",
                                    "total_users": "1"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>preferences</th><th>total_users</th></tr>",
                            "<tr><td>Asian</td><td>1</td></tr>",
                            "<tr><td>Baking</td><td>1</td></tr>",
                            "<tr><td>Barbecue</td><td>1</td></tr>",
                            "<tr><td>Breakfast</td><td>1</td></tr>",
                            "<tr><td>Brunch</td><td>1</td></tr>",
                            "<tr><td>Casseroles</td><td>1</td></tr>",
                            "<tr><td>Comfort Food</td><td>1</td></tr>",
                            "<tr><td>Dairy-free</td><td>1</td></tr>",
                            "<tr><td>Dessert</td><td>1</td></tr>",
                            "<tr><td>Farm-to-table</td><td>1</td></tr>",
                            "<tr><td>Fermented Foods</td><td>1</td></tr>",
                            "<tr><td>Fresh Herbs</td><td>1</td></tr>",
                            "<tr><td>Gluten-free</td><td>1</td></tr>",
                            "<tr><td>Healthy</td><td>1</td></tr>",
                            "<tr><td>Italian</td><td>1</td></tr>",
                            "<tr><td>Keto</td><td>1</td></tr>",
                            "<tr><td>Low-carb</td><td>1</td></tr>",
                            "<tr><td>Low-sugar</td><td>1</td></tr>",
                            "<tr><td>Mediterranean</td><td>1</td></tr>",
                            "<tr><td>Mexican</td><td>1</td></tr>",
                            "<tr><td>Paleo</td><td>1</td></tr>",
                            "<tr><td>Pasta</td><td>1</td></tr>",
                            "<tr><td>Quick Meals</td><td>1</td></tr>",
                            "<tr><td>Salads</td><td>1</td></tr>",
                            "<tr><td>Savory</td><td>1</td></tr>",
                            "<tr><td>Seafood</td><td>1</td></tr>",
                            "<tr><td>Smoothies</td><td>1</td></tr>",
                            "<tr><td>Snacks</td><td>1</td></tr>",
                            "<tr><td>Soups</td><td>1</td></tr>",
                            "<tr><td>Spicy</td><td>1</td></tr>",
                            "<tr><td>Street Food</td><td>1</td></tr>",
                            "<tr><td>Superfoods</td><td>1</td></tr>",
                            "<tr><td>Vegan</td><td>1</td></tr>",
                            "<tr><td>Vegetarian</td><td>1</td></tr>",
                            "<tr><td>Whole30</td><td>1</td></tr>",
                            "</table>"
                        ]
                    }
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 19,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "origin"
                                    },
                                    {
                                        "name": "average_rating"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "origin": "Greece",
                                    "average_rating": "4"
                                },
                                {
                                    "origin": "India",
                                    "average_rating": "4"
                                },
                                {
                                    "origin": "Italy",
                                    "average_rating": "4"
                                },
                                {
                                    "origin": "Japan",
                                    "average_rating": "4"
                                },
                                {
                                    "origin": "Korea",
                                    "average_rating": "4"
                                },
                                {
                                    "origin": "Mexico",
                                    "average_rating": "3"
                                },
                                {
                                    "origin": "Middle East",
                                    "average_rating": "4"
                                },
                                {
                                    "origin": "Norway",
                                    "average_rating": "5"
                                },
                                {
                                    "origin": "USA",
                                    "average_rating": "4"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>origin</th><th>average_rating</th></tr>",
                            "<tr><td>Greece</td><td>4</td></tr>",
                            "<tr><td>India</td><td>4</td></tr>",
                            "<tr><td>Italy</td><td>4</td></tr>",
                            "<tr><td>Japan</td><td>4</td></tr>",
                            "<tr><td>Korea</td><td>4</td></tr>",
                            "<tr><td>Mexico</td><td>3</td></tr>",
                            "<tr><td>Middle East</td><td>4</td></tr>",
                            "<tr><td>Norway</td><td>5</td></tr>",
                            "<tr><td>USA</td><td>4</td></tr>",
                            "</table>"
                        ]
                    }
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 19,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "tags"
                                    },
                                    {
                                        "name": "average_calories"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "tags": "Asian",
                                    "average_calories": "350.000000"
                                },
                                {
                                    "tags": "Baking",
                                    "average_calories": "250.000000"
                                },
                                {
                                    "tags": "Barbecue",
                                    "average_calories": "600.000000"
                                },
                                {
                                    "tags": "Breakfast",
                                    "average_calories": "300.000000"
                                },
                                {
                                    "tags": "Brunch",
                                    "average_calories": "350.000000"
                                },
                                {
                                    "tags": "Casseroles",
                                    "average_calories": "600.000000"
                                },
                                {
                                    "tags": "Comfort Food",
                                    "average_calories": "500.000000"
                                },
                                {
                                    "tags": "Dairy-free",
                                    "average_calories": "180.000000"
                                },
                                {
                                    "tags": "Dessert",
                                    "average_calories": "400.000000"
                                },
                                {
                                    "tags": "Farm-to-table",
                                    "average_calories": "100.000000"
                                },
                                {
                                    "tags": "Fermented Foods",
                                    "average_calories": "250.000000"
                                },
                                {
                                    "tags": "Fresh Herbs",
                                    "average_calories": "120.000000"
                                },
                                {
                                    "tags": "Gluten-free",
                                    "average_calories": "200.000000"
                                },
                                {
                                    "tags": "Healthy",
                                    "average_calories": "250.000000"
                                },
                                {
                                    "tags": "Italian",
                                    "average_calories": "400.000000"
                                },
                                {
                                    "tags": "Keto",
                                    "average_calories": "50.000000"
                                },
                                {
                                    "tags": "Low-carb",
                                    "average_calories": "30.000000"
                                },
                                {
                                    "tags": "Low-sugar",
                                    "average_calories": "300.000000"
                                },
                                {
                                    "tags": "Mediterranean",
                                    "average_calories": "150.000000"
                                },
                                {
                                    "tags": "Mexican",
                                    "average_calories": "450.000000"
                                },
                                {
                                    "tags": "Paleo",
                                    "average_calories": "400.000000"
                                },
                                {
                                    "tags": "Pasta",
                                    "average_calories": "350.000000"
                                },
                                {
                                    "tags": "Quick Meals",
                                    "average_calories": "250.000000"
                                },
                                {
                                    "tags": "Salads",
                                    "average_calories": "150.000000"
                                },
                                {
                                    "tags": "Savory",
                                    "average_calories": "120.000000"
                                },
                                {
                                    "tags": "Seafood",
                                    "average_calories": "350.000000"
                                },
                                {
                                    "tags": "Smoothies",
                                    "average_calories": "150.000000"
                                },
                                {
                                    "tags": "Snacks",
                                    "average_calories": "300.000000"
                                },
                                {
                                    "tags": "Soups",
                                    "average_calories": "100.000000"
                                },
                                {
                                    "tags": "Spicy",
                                    "average_calories": "300.000000"
                                },
                                {
                                    "tags": "Street Food",
                                    "average_calories": "250.000000"
                                },
                                {
                                    "tags": "Superfoods",
                                    "average_calories": "150.000000"
                                },
                                {
                                    "tags": "Vegan",
                                    "average_calories": "300.000000"
                                },
                                {
                                    "tags": "Vegetarian",
                                    "average_calories": "180.000000"
                                },
                                {
                                    "tags": "Whole30",
                                    "average_calories": "300.000000"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>tags</th><th>average_calories</th></tr>",
                            "<tr><td>Asian</td><td>350.000000</td></tr>",
                            "<tr><td>Baking</td><td>250.000000</td></tr>",
                            "<tr><td>Barbecue</td><td>600.000000</td></tr>",
                            "<tr><td>Breakfast</td><td>300.000000</td></tr>",
                            "<tr><td>Brunch</td><td>350.000000</td></tr>",
                            "<tr><td>Casseroles</td><td>600.000000</td></tr>",
                            "<tr><td>Comfort Food</td><td>500.000000</td></tr>",
                            "<tr><td>Dairy-free</td><td>180.000000</td></tr>",
                            "<tr><td>Dessert</td><td>400.000000</td></tr>",
                            "<tr><td>Farm-to-table</td><td>100.000000</td></tr>",
                            "<tr><td>Fermented Foods</td><td>250.000000</td></tr>",
                            "<tr><td>Fresh Herbs</td><td>120.000000</td></tr>",
                            "<tr><td>Gluten-free</td><td>200.000000</td></tr>",
                            "<tr><td>Healthy</td><td>250.000000</td></tr>",
                            "<tr><td>Italian</td><td>400.000000</td></tr>",
                            "<tr><td>Keto</td><td>50.000000</td></tr>",
                            "<tr><td>Low-carb</td><td>30.000000</td></tr>",
                            "<tr><td>Low-sugar</td><td>300.000000</td></tr>",
                            "<tr><td>Mediterranean</td><td>150.000000</td></tr>",
                            "<tr><td>Mexican</td><td>450.000000</td></tr>",
                            "<tr><td>Paleo</td><td>400.000000</td></tr>",
                            "<tr><td>Pasta</td><td>350.000000</td></tr>",
                            "<tr><td>Quick Meals</td><td>250.000000</td></tr>",
                            "<tr><td>Salads</td><td>150.000000</td></tr>",
                            "<tr><td>Savory</td><td>120.000000</td></tr>",
                            "<tr><td>Seafood</td><td>350.000000</td></tr>",
                            "<tr><td>Smoothies</td><td>150.000000</td></tr>",
                            "<tr><td>Snacks</td><td>300.000000</td></tr>",
                            "<tr><td>Soups</td><td>100.000000</td></tr>",
                            "<tr><td>Spicy</td><td>300.000000</td></tr>",
                            "<tr><td>Street Food</td><td>250.000000</td></tr>",
                            "<tr><td>Superfoods</td><td>150.000000</td></tr>",
                            "<tr><td>Vegan</td><td>300.000000</td></tr>",
                            "<tr><td>Vegetarian</td><td>180.000000</td></tr>",
                            "<tr><td>Whole30</td><td>300.000000</td></tr>",
                            "</table>"
                        ]
                    }
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 19,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "name"
                                    },
                                    {
                                        "name": "total_reviews"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "name": "Stuffed Peppers",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Cauliflower Rice",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Chickpea Curry",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Grilled Chicken Salad",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Tacos",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Pasta Primavera",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Chocolate Cake",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Smoothie Bowl",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Grilled Salmon",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Pancakes",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Grilled Steak",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Greek Salad",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Almond Flour Cookies",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Cauliflower Pizza Crust",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Zucchini Chips",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Mac and Cheese",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Sushi Rolls",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Chili Ramen",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "French Toast",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "BBQ Ribs",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Farmers Market Salad",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Zucchini Noodles with Meat Sauce",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Avocado Toast",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Kimchi Fried Rice",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Herb-Infused Olive Oil",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Chia Seed Pudding",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Trail Mix",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Tomato Basil Soup",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Greek Salad",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Lasagna",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Banana Bread",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Berry Smoothie",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Herbed Rice",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Spaghetti Aglio e Olio",
                                    "total_reviews": "1"
                                },
                                {
                                    "name": "Falafel",
                                    "total_reviews": "1"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>name</th><th>total_reviews</th></tr>",
                            "<tr><td>Stuffed Peppers</td><td>1</td></tr>",
                            "<tr><td>Cauliflower Rice</td><td>1</td></tr>",
                            "<tr><td>Chickpea Curry</td><td>1</td></tr>",
                            "<tr><td>Grilled Chicken Salad</td><td>1</td></tr>",
                            "<tr><td>Tacos</td><td>1</td></tr>",
                            "<tr><td>Pasta Primavera</td><td>1</td></tr>",
                            "<tr><td>Chocolate Cake</td><td>1</td></tr>",
                            "<tr><td>Smoothie Bowl</td><td>1</td></tr>",
                            "<tr><td>Grilled Salmon</td><td>1</td></tr>",
                            "<tr><td>Pancakes</td><td>1</td></tr>",
                            "<tr><td>Grilled Steak</td><td>1</td></tr>",
                            "<tr><td>Greek Salad</td><td>1</td></tr>",
                            "<tr><td>Almond Flour Cookies</td><td>1</td></tr>",
                            "<tr><td>Cauliflower Pizza Crust</td><td>1</td></tr>",
                            "<tr><td>Zucchini Chips</td><td>1</td></tr>",
                            "<tr><td>Mac and Cheese</td><td>1</td></tr>",
                            "<tr><td>Sushi Rolls</td><td>1</td></tr>",
                            "<tr><td>Chili Ramen</td><td>1</td></tr>",
                            "<tr><td>French Toast</td><td>1</td></tr>",
                            "<tr><td>BBQ Ribs</td><td>1</td></tr>",
                            "<tr><td>Farmers Market Salad</td><td>1</td></tr>",
                            "<tr><td>Zucchini Noodles with Meat Sauce</td><td>1</td></tr>",
                            "<tr><td>Avocado Toast</td><td>1</td></tr>",
                            "<tr><td>Kimchi Fried Rice</td><td>1</td></tr>",
                            "<tr><td>Herb-Infused Olive Oil</td><td>1</td></tr>",
                            "<tr><td>Chia Seed Pudding</td><td>1</td></tr>",
                            "<tr><td>Trail Mix</td><td>1</td></tr>",
                            "<tr><td>Tomato Basil Soup</td><td>1</td></tr>",
                            "<tr><td>Greek Salad</td><td>1</td></tr>",
                            "<tr><td>Lasagna</td><td>1</td></tr>",
                            "<tr><td>Banana Bread</td><td>1</td></tr>",
                            "<tr><td>Berry Smoothie</td><td>1</td></tr>",
                            "<tr><td>Herbed Rice</td><td>1</td></tr>",
                            "<tr><td>Spaghetti Aglio e Olio</td><td>1</td></tr>",
                            "<tr><td>Falafel</td><td>1</td></tr>",
                            "</table>"
                        ]
                    }
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 19,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "recipeID"
                                    },
                                    {
                                        "name": "comment"
                                    },
                                    {
                                        "name": "rating"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "recipeID": "35",
                                    "comment": "Crispy and flavorful falafel.",
                                    "rating": "4"
                                },
                                {
                                    "recipeID": "34",
                                    "comment": "A delightful pasta dish!",
                                    "rating": "5"
                                },
                                {
                                    "recipeID": "33",
                                    "comment": "Savory and aromatic rice.",
                                    "rating": "4"
                                },
                                {
                                    "recipeID": "32",
                                    "comment": "Berry delicious!",
                                    "rating": "5"
                                },
                                {
                                    "recipeID": "31",
                                    "comment": "Moist and flavorful bread.",
                                    "rating": "4"
                                },
                                {
                                    "recipeID": "30",
                                    "comment": "A family favorite!",
                                    "rating": "5"
                                },
                                {
                                    "recipeID": "29",
                                    "comment": "Classic and very refreshing!",
                                    "rating": "5"
                                },
                                {
                                    "recipeID": "28",
                                    "comment": "Comforting and delicious soup.",
                                    "rating": "4"
                                },
                                {
                                    "recipeID": "27",
                                    "comment": "Great snack for any time!",
                                    "rating": "5"
                                },
                                {
                                    "recipeID": "26",
                                    "comment": "Nutritious and tasty pudding.",
                                    "rating": "4"
                                },
                                {
                                    "recipeID": "25",
                                    "comment": "Perfect for enhancing flavors!",
                                    "rating": "5"
                                },
                                {
                                    "recipeID": "24",
                                    "comment": "A fun and flavorful dish!",
                                    "rating": "4"
                                },
                                {
                                    "recipeID": "23",
                                    "comment": "Simple yet delicious!",
                                    "rating": "5"
                                },
                                {
                                    "recipeID": "22",
                                    "comment": "Creative and healthy dish.",
                                    "rating": "4"
                                },
                                {
                                    "recipeID": "21",
                                    "comment": "Fresh and light salad!",
                                    "rating": "5"
                                },
                                {
                                    "recipeID": "20",
                                    "comment": "Great flavor, but very rich.",
                                    "rating": "4"
                                },
                                {
                                    "recipeID": "19",
                                    "comment": "A perfect brunch dish!",
                                    "rating": "5"
                                },
                                {
                                    "recipeID": "18",
                                    "comment": "Spicy and satisfying ramen.",
                                    "rating": "4"
                                },
                                {
                                    "recipeID": "17",
                                    "comment": "Amazing sushi rolls, very authentic!",
                                    "rating": "5"
                                },
                                {
                                    "recipeID": "16",
                                    "comment": "Comfort food at its best!",
                                    "rating": "4"
                                },
                                {
                                    "recipeID": "15",
                                    "comment": "Crispy and tasty chips!",
                                    "rating": "5"
                                },
                                {
                                    "recipeID": "14",
                                    "comment": "Interesting take on pizza crust.",
                                    "rating": "3"
                                },
                                {
                                    "recipeID": "13",
                                    "comment": "A fantastic gluten-free treat!",
                                    "rating": "5"
                                },
                                {
                                    "recipeID": "12",
                                    "comment": "Fresh and flavorful Greek salad.",
                                    "rating": "4"
                                },
                                {
                                    "recipeID": "11",
                                    "comment": "Perfectly cooked steak every time.",
                                    "rating": "5"
                                },
                                {
                                    "recipeID": "10",
                                    "comment": "Fluffy and delicious pancakes.",
                                    "rating": "4"
                                },
                                {
                                    "recipeID": "9",
                                    "comment": "Absolutely fantastic salmon!",
                                    "rating": "5"
                                },
                                {
                                    "recipeID": "8",
                                    "comment": "Quick and refreshing breakfast option.",
                                    "rating": "4"
                                },
                                {
                                    "recipeID": "7",
                                    "comment": "Decadent and rich. Perfect dessert!",
                                    "rating": "5"
                                },
                                {
                                    "recipeID": "6",
                                    "comment": "Love the fresh veggies in this!",
                                    "rating": "4"
                                },
                                {
                                    "recipeID": "5",
                                    "comment": "Good, but a bit too salty for my taste.",
                                    "rating": "3"
                                },
                                {
                                    "recipeID": "4",
                                    "comment": "A healthy and filling salad.",
                                    "rating": "4"
                                },
                                {
                                    "recipeID": "3",
                                    "comment": "Best curry I’ve ever made!",
                                    "rating": "5"
                                },
                                {
                                    "recipeID": "2",
                                    "comment": "Great low-carb option.",
                                    "rating": "4"
                                },
                                {
                                    "recipeID": "1",
                                    "comment": "Delicious and easy to make!",
                                    "rating": "5"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>recipeID</th><th>comment</th><th>rating</th></tr>",
                            "<tr><td>35</td><td>Crispy and flavorful falafel.</td><td>4</td></tr>",
                            "<tr><td>34</td><td>A delightful pasta dish!</td><td>5</td></tr>",
                            "<tr><td>33</td><td>Savory and aromatic rice.</td><td>4</td></tr>",
                            "<tr><td>32</td><td>Berry delicious!</td><td>5</td></tr>",
                            "<tr><td>31</td><td>Moist and flavorful bread.</td><td>4</td></tr>",
                            "<tr><td>30</td><td>A family favorite!</td><td>5</td></tr>",
                            "<tr><td>29</td><td>Classic and very refreshing!</td><td>5</td></tr>",
                            "<tr><td>28</td><td>Comforting and delicious soup.</td><td>4</td></tr>",
                            "<tr><td>27</td><td>Great snack for any time!</td><td>5</td></tr>",
                            "<tr><td>26</td><td>Nutritious and tasty pudding.</td><td>4</td></tr>",
                            "<tr><td>25</td><td>Perfect for enhancing flavors!</td><td>5</td></tr>",
                            "<tr><td>24</td><td>A fun and flavorful dish!</td><td>4</td></tr>",
                            "<tr><td>23</td><td>Simple yet delicious!</td><td>5</td></tr>",
                            "<tr><td>22</td><td>Creative and healthy dish.</td><td>4</td></tr>",
                            "<tr><td>21</td><td>Fresh and light salad!</td><td>5</td></tr>",
                            "<tr><td>20</td><td>Great flavor, but very rich.</td><td>4</td></tr>",
                            "<tr><td>19</td><td>A perfect brunch dish!</td><td>5</td></tr>",
                            "<tr><td>18</td><td>Spicy and satisfying ramen.</td><td>4</td></tr>",
                            "<tr><td>17</td><td>Amazing sushi rolls, very authentic!</td><td>5</td></tr>",
                            "<tr><td>16</td><td>Comfort food at its best!</td><td>4</td></tr>",
                            "<tr><td>15</td><td>Crispy and tasty chips!</td><td>5</td></tr>",
                            "<tr><td>14</td><td>Interesting take on pizza crust.</td><td>3</td></tr>",
                            "<tr><td>13</td><td>A fantastic gluten-free treat!</td><td>5</td></tr>",
                            "<tr><td>12</td><td>Fresh and flavorful Greek salad.</td><td>4</td></tr>",
                            "<tr><td>11</td><td>Perfectly cooked steak every time.</td><td>5</td></tr>",
                            "<tr><td>10</td><td>Fluffy and delicious pancakes.</td><td>4</td></tr>",
                            "<tr><td>9</td><td>Absolutely fantastic salmon!</td><td>5</td></tr>",
                            "<tr><td>8</td><td>Quick and refreshing breakfast option.</td><td>4</td></tr>",
                            "<tr><td>7</td><td>Decadent and rich. Perfect dessert!</td><td>5</td></tr>",
                            "<tr><td>6</td><td>Love the fresh veggies in this!</td><td>4</td></tr>",
                            "<tr><td>5</td><td>Good, but a bit too salty for my taste.</td><td>3</td></tr>",
                            "<tr><td>4</td><td>A healthy and filling salad.</td><td>4</td></tr>",
                            "<tr><td>3</td><td>Best curry I’ve ever made!</td><td>5</td></tr>",
                            "<tr><td>2</td><td>Great low-carb option.</td><td>4</td></tr>",
                            "<tr><td>1</td><td>Delicious and easy to make!</td><td>5</td></tr>",
                            "</table>"
                        ]
                    }
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 19,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "cuisine"
                                    },
                                    {
                                        "name": "total_rating"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "cuisine": "Asian",
                                    "total_rating": "5"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>cuisine</th><th>total_rating</th></tr>",
                            "<tr><td>Asian</td><td>5</td></tr>",
                            "</table>"
                        ]
                    }
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 19,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "tags"
                                    },
                                    {
                                        "name": "name"
                                    },
                                    {
                                        "name": "save_count"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "tags": "Barbecue",
                                    "name": "BBQ Ribs",
                                    "save_count": "1"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>tags</th><th>name</th><th>save_count</th></tr>",
                            "<tr><td>Barbecue</td><td>BBQ Ribs</td><td>1</td></tr>",
                            "</table>"
                        ]
                    }
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 19,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "name"
                                    }
                                ]
                            },
                            "data": []
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>name</th></tr>",
                            "</table>"
                        ]
                    }
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 19,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "ingredient_name"
                                    },
                                    {
                                        "name": "recipe_count"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "ingredient_name": "Olive Oil",
                                    "recipe_count": "9"
                                },
                                {
                                    "ingredient_name": "Salmon",
                                    "recipe_count": "7"
                                },
                                {
                                    "ingredient_name": "Spices",
                                    "recipe_count": "7"
                                },
                                {
                                    "ingredient_name": "Lettuce",
                                    "recipe_count": "5"
                                },
                                {
                                    "ingredient_name": "Eggs",
                                    "recipe_count": "5"
                                },
                                {
                                    "ingredient_name": "Flour",
                                    "recipe_count": "4"
                                },
                                {
                                    "ingredient_name": "Cheese",
                                    "recipe_count": "4"
                                },
                                {
                                    "ingredient_name": "Cucumber",
                                    "recipe_count": "3"
                                },
                                {
                                    "ingredient_name": "Milk",
                                    "recipe_count": "3"
                                },
                                {
                                    "ingredient_name": "Cauliflower",
                                    "recipe_count": "3"
                                },
                                {
                                    "ingredient_name": "Pasta",
                                    "recipe_count": "3"
                                },
                                {
                                    "ingredient_name": "Mixed Vegetables",
                                    "recipe_count": "3"
                                },
                                {
                                    "ingredient_name": "Sugar",
                                    "recipe_count": "3"
                                },
                                {
                                    "ingredient_name": "Tortillas",
                                    "recipe_count": "3"
                                },
                                {
                                    "ingredient_name": "Tomato",
                                    "recipe_count": "2"
                                },
                                {
                                    "ingredient_name": "Steak",
                                    "recipe_count": "2"
                                },
                                {
                                    "ingredient_name": "Herbs",
                                    "recipe_count": "2"
                                },
                                {
                                    "ingredient_name": "Mixed Greens",
                                    "recipe_count": "2"
                                },
                                {
                                    "ingredient_name": "Egg",
                                    "recipe_count": "2"
                                },
                                {
                                    "ingredient_name": "Chickpeas",
                                    "recipe_count": "2"
                                },
                                {
                                    "ingredient_name": "Berries",
                                    "recipe_count": "2"
                                },
                                {
                                    "ingredient_name": "Black Beans",
                                    "recipe_count": "1"
                                },
                                {
                                    "ingredient_name": "Bread",
                                    "recipe_count": "1"
                                },
                                {
                                    "ingredient_name": "Broth",
                                    "recipe_count": "1"
                                },
                                {
                                    "ingredient_name": "Chicken Breast",
                                    "recipe_count": "1"
                                },
                                {
                                    "ingredient_name": "Almond Flour",
                                    "recipe_count": "1"
                                },
                                {
                                    "ingredient_name": "Bananas",
                                    "recipe_count": "1"
                                },
                                {
                                    "ingredient_name": "Bell Peppers",
                                    "recipe_count": "1"
                                },
                                {
                                    "ingredient_name": "Cinnamon",
                                    "recipe_count": "1"
                                },
                                {
                                    "ingredient_name": "Cocoa Powder",
                                    "recipe_count": "1"
                                },
                                {
                                    "ingredient_name": "Ground Beef",
                                    "recipe_count": "1"
                                },
                                {
                                    "ingredient_name": "Feta Cheese",
                                    "recipe_count": "1"
                                },
                                {
                                    "ingredient_name": "Fish",
                                    "recipe_count": "1"
                                },
                                {
                                    "ingredient_name": "Quinoa",
                                    "recipe_count": "1"
                                },
                                {
                                    "ingredient_name": "Ramen Noodles",
                                    "recipe_count": "1"
                                },
                                {
                                    "ingredient_name": "Nori",
                                    "recipe_count": "1"
                                },
                                {
                                    "ingredient_name": "Tomatoes",
                                    "recipe_count": "1"
                                },
                                {
                                    "ingredient_name": "Sushi Rice",
                                    "recipe_count": "1"
                                },
                                {
                                    "ingredient_name": "Yogurt",
                                    "recipe_count": "1"
                                },
                                {
                                    "ingredient_name": "Zucchini",
                                    "recipe_count": "1"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>ingredient_name</th><th>recipe_count</th></tr>",
                            "<tr><td>Olive Oil</td><td>9</td></tr>",
                            "<tr><td>Salmon</td><td>7</td></tr>",
                            "<tr><td>Spices</td><td>7</td></tr>",
                            "<tr><td>Lettuce</td><td>5</td></tr>",
                            "<tr><td>Eggs</td><td>5</td></tr>",
                            "<tr><td>Flour</td><td>4</td></tr>",
                            "<tr><td>Cheese</td><td>4</td></tr>",
                            "<tr><td>Cucumber</td><td>3</td></tr>",
                            "<tr><td>Milk</td><td>3</td></tr>",
                            "<tr><td>Cauliflower</td><td>3</td></tr>",
                            "<tr><td>Pasta</td><td>3</td></tr>",
                            "<tr><td>Mixed Vegetables</td><td>3</td></tr>",
                            "<tr><td>Sugar</td><td>3</td></tr>",
                            "<tr><td>Tortillas</td><td>3</td></tr>",
                            "<tr><td>Tomato</td><td>2</td></tr>",
                            "<tr><td>Steak</td><td>2</td></tr>",
                            "<tr><td>Herbs</td><td>2</td></tr>",
                            "<tr><td>Mixed Greens</td><td>2</td></tr>",
                            "<tr><td>Egg</td><td>2</td></tr>",
                            "<tr><td>Chickpeas</td><td>2</td></tr>",
                            "<tr><td>Berries</td><td>2</td></tr>",
                            "<tr><td>Black Beans</td><td>1</td></tr>",
                            "<tr><td>Bread</td><td>1</td></tr>",
                            "<tr><td>Broth</td><td>1</td></tr>",
                            "<tr><td>Chicken Breast</td><td>1</td></tr>",
                            "<tr><td>Almond Flour</td><td>1</td></tr>",
                            "<tr><td>Bananas</td><td>1</td></tr>",
                            "<tr><td>Bell Peppers</td><td>1</td></tr>",
                            "<tr><td>Cinnamon</td><td>1</td></tr>",
                            "<tr><td>Cocoa Powder</td><td>1</td></tr>",
                            "<tr><td>Ground Beef</td><td>1</td></tr>",
                            "<tr><td>Feta Cheese</td><td>1</td></tr>",
                            "<tr><td>Fish</td><td>1</td></tr>",
                            "<tr><td>Quinoa</td><td>1</td></tr>",
                            "<tr><td>Ramen Noodles</td><td>1</td></tr>",
                            "<tr><td>Nori</td><td>1</td></tr>",
                            "<tr><td>Tomatoes</td><td>1</td></tr>",
                            "<tr><td>Sushi Rice</td><td>1</td></tr>",
                            "<tr><td>Yogurt</td><td>1</td></tr>",
                            "<tr><td>Zucchini</td><td>1</td></tr>",
                            "</table>"
                        ]
                    }
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 19,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "username"
                                    },
                                    {
                                        "name": "total_reviews"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "username": "charlieb",
                                    "total_reviews": "1"
                                },
                                {
                                    "username": "camerond",
                                    "total_reviews": "1"
                                },
                                {
                                    "username": "bobsmith",
                                    "total_reviews": "1"
                                },
                                {
                                    "username": "bellas",
                                    "total_reviews": "1"
                                },
                                {
                                    "username": "alicej",
                                    "total_reviews": "1"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>username</th><th>total_reviews</th></tr>",
                            "<tr><td>charlieb</td><td>1</td></tr>",
                            "<tr><td>camerond</td><td>1</td></tr>",
                            "<tr><td>bobsmith</td><td>1</td></tr>",
                            "<tr><td>bellas</td><td>1</td></tr>",
                            "<tr><td>alicej</td><td>1</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 19
        }
    ]
}