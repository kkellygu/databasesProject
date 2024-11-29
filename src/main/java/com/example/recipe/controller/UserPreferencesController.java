package com.example.recipe.controller;

import com.example.recipe.model.UserPreferences;
import com.example.recipe.repository.UserPreferencesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/api")
public class UserPreferencesController {

    @Autowired
    private UserPreferencesRepository userPreferencesRepository;

    // Get preferences for a user
    @GetMapping("/users/{userID}/preferences")
    public ResponseEntity<List<UserPreferences>> getUserPreferences(@PathVariable int userID) {
        try {
            List<UserPreferences> preferences = userPreferencesRepository.findByUserID(userID);
            if (preferences.isEmpty()) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            }
            return new ResponseEntity<>(preferences, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Add a preference for a user
    @PostMapping("/users/{userID}/preferences")
    public ResponseEntity<UserPreferences> addUserPreference(
            @PathVariable int userID,
            @RequestBody String preference) {
        try {
            UserPreferences newPreference = new UserPreferences(userID, preference);
            UserPreferences savedPreference = userPreferencesRepository.save(newPreference);
            return new ResponseEntity<>(savedPreference, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Delete a preference for a user
    @DeleteMapping("/users/{userID}/preferences/{preference}")
    public ResponseEntity<HttpStatus> deleteUserPreference(
            @PathVariable int userID,
            @PathVariable String preference) {
        try {
            userPreferencesRepository.deleteById(userID); // Or use a custom delete query
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
