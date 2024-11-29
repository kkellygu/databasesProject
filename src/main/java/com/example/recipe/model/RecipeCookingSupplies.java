package com.example.recipe.model;

import jakarta.persistence.*;

@Entity
@Table(name = "recipeCookingSupplies")
public class RecipeCookingSupplies {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @ManyToOne
    @JoinColumn(name = "recipeID", nullable = false)
    private Recipe recipe;

    @Column(name = "supplyName", nullable = false)
    private String supplyName;

    @Column(name = "quantity", nullable = false)
    private String quantity;

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Recipe getRecipe() {
        return recipe;
    }

    public void setRecipe(Recipe recipe) {
        this.recipe = recipe;
    }

    public String getSupplyName() {
        return supplyName;
    }

    public void setSupplyName(String supplyName) {
        this.supplyName = supplyName;
    }

    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }
}
