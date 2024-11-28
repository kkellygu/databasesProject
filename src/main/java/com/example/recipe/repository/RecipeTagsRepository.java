package com.example.recipe.repository;

import com.example.recipe.model.RecipeTags;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RecipeTagsRepository extends JpaRepository<RecipeTags, Integer> {
    RecipeTags findByName(String name);
}
