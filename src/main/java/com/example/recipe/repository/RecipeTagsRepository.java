package com.example.recipe.repository;

import com.example.recipe.model.RecipeTags;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RecipeTagsRepository extends JpaRepository<RecipeTags, String> {
    // No additional methods needed unless specific queries are required
}
