package com.example.recipe.model;

import jakarta.persistence.*;

@Entity
@Table(name = "saved")
public class Saved {

    @Id
    @ManyToOne
    @JoinColumn(name = "userID", referencedColumnName = "userID", nullable = false)
    private User user;

    @Id
    @ManyToOne
    @JoinColumn(name = "recipeID", referencedColumnName = "recipeID", nullable = false)
    private Recipe recipe;

    @Column(name = "tried", nullable = false)
    private boolean tried = false;

    public Saved() {
    }

    public Saved(User user, Recipe recipe, boolean tried) {
        this.user = user;
        this.recipe = recipe;
        this.tried = tried;
    }

    // Getters and setters
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Recipe getRecipe() {
        return recipe;
    }

    public void setRecipe(Recipe recipe) {
        this.recipe = recipe;
    }

    public boolean isTried() {
        return tried;
    }

    public void setTried(boolean tried) {
        this.tried = tried;
    }
}
