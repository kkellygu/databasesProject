package com.example.recipe.controller;

import com.example.recipe.model.RecipeTags; // For the RecipeTags entity
import com.example.recipe.repository.RecipeTagsRepository; // For the repository interface
import org.springframework.web.bind.annotation.*; // For annotations like @RestController, @RequestMapping, etc.
import org.springframework.beans.factory.annotation.Autowired; // For dependency injection of RecipeTagsRepository
import org.springframework.http.HttpStatus; // For HTTP status codes
import org.springframework.http.ResponseEntity; // For creating ResponseEntity objects

import java.util.Optional; // For handling optional objects

@RestController
@RequestMapping("/api")
public class RecipeTagsController {

    @Autowired
    private RecipeTagsRepository recipeTagsRepository;

    // Get a recipe tag by tag (primary key)
    @GetMapping("/recipeTags/{id}")
    public ResponseEntity<RecipeTags> getRecipeTagsById(@PathVariable("id") Integer id) {
        Optional<RecipeTags> recipeTag = recipeTagsRepository.findById(id);
        return recipeTag.map(value -> new ResponseEntity<>(value, HttpStatus.OK))
                .orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    // Create a new recipe tag
    @PostMapping("/recipeTags")
    public ResponseEntity<RecipeTags> createRecipeTag(@RequestBody RecipeTags recipeTag) {
        try {
            // Save the new recipe tag to the repository
            RecipeTags savedRecipeTag = recipeTagsRepository.save(recipeTag);
            return new ResponseEntity<>(savedRecipeTag, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Update a recipe tag
    @PutMapping("/recipeTags/{id}")
    public ResponseEntity<RecipeTags> updateRecipeTags(@PathVariable("id") Integer id, @RequestBody RecipeTags recipeTagDetails) {
        Optional<RecipeTags> recipeTagData = recipeTagsRepository.findById(id);

        if (recipeTagData.isPresent()) {
            RecipeTags existingRecipeTag = recipeTagData.get();
            existingRecipeTag.setRecipeID(recipeTagDetails.getRecipeID());
            existingRecipeTag.setTags(recipeTagDetails.getTags());
            return new ResponseEntity<>(recipeTagsRepository.save(existingRecipeTag), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    // Delete a recipe tag by ID
    @DeleteMapping("/recipeTags/{id}")
    public ResponseEntity<HttpStatus> deleteRecipeTags(@PathVariable("id") Integer id) {
        try {
            recipeTagsRepository.deleteById(id);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
