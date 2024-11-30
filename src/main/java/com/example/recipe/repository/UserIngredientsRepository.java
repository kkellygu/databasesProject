package com.example.recipe.repository;

import com.example.recipe.model.UserIngredients;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

public interface UserIngredientsRepository extends JpaRepository<UserIngredients, Long> {
    List<UserIngredients> findByUser_UserID(int userID);
    Optional<UserIngredients> findByUser_UserIDAndIngredient_IngredientID(int userID, int ingredientID);
    void deleteByUser_UserIDAndIngredient_IngredientID(int userID, int ingredientID);
}
