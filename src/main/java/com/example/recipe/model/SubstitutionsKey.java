package com.example.recipe.model;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class SubstitutionsKey implements Serializable {

    @Column(name = "ingredientID")
    private int ingredientID;

    @Column(name = "substituteIngredientID")
    private int substituteIngredientID;

    public int getIngredientID() {
        return ingredientID;
    }

    public void setIngredientID(int ingredientID) {
        this.ingredientID = ingredientID;
    }

    public int getSubstituteIngredientID() {
        return substituteIngredientID;
    }

    public void setSubstituteIngredientID(int substituteIngredientID) {
        this.substituteIngredientID = substituteIngredientID;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        SubstitutionsKey that = (SubstitutionsKey) o;
        return ingredientID == that.ingredientID &&
               substituteIngredientID == that.substituteIngredientID;
    }

    @Override
    public int hashCode() {
        return Objects.hash(ingredientID, substituteIngredientID);
    }
}
