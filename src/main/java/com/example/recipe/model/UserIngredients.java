package com.example.recipe.model;

import jakarta.persistence.*;

@Entity
@Table(name = "userIngredients")
public class UserIngredients {

    @Id
    @ManyToOne
    @JoinColumn(name = "userID", referencedColumnName = "userID", nullable = false)
    private User user;

    @Id
    @ManyToOne
    @JoinColumn(name = "ingredientID", referencedColumnName = "ingredientID", nullable = false)
    private Ingredient ingredient;

    @Column(name = "userAmount", nullable = false)
    private String userAmount;

    public UserIngredients() {
    }

    public UserIngredients(User user, Ingredient ingredient, String userAmount) {
        this.user = user;
        this.ingredient = ingredient;
        this.userAmount = userAmount;
    }

    // Getters and setters
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Ingredient getIngredient() {
        return ingredient;
    }

    public void setIngredient(Ingredient ingredient) {
        this.ingredient = ingredient;
    }

    public String getUserAmount() {
        return userAmount;
    }

    public void setUserAmount(String userAmount) {
        this.userAmount = userAmount;
    }
}
