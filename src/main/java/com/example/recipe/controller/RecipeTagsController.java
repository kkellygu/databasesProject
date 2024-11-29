package com.example.recipe.controller;

import com.example.recipe.model.RecipeTags;
import com.example.recipe.repository.RecipeTagsRepository;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.util.List;
import java.util.Optional;

@CrossOrigin
@RestController
@RequestMapping("/api")
public class RecipeTagsController {

    @Autowired
    private RecipeTagsRepository recipeTagsRepository;

    // Get all recipe tags
    @GetMapping("/recipeTags")
    public ResponseEntity<List<RecipeTags>> getAllRecipeTags() {
        try {
            List<RecipeTags> recipeTags = recipeTagsRepository.findAll();
            if (recipeTags.isEmpty()) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            }
            return new ResponseEntity<>(recipeTags, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Get a recipe tag by tag (primary key)
    @GetMapping("/recipeTags/{tag}")
    public ResponseEntity<RecipeTags> getRecipeTagsById(@PathVariable("tag") String tag) {
        Optional<RecipeTags> recipeTag = recipeTagsRepository.findById(tag);
        return recipeTag.map(value -> new ResponseEntity<>(value, HttpStatus.OK))
                .orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    // Create a new recipe tag
    @PostMapping("/recipeTags")
    public ResponseEntity<RecipeTags> createRecipeTags(@RequestBody RecipeTags recipeTag) {
        try {
            RecipeTags newRecipeTag = recipeTagsRepository.save(recipeTag);
            return new ResponseEntity<>(newRecipeTag, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Update a recipe tag
    @PutMapping("/recipeTags/{tags}")
    public ResponseEntity<RecipeTags> updateRecipeTags(@PathVariable("tags") String tags, @RequestBody RecipeTags recipeTagDetails) {
        Optional<RecipeTags> recipeTagData = recipeTagsRepository.findById(tags);

        if (recipeTagData.isPresent()) {
            RecipeTags existingRecipeTag = recipeTagData.get();
            existingRecipeTag.setRecipeID(recipeTagDetails.getRecipeID());
            existingRecipeTag.setTags(recipeTagDetails.getTags());
            return new ResponseEntity<>(recipeTagsRepository.save(existingRecipeTag), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
        // Delete a recipe tag by tags (primary key)
        @DeleteMapping("/recipeTags/{tags}")
        public ResponseEntity<HttpStatus> deleteRecipeTags(@PathVariable("tags") String tags) {
            try {
                recipeTagsRepository.deleteById(tags); // Adjusted to use 'tags'
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            } catch (Exception e) {
                return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }
    
        // Delete all recipe tags
        @DeleteMapping("/recipeTags")
        public ResponseEntity<HttpStatus> deleteAllRecipeTags() {
            try {
                recipeTagsRepository.deleteAll(); // Deletes all entries in the table
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            } catch (Exception e) {
                return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }
    
}
