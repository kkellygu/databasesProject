package com.example.recipe.model;

import jakarta.persistence.*;
@Entity
@Table(name = "recipeCookingSupplies")
public class RecipeCookingSupplies {

    @EmbeddedId
    private RecipeCookingSuppliesKey id;

    // Other fields and methods

    public RecipeCookingSuppliesKey getId() {
        return id;
    }

    public void setId(RecipeCookingSuppliesKey id) {
        this.id = id;
    }
}
