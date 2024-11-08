-- Carlie Stewart - ayu6cp
-- Olivia Seto - quf7mw
-- Kelly Gu - hnj4jk
-- Alisha Qian - sta2fu

-- P4: Advanced SQL

-- Create 3 Stored Procedures
-- 1. CreateUser Procedure
CREATE PROCEDURE CreateUser
   @name VARCHAR(100),
   @username VARCHAR(50),
   @password VARCHAR(255)
AS
BEGIN
   -- The CreateUser procedure adds a new user to the [user] table
   -- Purpose: Adds a new user with the provided details
   -- Usage: Used to register a new user in the system
   INSERT INTO [user] (name, username, password)
   VALUES (@name, @username, @password);
END;
GO

-- 2. CreateRecipe Procedure
CREATE PROCEDURE CreateRecipe
   @userID INT,
   @name VARCHAR(255),
   @instructions VARCHAR(MAX),
   @protein DECIMAL(5,2),
   @fats DECIMAL(5,2),
   @carbs DECIMAL(5,2),
   @calories DECIMAL(6,2),
   @origin VARCHAR(100),
   @cuisine VARCHAR(100)
AS
BEGIN
   -- The CreateRecipe procedure adds a new recipe to the recipe table
   -- Purpose: Adds a new recipe with nutritional information
   -- Usage: Used when a user adds a new recipe to the system
   INSERT INTO recipe (userID, name, instructions, protein, fats, carbs, calories, origin, cuisine)
   VALUES (@userID, @name, @instructions, @protein, @fats, @carbs, @calories, @origin, @cuisine);
END;
GO

-- 3. WriteReview Procedure
CREATE PROCEDURE WriteReview
   @recipeID INT,
   @userID INT,
   @rating INT,
   @date DATE,
   @public BIT,
   @comment VARCHAR(MAX)
AS
BEGIN
   -- The WriteReview procedure allows a user to add a review for a recipe
   -- Purpose: Adds a review with rating, comment, and visibility
   -- Usage: Used when a user submits feedback on a recipe
   INSERT INTO review (recipeID, userID, rating, [date], [public], comment)
   VALUES (@recipeID, @userID, @rating, @date, @public, @comment);
END;
GO

