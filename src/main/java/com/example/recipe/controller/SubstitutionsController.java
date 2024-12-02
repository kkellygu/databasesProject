package com.example.recipe.controller;

import com.example.recipe.model.Substitutions;
import com.example.recipe.model.SubstitutionsKey;
import com.example.recipe.repository.SubstitutionsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/api/substitutions")
public class SubstitutionsController {

    @Autowired
    private SubstitutionsRepository substitutionsRepository;

    // Get all substitutions
    @GetMapping
    public ResponseEntity<Iterable<Substitutions>> getAllSubstitutions() {
        try {
            return new ResponseEntity<>(substitutionsRepository.findAll(), HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Get a specific substitution by composite key
    @GetMapping("/{ingredientID}/{substituteIngredientID}")
    public ResponseEntity<Substitutions> getSubstitutionById(
            @PathVariable int ingredientID, @PathVariable int substituteIngredientID) {
        SubstitutionsKey id = new SubstitutionsKey();
        id.setIngredientID(ingredientID);
        id.setSubstituteIngredientID(substituteIngredientID);

        Optional<Substitutions> substitution = substitutionsRepository.findById(id);

        return substitution.map(value -> new ResponseEntity<>(value, HttpStatus.OK))
                .orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    // Create a new substitution
    @PostMapping
    public ResponseEntity<Substitutions> createSubstitution(@RequestBody Substitutions substitution) {
        try {
            Substitutions savedSubstitution = substitutionsRepository.save(substitution);
            return new ResponseEntity<>(savedSubstitution, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Update an existing substitution
    @PutMapping("/{ingredientID}/{substituteIngredientID}")
    public ResponseEntity<Substitutions> updateSubstitution(
            @PathVariable int ingredientID, @PathVariable int substituteIngredientID,
            @RequestBody Substitutions updatedSubstitution) {
        SubstitutionsKey id = new SubstitutionsKey();
        id.setIngredientID(ingredientID);
        id.setSubstituteIngredientID(substituteIngredientID);

        Optional<Substitutions> substitutionData = substitutionsRepository.findById(id);

        if (substitutionData.isPresent()) {
            Substitutions existingSubstitution = substitutionData.get();
            existingSubstitution.setRatio(updatedSubstitution.getRatio());
            Substitutions savedSubstitution = substitutionsRepository.save(existingSubstitution);
            return new ResponseEntity<>(savedSubstitution, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    // Delete a substitution
    @DeleteMapping("/{ingredientID}/{substituteIngredientID}")
    public ResponseEntity<HttpStatus> deleteSubstitution(
            @PathVariable int ingredientID, @PathVariable int substituteIngredientID) {
        try {
            SubstitutionsKey id = new SubstitutionsKey();
            id.setIngredientID(ingredientID);
            id.setSubstituteIngredientID(substituteIngredientID);

            substitutionsRepository.deleteById(id);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
