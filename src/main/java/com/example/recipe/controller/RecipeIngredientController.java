package com.example.recipe.controller;

import com.example.recipe.model.RecipeIngredients;
import com.example.recipe.repository.RecipeIngredientsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/recipeIngredients")
public class RecipeIngredientController {

    @Autowired
    private RecipeIngredientsRepository recipeIngredientsRepository;

    // Get all recipe ingredients
    @GetMapping
    public List<RecipeIngredients> getAllRecipeIngredients() {
        return recipeIngredientsRepository.findAll();
    }

    // Get a specific recipe ingredient by ID
    @GetMapping("/{id}")
    public ResponseEntity<RecipeIngredients> getRecipeIngredientById(@PathVariable Long id) {
        return recipeIngredientsRepository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Create a new recipe ingredient
    @PostMapping
    public RecipeIngredients createRecipeIngredient(@RequestBody RecipeIngredients recipeIngredient) {
        return recipeIngredientsRepository.save(recipeIngredient);
    }

    // Update an existing recipe ingredient
    @PutMapping("/{id}")
    public ResponseEntity<RecipeIngredients> updateRecipeIngredient(
            @PathVariable Long id,
            @RequestBody RecipeIngredients updatedRecipeIngredient) {
        return recipeIngredientsRepository.findById(id).map(recipeIngredient -> {
            recipeIngredient.setRecipeID(updatedRecipeIngredient.getRecipeID());
            recipeIngredient.setIngredientID(updatedRecipeIngredient.getIngredientID());
            recipeIngredient.setRecipeAmount(updatedRecipeIngredient.getRecipeAmount());
            recipeIngredientsRepository.save(recipeIngredient);
            return ResponseEntity.ok(recipeIngredient);
        }).orElse(ResponseEntity.notFound().build());
    }

    // Delete a recipe ingredient
    @DeleteMapping("/{id}")
    public ResponseEntity<HttpStatus> deleteRecipeIngredient(@PathVariable("id") Long id) {
        try {
            recipeIngredientsRepository.deleteById(id);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
