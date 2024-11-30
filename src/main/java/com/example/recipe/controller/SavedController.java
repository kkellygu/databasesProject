package com.example.recipe.controller;

import com.example.recipe.model.Saved;
import com.example.recipe.repository.SavedRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/saved")
public class SavedController {

    @Autowired
    private SavedRepository savedRepository;

    @GetMapping
    public ResponseEntity<List<Saved>> getAllSaved() {
        try {
            List<Saved> saved = savedRepository.findAll();
            return saved.isEmpty() ? new ResponseEntity<>(HttpStatus.NO_CONTENT) : new ResponseEntity<>(saved, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/{userID}/{recipeID}")
    public ResponseEntity<Saved> getSavedById(@PathVariable int userID, @PathVariable int recipeID) {
        Optional<Saved> saved = savedRepository.findByUser_UserIDAndRecipe_RecipeID(userID, recipeID);
        return saved.map(ResponseEntity::ok).orElse(new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    @PostMapping
    public ResponseEntity<Saved> createSaved(@RequestBody Saved saved) {
        try {
            return new ResponseEntity<>(savedRepository.save(saved), HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping("/{userID}/{recipeID}")
    public ResponseEntity<Saved> updateSaved(@PathVariable int userID, @PathVariable int recipeID, @RequestBody Saved savedDetails) {
        Optional<Saved> savedData = savedRepository.findByUser_UserIDAndRecipe_RecipeID(userID, recipeID);
        if (savedData.isPresent()) {
            Saved saved = savedData.get();
            saved.setTried(savedDetails.isTried());
            return new ResponseEntity<>(savedRepository.save(saved), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{userID}/{recipeID}")
    public ResponseEntity<HttpStatus> deleteSaved(@PathVariable int userID, @PathVariable int recipeID) {
        try {
            savedRepository.deleteByUser_UserIDAndRecipe_RecipeID(userID, recipeID);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
