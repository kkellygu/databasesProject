package com.example.recipe.controller;

import com.example.recipe.model.UserIngredients;
import com.example.recipe.repository.UserIngredientsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/userIngredients")
public class UserIngredientsController {

    @Autowired
    private UserIngredientsRepository userIngredientsRepository;

    @GetMapping
    public ResponseEntity<List<UserIngredients>> getAllUserIngredients() {
        try {
            List<UserIngredients> userIngredients = userIngredientsRepository.findAll();
            return userIngredients.isEmpty() ? new ResponseEntity<>(HttpStatus.NO_CONTENT) : new ResponseEntity<>(userIngredients, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/{userID}/{ingredientID}")
    public ResponseEntity<UserIngredients> getUserIngredientById(@PathVariable int userID, @PathVariable int ingredientID) {
        Optional<UserIngredients> userIngredient = userIngredientsRepository.findByUser_UserIDAndIngredient_IngredientID(userID, ingredientID);
        return userIngredient.map(ResponseEntity::ok).orElse(new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    @PostMapping
    public ResponseEntity<UserIngredients> createUserIngredient(@RequestBody UserIngredients userIngredient) {
        try {
            return new ResponseEntity<>(userIngredientsRepository.save(userIngredient), HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping("/{userID}/{ingredientID}")
    public ResponseEntity<UserIngredients> updateUserIngredient(@PathVariable int userID, @PathVariable int ingredientID, @RequestBody UserIngredients userIngredientDetails) {
        Optional<UserIngredients> userIngredientData = userIngredientsRepository.findByUser_UserIDAndIngredient_IngredientID(userID, ingredientID);
        if (userIngredientData.isPresent()) {
            UserIngredients userIngredient = userIngredientData.get();
            userIngredient.setUserAmount(userIngredientDetails.getUserAmount());
            return new ResponseEntity<>(userIngredientsRepository.save(userIngredient), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{userID}/{ingredientID}")
    public ResponseEntity<HttpStatus> deleteUserIngredient(@PathVariable int userID, @PathVariable int ingredientID) {
        try {
            userIngredientsRepository.deleteByUser_UserIDAndIngredient_IngredientID(userID, ingredientID);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
