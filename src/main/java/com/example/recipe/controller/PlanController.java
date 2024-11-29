package com.example.recipe.controller;

import com.example.recipe.model.Plan;
import com.example.recipe.repository.PlanRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/plans")
public class PlanController {

    @Autowired
    private PlanRepository planRepository;

    // Get all plans
    @GetMapping
    public ResponseEntity<List<Plan>> getAllPlans() {
        try {
            List<Plan> plans = planRepository.findAll();
            if (plans.isEmpty()) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            }
            return new ResponseEntity<>(plans, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Get a specific plan by ID
    @GetMapping("/{id}")
    public ResponseEntity<Plan> getPlanById(@PathVariable int id) {
        return planRepository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Create a new plan
    @PostMapping
    public ResponseEntity<Plan> createPlan(@RequestBody Plan plan) {
        Plan savedPlan = planRepository.save(plan);
        return new ResponseEntity<>(savedPlan, HttpStatus.CREATED);
    }

    // Update an existing plan
    @PutMapping("/{id}")
    public ResponseEntity<Plan> updatePlan(
            @PathVariable("id") int id, @RequestBody Plan planDetails) {
        Optional<Plan> plan = planRepository.findById(id);

        if (plan.isPresent()) {
            Plan existingPlan = plan.get();
            existingPlan.setRecipeID(planDetails.getRecipeID());
            existingPlan.setDate(planDetails.getDate());
            existingPlan.setTime(planDetails.getTime());
            return new ResponseEntity<>(planRepository.save(existingPlan), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    // Delete a plan by ID
    @DeleteMapping("/{id}")
    public ResponseEntity<HttpStatus> deletePlan(@PathVariable("id") int id) {
        try {
            planRepository.deleteById(id);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Delete all plans
    @DeleteMapping
    public ResponseEntity<HttpStatus> deleteAllPlans() {
        try {
            planRepository.deleteAll();
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
