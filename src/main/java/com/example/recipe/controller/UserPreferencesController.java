package com.example.recipe.controller;

import com.example.recipe.model.UserPreferences;
import com.example.recipe.repository.UserPreferencesRepository;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.util.List;
import java.util.Optional;

@CrossOrigin
@RestController
@RequestMapping("/api")
public class UserPreferencesController {

    @Autowired
    private UserPreferencesRepository userPreferencesRepository;

    // Get all user preferences
    @GetMapping("/userPreferences")
    public ResponseEntity<List<UserPreferences>> getAllUserPreferences() {
        try {
            List<UserPreferences> userPreferences = userPreferencesRepository.findAll();

            if (userPreferences.isEmpty()) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            }
            return new ResponseEntity<>(userPreferences, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Get a user preference by ID
    @GetMapping("/userPreferences/{id}")
    public ResponseEntity<UserPreferences> getUserPreferenceById(@PathVariable("id") int id) {
        Optional<UserPreferences> userPreference = userPreferencesRepository.findById(id);

        return userPreference.map(value -> new ResponseEntity<>(value, HttpStatus.OK))
                .orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    // Create a new user preference
    @PostMapping("/userPreferences")
    public ResponseEntity<UserPreferences> createUserPreference(@RequestBody UserPreferences userPreference) {
        try {
            UserPreferences newUserPreference = userPreferencesRepository.save(userPreference);
            return new ResponseEntity<>(newUserPreference, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Update an existing user preference
    @PutMapping("/userPreferences/{id}")
    public ResponseEntity<UserPreferences> updateUserPreference(@PathVariable("id") int id, @RequestBody UserPreferences userPreferenceDetails) {
        Optional<UserPreferences> userPreferenceData = userPreferencesRepository.findById(id);

        if (userPreferenceData.isPresent()) {
            UserPreferences existingPreference = userPreferenceData.get();
            existingPreference.setPreferences(userPreferenceDetails.getPreferences());
            return new ResponseEntity<>(userPreferencesRepository.save(existingPreference), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    // Delete a user preference by ID
    @DeleteMapping("/userPreferences/{id}")
    public ResponseEntity<HttpStatus> deleteUserPreference(@PathVariable("id") int id) {
        try {
            userPreferencesRepository.deleteById(id);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Delete all user preferences
    @DeleteMapping("/userPreferences")
    public ResponseEntity<HttpStatus> deleteAllUserPreferences() {
        try {
            userPreferencesRepository.deleteAll();
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
