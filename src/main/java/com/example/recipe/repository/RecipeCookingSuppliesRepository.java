package com.example.recipe.repository;

import com.example.recipe.model.RecipeCookingSupplies;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RecipeCookingSuppliesRepository extends JpaRepository<RecipeCookingSupplies, Integer> {
}
