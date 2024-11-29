package com.example.recipe.controller;

import com.example.recipe.model.RecipeCookingSupplies;
import com.example.recipe.repository.RecipeCookingSuppliesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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

    // Get a specific recipe cooking supply by ID
    @GetMapping("/{id}")
    public ResponseEntity<RecipeCookingSupplies> getRecipeCookingSupplyById(@PathVariable int id) {
        return recipeCookingSuppliesRepository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Create a new recipe cooking supply
    @PostMapping
    public RecipeCookingSupplies createRecipeCookingSupply(@RequestBody RecipeCookingSupplies recipeCookingSupplies) {
        return recipeCookingSuppliesRepository.save(recipeCookingSupplies);
    }

    // Update an existing recipe cooking supply
    @PutMapping("/{id}")
    public ResponseEntity<RecipeCookingSupplies> updateRecipeCookingSupply(
            @PathVariable int id, @RequestBody RecipeCookingSupplies recipeCookingSuppliesDetails) {
        return recipeCookingSuppliesRepository.findById(id)
                .map(recipeCookingSupplies -> {
                    recipeCookingSupplies.setRecipe(recipeCookingSuppliesDetails.getRecipe());
                    recipeCookingSupplies.setSupplyName(recipeCookingSuppliesDetails.getSupplyName());
                    recipeCookingSupplies.setQuantity(recipeCookingSuppliesDetails.getQuantity());
                    RecipeCookingSupplies updated = recipeCookingSuppliesRepository.save(recipeCookingSupplies);
                    return ResponseEntity.ok(updated);
                })
                .orElse(ResponseEntity.notFound().build());
    }

    // Delete a recipe cooking supply
    @DeleteMapping("/{id}")
    public ResponseEntity<HttpStatus> deleteRecipeCookingSupply(@PathVariable("id") int id) {
        try {
            recipeCookingSuppliesRepository.deleteById(id);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
