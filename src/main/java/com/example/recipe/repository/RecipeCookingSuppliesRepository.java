package com.example.recipe.repository;
import com.example.recipe.model.RecipeCookingSuppliesKey;
import com.example.recipe.model.RecipeCookingSupplies;



import org.springframework.data.jpa.repository.JpaRepository;
public interface RecipeCookingSuppliesRepository extends JpaRepository<RecipeCookingSupplies, RecipeCookingSuppliesKey> {
}
