package com.example.recipe.model;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class RecipeCookingSuppliesKey implements Serializable {

    @Column(name = "recipeID")
    private int recipeID;

    @Column(name = "cookingSupplies")
    private String cookingSupplies;

    public int getRecipeID() {
        return recipeID;
    }

    public void setRecipeID(int recipeID) {
        this.recipeID = recipeID;
    }

    public String getCookingSupplies() {
        return cookingSupplies;
    }

    public void setCookingSupplies(String cookingSupplies) {
        this.cookingSupplies = cookingSupplies;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        RecipeCookingSuppliesKey that = (RecipeCookingSuppliesKey) o;
        return recipeID == that.recipeID && Objects.equals(cookingSupplies, that.cookingSupplies);
    }

    @Override
    public int hashCode() {
        return Objects.hash(recipeID, cookingSupplies);
    }
}
