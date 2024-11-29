package com.example.recipe.controller;

import com.example.recipe.model.Ingredient;
import com.example.recipe.repository.IngredientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/ingredients")
public class IngredientController {

    @Autowired
    private IngredientRepository ingredientRepository;

    // Get all ingredients
    @GetMapping
    public ResponseEntity<List<Ingredient>> getAllIngredients() {
        try {
            List<Ingredient> ingredients = ingredientRepository.findAll();
            if (ingredients.isEmpty()) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            }
            return new ResponseEntity<>(ingredients, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Get a specific ingredient by ID
    @GetMapping("/{id}")
    public ResponseEntity<Ingredient> getIngredientById(@PathVariable("id") int id) {
        Optional<Ingredient> ingredient = ingredientRepository.findById(id);
        return ingredient.map(ResponseEntity::ok)
                .orElse(new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    // Create a new ingredient
    @PostMapping
    public ResponseEntity<Ingredient> createIngredient(@RequestBody Ingredient ingredient) {
        try {
            Ingredient newIngredient = ingredientRepository.save(ingredient);
            return new ResponseEntity<>(newIngredient, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Update an existing ingredient
    @PutMapping("/{id}")
    public ResponseEntity<Ingredient> updateIngredient(
            @PathVariable("id") int id, @RequestBody Ingredient ingredientDetails) {
        Optional<Ingredient> ingredient = ingredientRepository.findById(id);

        if (ingredient.isPresent()) {
            Ingredient existingIngredient = ingredient.get();
            existingIngredient.setName(ingredientDetails.getName());
            existingIngredient.setType(ingredientDetails.getType());
            return new ResponseEntity<>(ingredientRepository.save(existingIngredient), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    // Delete an ingredient by ID
    @DeleteMapping("/{id}")
    public ResponseEntity<HttpStatus> deleteIngredient(@PathVariable("id") int id) {
        try {
            ingredientRepository.deleteById(id);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Delete all ingredients
    @DeleteMapping
    public ResponseEntity<HttpStatus> deleteAllIngredients() {
        try {
            ingredientRepository.deleteAll();
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
