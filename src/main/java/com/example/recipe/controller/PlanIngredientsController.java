package com.example.recipe.controller;

import com.example.recipe.model.PlanIngredients;
import com.example.recipe.repository.PlanIngredientsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/planIngredients")
public class PlanIngredientsController {

    @Autowired
    private PlanIngredientsRepository planIngredientsRepository;

    // Get all plan ingredients
    @GetMapping
    public ResponseEntity<List<PlanIngredients>> getAllPlanIngredients() {
        try {
            List<PlanIngredients> planIngredients = planIngredientsRepository.findAll();
            if (planIngredients.isEmpty()) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            }
            return new ResponseEntity<>(planIngredients, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Get a specific plan ingredient by composite key (planID and ingredientID)
    @GetMapping("/{planID}/{ingredientID}")
    public ResponseEntity<PlanIngredients> getPlanIngredientById(
            @PathVariable("planID") int planID, @PathVariable("ingredientID") int ingredientID) {
        Optional<PlanIngredients> planIngredient = planIngredientsRepository.findByPlanIdAndIngredientId(planID, ingredientID);
        return planIngredient.map(ResponseEntity::ok)
                .orElse(new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    // Create a new plan ingredient
    @PostMapping
    public ResponseEntity<PlanIngredients> createPlanIngredient(@RequestBody PlanIngredients planIngredient) {
        try {
            PlanIngredients newPlanIngredient = planIngredientsRepository.save(planIngredient);
            return new ResponseEntity<>(newPlanIngredient, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Update an existing plan ingredient
    @PutMapping("/{planID}/{ingredientID}")
    public ResponseEntity<PlanIngredients> updatePlanIngredient(
            @PathVariable("planID") int planID, 
            @PathVariable("ingredientID") int ingredientID, 
            @RequestBody PlanIngredients planIngredientDetails) {
        Optional<PlanIngredients> planIngredient = planIngredientsRepository.findByPlanIdAndIngredientId(planID, ingredientID);

        if (planIngredient.isPresent()) {
            PlanIngredients existingPlanIngredient = planIngredient.get();
            existingPlanIngredient.setAmountNeeded(planIngredientDetails.getAmountNeeded());
            return new ResponseEntity<>(planIngredientsRepository.save(existingPlanIngredient), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    // Delete a specific plan ingredient by composite key
    @DeleteMapping("/{planID}/{ingredientID}")
    public ResponseEntity<HttpStatus> deletePlanIngredient(
            @PathVariable("planID") int planID, 
            @PathVariable("ingredientID") int ingredientID) {
        try {
            planIngredientsRepository.deleteByPlanIdAndIngredientId(planID, ingredientID);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Delete all plan ingredients
    @DeleteMapping
    public ResponseEntity<HttpStatus> deleteAllPlanIngredients() {
        try {
            planIngredientsRepository.deleteAll();
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
