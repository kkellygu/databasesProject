package com.example.recipe.model;

import jakarta.persistence.*;

@Entity
@Table(name = "recipeIngredients")
public class RecipeIngredient {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id; // Add a unique identifier for mapping (optional).

    @Column(nullable = false)
    private int recipeID;

    @Column(nullable = false)
    private int ingredientID;

    @Column(nullable = false, length = 50)
    private String recipeAmount;

    // Getters and setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public int getRecipeID() {
        return recipeID;
    }

    public void setRecipeID(int recipeID) {
        this.recipeID = recipeID;
    }

    public int getIngredientID() {
        return ingredientID;
    }

    public void setIngredientID(int ingredientID) {
        this.ingredientID = ingredientID;
    }

    public String getRecipeAmount() {
        return recipeAmount;
    }

    public void setRecipeAmount(String recipeAmount) {
        this.recipeAmount = recipeAmount;
    }
}
