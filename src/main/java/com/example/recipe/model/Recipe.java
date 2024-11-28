package com.example.recipe.model;

import jakarta.persistence.*;

import java.math.BigDecimal;
import java.util.Set;

@Entity
@Table(name = "recipe")
public class Recipe {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "recipeID")
    private int recipeID;

    @Column(name = "userID", nullable = false)
    private int userID;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "instructions", columnDefinition = "TEXT", nullable = false)
    private String instructions;

    @Column(name = "protein", precision = 5, scale = 2, nullable = false)
    private BigDecimal protein = BigDecimal.ZERO;

    @Column(name = "fats", precision = 5, scale = 2, nullable = false)
    private BigDecimal fats = BigDecimal.ZERO;

    @Column(name = "carbs", precision = 5, scale = 2, nullable = false)
    private BigDecimal carbs = BigDecimal.ZERO;

    @Column(name = "calories", precision = 6, scale = 2, nullable = false)
    private BigDecimal calories = BigDecimal.ZERO;

    @Column(name = "origin")
    private String origin;

    @Column(name = "cuisine")
    private String cuisine;

    @ManyToMany
    @JoinTable(
        name = "recipeTags",
        joinColumns = @JoinColumn(name = "recipeID"),
        inverseJoinColumns = @JoinColumn(name = "tagID")
    )
    private Set<RecipeTags> tags;

    // Getters and setters
    public int getRecipeID() {
        return recipeID;
    }

    public void setRecipeID(int recipeID) {
        this.recipeID = recipeID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getInstructions() {
        return instructions;
    }

    public void setInstructions(String instructions) {
        this.instructions = instructions;
    }

    public BigDecimal getProtein() {
        return protein;
    }

    public void setProtein(BigDecimal protein) {
        this.protein = protein;
    }

    public BigDecimal getFats() {
        return fats;
    }

    public void setFats(BigDecimal fats) {
        this.fats = fats;
    }

    public BigDecimal getCarbs() {
        return carbs;
    }

    public void setCarbs(BigDecimal carbs) {
        this.carbs = carbs;
    }

    public BigDecimal getCalories() {
        return calories;
    }

    public void setCalories(BigDecimal calories) {
        this.calories = calories;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public String getCuisine() {
        return cuisine;
    }

    public void setCuisine(String cuisine) {
        this.cuisine = cuisine;
    }

    public Set<Tag> getTags() {
        return tags;
    }

    public void setTags(Set<Tag> tags) {
        this.tags = tags;
    }
}
