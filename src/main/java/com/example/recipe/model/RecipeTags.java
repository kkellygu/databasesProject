package com.example.recipe.model;

import jakarta.persistence.*;

@Entity
@Table(name = "recipeTags") // Table name in the database
public class RecipeTags {

    @Id
    @Column(name = "recipeID") // Maps to recipeID column
    private int recipeID;

    @Column(name = "tags") // Maps to tags column
    private String tags;

    // Getters and setters
    public int getRecipeID() {
        return recipeID;
    }

    public void setRecipeID(int recipeID) {
        this.recipeID = recipeID;
    }

    public String getTags() {
        return tags;
    }

    public void setTags(String tags) {
        this.tags = tags;
    }
}
