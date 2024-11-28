package com.example.recipe.controller;

import com.example.recipe.model.Review;
import com.example.recipe.repository.ReviewRepository;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.util.List;
import java.util.Optional;

@CrossOrigin
@RestController
@RequestMapping("/api")
public class ReviewController {

    @Autowired
    private ReviewRepository reviewRepository;

    // Get all reviews
    @GetMapping("/reviews")
    public ResponseEntity<List<Review>> getAllReviews() {
        try {
            List<Review> reviews = reviewRepository.findAll();
            if (reviews.isEmpty()) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            }
            return new ResponseEntity<>(reviews, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Get reviews by recipe ID
    @GetMapping("/reviews/recipe/{recipeID}")
    public ResponseEntity<List<Review>> getReviewsByRecipeID(@PathVariable("recipeID") int recipeID) {
        try {
            List<Review> reviews = reviewRepository.findByRecipeRecipeID(recipeID);
            if (reviews.isEmpty()) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            }
            return new ResponseEntity<>(reviews, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Get reviews by user ID
    @GetMapping("/reviews/user/{userID}")
    public ResponseEntity<List<Review>> getReviewsByUserID(@PathVariable("userID") int userID) {
        try {
            List<Review> reviews = reviewRepository.findByUserID(userID);
            if (reviews.isEmpty()) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            }
            return new ResponseEntity<>(reviews, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Get a review by ID
    @GetMapping("/reviews/{id}")
    public ResponseEntity<Review> getReviewById(@PathVariable("id") int id) {
        Optional<Review> review = reviewRepository.findById(id);
        return review.map(value -> new ResponseEntity<>(value, HttpStatus.OK))
                .orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    // Create a new review
    @PostMapping("/reviews")
    public ResponseEntity<Review> createReview(@RequestBody Review review) {
        try {
            Review newReview = reviewRepository.save(review);
            return new ResponseEntity<>(newReview, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Update an existing review
    @PutMapping("/reviews/{id}")
    public ResponseEntity<Review> updateReview(@PathVariable("id") int id, @RequestBody Review reviewDetails) {
        Optional<Review> reviewData = reviewRepository.findById(id);

        if (reviewData.isPresent()) {
            Review existingReview = reviewData.get();
            existingReview.setRecipe(reviewDetails.getRecipe());
            existingReview.setUserID(reviewDetails.getUserID());
            existingReview.setRating(reviewDetails.getRating());
            existingReview.setDate(reviewDetails.getDate());
            existingReview.setPublic(reviewDetails.isPublic());
            existingReview.setComment(reviewDetails.getComment());
            return new ResponseEntity<>(reviewRepository.save(existingReview), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    // Delete a review by ID
    @DeleteMapping("/reviews/{id}")
    public ResponseEntity<HttpStatus> deleteReview(@PathVariable("id") int id) {
        try {
            reviewRepository.deleteById(id);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Delete all reviews
    @DeleteMapping("/reviews")
    public ResponseEntity<HttpStatus> deleteAllReviews() {
        try {
            reviewRepository.deleteAll();
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
