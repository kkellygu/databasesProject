package com.example.recipe.model;

import jakarta.persistence.*;

@Entity
@Table(name = "planIngredients")
public class PlanIngredients {

    @Id
    @ManyToOne
    @JoinColumn(name = "planID", nullable = false)
    private Plan plan;

    @Id
    @ManyToOne
    @JoinColumn(name = "ingredientID", nullable = false)
    private Ingredient ingredient;

    @Column(name = "amountNeeded", nullable = false)
    private String amountNeeded;

    public PlanIngredients() {
    }

    public PlanIngredients(Plan plan, Ingredient ingredient, String amountNeeded) {
        this.plan = plan;
        this.ingredient = ingredient;
        this.amountNeeded = amountNeeded;
    }

    public Plan getPlan() {
        return plan;
    }

    public void setPlan(Plan plan) {
        this.plan = plan;
    }

    public Ingredient getIngredient() {
        return ingredient;
    }

    public void setIngredient(Ingredient ingredient) {
        this.ingredient = ingredient;
    }

    public String getAmountNeeded() {
        return amountNeeded;
    }

    public void setAmountNeeded(String amountNeeded) {
        this.amountNeeded = amountNeeded;
    }
}
