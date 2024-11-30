package com.example.recipe.repository;

import com.example.recipe.model.PlanIngredients;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PlanIngredientsRepository extends JpaRepository<PlanIngredients, Integer> {
    Optional<PlanIngredients> findByPlanIdAndIngredientId(int planID, int ingredientID);
    void deleteByPlanIdAndIngredientId(int planID, int ingredientID);
}