-- Create 3 Functions
-- 1. CalculateTotalNutrients Function
CREATE FUNCTION dbo.CalculateTotalNutrients
(
   @recipeID INT
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
   -- This function returns the total macronutrient content (sum of protein, fats, carbs) for a given recipe
   -- Purpose: To calculate the total nutrients for a recipe
   -- Usage: Can be used in reports or UI to display overall nutritional content of a recipe
   DECLARE @totalNutrients DECIMAL(10, 2);
   SELECT @totalNutrients = (protein + fats + carbs)
   FROM recipe
   WHERE recipeID = @recipeID;
  
   RETURN COALESCE(@totalNutrients, 0); -- If no data, return 0
END;
GO

-- 2. GetUserSavedRecipesWithTag Function
CREATE FUNCTION dbo.GetUserSavedRecipesWithTag
(
   @userID INT,
   @tag VARCHAR(255)
)
RETURNS TABLE
AS
RETURN
(
   -- This function retrieves a list of recipes saved by a user with a specific tag
   -- Purpose: Filters saved recipes by a user for a given tag
   -- Usage: Useful for users who want to find saved recipes that match specific preferences or tags (e.g., vegetarian)
   SELECT r.recipeID, r.name AS recipe_name
   FROM saved s
   JOIN recipe r ON s.recipeID = r.recipeID
   JOIN recipeTags rt ON r.recipeID = rt.recipeID
   WHERE s.userID = @userID AND rt.tags = @tag
);
GO

-- 3. GetIngredientSubstitute Function
CREATE FUNCTION dbo.GetIngredientSubstitute
(
   @ingredientID INT
)
RETURNS TABLE
AS
RETURN
(
   -- This function checks if an ingredient has any substitutions listed in the substitutions table
   -- Purpose: Helps users find available substitutes for ingredients in recipes
   -- Usage: Can be used when displaying recipe ingredients to suggest substitutes
   SELECT i.name AS substitute_name, s.ratio
   FROM substitutions s
   JOIN ingredient i ON s.substituteIngredientID = i.ingredientID
   WHERE s.ingredientID = @ingredientID
);
GO

-- Create 3 Views
-- 1. UserRecipeSummary View
CREATE VIEW UserRecipeSummary AS
SELECT
   u.userID AS user_id, -- Aliasing userID from the user table
   u.name AS user_name,
   r.recipeID,
   r.name AS recipe_name,
   r.instructions,
   r.protein,
   r.fats,
   r.carbs,
   r.calories,
   r.origin,
   r.cuisine
FROM [user] u
JOIN recipe r ON u.userID = r.userID;
GO

-- 2. RecipeReviews View
CREATE VIEW RecipeReviews AS
SELECT
   r.recipeID,
   r.name AS recipe_name,
   AVG(rv.rating) AS average_rating,
   COUNT(rv.reviewID) AS total_reviews
FROM recipe r
LEFT JOIN review rv ON r.recipeID = rv.recipeID
GROUP BY r.recipeID, r.name;
GO

-- 3. UserSavedRecipes View
CREATE VIEW UserSavedRecipes AS
SELECT
   u.userID,
   u.name AS user_name,
   r.recipeID,
   r.name AS recipe_name,
   s.tried
FROM [user] u
JOIN saved s ON u.userID = s.userID
JOIN recipe r ON s.recipeID = r.recipeID;
GO

-- Create 1 Trigger
-- UpdatePlanIngredientsAfterPlanUpdate Trigger
CREATE TRIGGER UpdatePlanIngredientsAfterPlanUpdate
ON [plan]
AFTER UPDATE
AS
BEGIN
   -- Update existing plan ingredients with new amounts from recipeIngredients
   UPDATE pi
   SET pi.amountNeeded = ri.recipeAmount
   FROM planIngredients pi
   JOIN recipeIngredients ri
       ON pi.ingredientID = ri.ingredientID
   JOIN inserted i
       ON i.planID = pi.planID  -- Referencing the updated planID from the inserted table
   WHERE ri.recipeID = i.recipeID; -- Matching the updated recipeID

   -- Insert new ingredients that are part of the recipe but not in the current planIngredients
   INSERT INTO planIngredients (planID, ingredientID, amountNeeded)
   SELECT i.planID, ri.ingredientID, ri.recipeAmount
   FROM inserted i
   JOIN recipeIngredients ri ON ri.recipeID = i.recipeID
   WHERE ri.ingredientID NOT IN
       (SELECT ingredientID FROM planIngredients WHERE planID = i.planID);


   -- Delete ingredients that are no longer in the updated plan
   DELETE FROM planIngredients
   WHERE planID IN (SELECT planID FROM inserted)
     AND ingredientID NOT IN
       (SELECT ingredientID FROM recipeIngredients WHERE recipeID IN (SELECT recipeID FROM inserted));
END;
GO

-- Implement 1 Column Encryption
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Cooking123!';
GO

CREATE CERTIFICATE UserCert
WITH SUBJECT = 'Certificate for User Password Encryption';
GO

CREATE SYMMETRIC KEY UserPasswordKey
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE UserCert;
GO

ALTER TABLE [user]
ADD EncryptedPassword VARBINARY(255);
GO

-- Create 3 Non-Clustered Indexes
CREATE NONCLUSTERED INDEX idx_username ON [user] (username);
GO

CREATE NONCLUSTERED INDEX idx_recipe_user ON review (recipeID, userID);
GO

CREATE NONCLUSTERED INDEX idx_cuisine ON recipe (cuisine);
GO
