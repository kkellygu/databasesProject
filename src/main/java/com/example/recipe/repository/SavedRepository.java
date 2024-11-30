package com.example.recipe.repository;

import com.example.recipe.model.Saved;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

public interface SavedRepository extends JpaRepository<Saved, Long> {
    List<Saved> findByUser_UserID(int userID);
    Optional<Saved> findByUser_UserIDAndRecipe_RecipeID(int userID, int recipeID);
    void deleteByUser_UserIDAndRecipe_RecipeID(int userID, int recipeID);
}
