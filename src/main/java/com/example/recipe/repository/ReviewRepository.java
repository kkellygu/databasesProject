package com.example.recipe.repository;

import com.example.recipe.model.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Integer> {
    List<Review> findByRecipeRecipeID(int recipeID);
    List<Review> findByUserID(int userID);
}
