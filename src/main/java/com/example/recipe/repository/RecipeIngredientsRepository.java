package com.example.recipe.repository;

import com.example.recipe.model.RecipeIngredients;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RecipeIngredientsRepository extends JpaRepository<RecipeIngredients, Long> {
}
