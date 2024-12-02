package com.example.recipe.controller;
import com.example.recipe.model.RecipeCookingSupplies;
import com.example.recipe.model.RecipeCookingSuppliesKey;
import com.example.recipe.repository.RecipeCookingSuppliesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/recipe-cooking-supplies")
public class RecipeCookingSuppliesController {

    @Autowired
    private RecipeCookingSuppliesRepository recipeCookingSuppliesRepository;

    // Get all recipe cooking supplies
    @GetMapping
    public List<RecipeCookingSupplies> getAllRecipeCookingSupplies() {
        return recipeCookingSuppliesRepository.findAll();
    }

    // Get a specific recipe cooking supply by composite key
    @GetMapping("/{recipeID}/{cookingSupplies}")
    public ResponseEntity<RecipeCookingSupplies> getRecipeCookingSupplyById(
            @PathVariable int recipeID, @PathVariable String cookingSupplies) {
        RecipeCookingSuppliesKey id = new RecipeCookingSuppliesKey();
        id.setRecipeID(recipeID);
        id.setCookingSupplies(cookingSupplies);

        Optional<RecipeCookingSupplies> recipeCookingSupply = recipeCookingSuppliesRepository.findById(id);

        return recipeCookingSupply.map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Create a new recipe cooking supply
    @PostMapping
    public RecipeCookingSupplies createRecipeCookingSupply(@RequestBody RecipeCookingSupplies recipeCookingSupplies) {
        return recipeCookingSuppliesRepository.save(recipeCookingSupplies);
    }

    // Update a recipe cooking supply by composite key
    @PutMapping("/{recipeID}/{cookingSupplies}")
    public ResponseEntity<RecipeCookingSupplies> updateRecipeCookingSupply(
            @PathVariable int recipeID,
            @PathVariable String cookingSupplies,
            @RequestBody RecipeCookingSupplies updatedRecipeCookingSupply) {
        RecipeCookingSuppliesKey id = new RecipeCookingSuppliesKey();
        id.setRecipeID(recipeID);
        id.setCookingSupplies(cookingSupplies);

        Optional<RecipeCookingSupplies> existingRecipeCookingSupply = recipeCookingSuppliesRepository.findById(id);

        if (existingRecipeCookingSupply.isPresent()) {
            RecipeCookingSupplies recipeCookingSupply = existingRecipeCookingSupply.get();
            
            recipeCookingSuppliesRepository.save(recipeCookingSupply);

            return new ResponseEntity<>(recipeCookingSupply, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    // Delete a recipe cooking supply by composite key
    @DeleteMapping("/{recipeID}/{cookingSupplies}")
    public ResponseEntity<HttpStatus> deleteRecipeCookingSupply(
            @PathVariable int recipeID, @PathVariable String cookingSupplies) {
        try {
            RecipeCookingSuppliesKey id = new RecipeCookingSuppliesKey();
            id.setRecipeID(recipeID);
            id.setCookingSupplies(cookingSupplies);

            recipeCookingSuppliesRepository.deleteById(id);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
