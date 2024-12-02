package com.example.recipe.controller;

import com.example.recipe.model.RecipeIngredient;
import com.example.recipe.repository.RecipeIngredientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/recipeIngredients")
public class RecipeIngredientController {

    @Autowired
    private RecipeIngredientRepository recipeIngredientRepository;

    // Get all recipe ingredients
    @GetMapping
    public List<RecipeIngredient> getAllRecipeIngredients() {
        return recipeIngredientRepository.findAll();
    }

    // Get a specific recipe ingredient by ID
    @GetMapping("/{id}")
    public ResponseEntity<RecipeIngredient> getRecipeIngredientById(@PathVariable Long id) {
        return recipeIngredientRepository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Create a new recipe ingredient
    @PostMapping
    public RecipeIngredient createRecipeIngredient(@RequestBody RecipeIngredient recipeIngredient) {
        return recipeIngredientRepository.save(recipeIngredient);
    }

    // Update an existing recipe ingredient
    @PutMapping("/{id}")
    public ResponseEntity<RecipeIngredient> updateRecipeIngredient(
            @PathVariable Long id,
            @RequestBody RecipeIngredient updatedRecipeIngredient) {
        return recipeIngredientRepository.findById(id).map(recipeIngredient -> {
            recipeIngredient.setRecipeID(updatedRecipeIngredient.getRecipeID());
            recipeIngredient.setIngredientID(updatedRecipeIngredient.getIngredientID());
            recipeIngredient.setRecipeAmount(updatedRecipeIngredient.getRecipeAmount());
            recipeIngredientRepository.save(recipeIngredient);
            return ResponseEntity.ok(recipeIngredient);
        }).orElse(ResponseEntity.notFound().build());
    }

    // Delete a recipe ingredient
    @DeleteMapping("/{id}")
    public ResponseEntity<HttpStatus> deleteRecipeIngredient(@PathVariable("id") Long id) {
        try {
            recipeIngredientRepository.deleteById(id);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
