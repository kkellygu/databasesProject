package com.example.recipeapp.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class RecipeCookingSupplies {
    @Id
    @ManyToOne
    @JoinColumn(name = "recipeID")
    private Recipe recipe;

    private String cookingSupplies;
}
