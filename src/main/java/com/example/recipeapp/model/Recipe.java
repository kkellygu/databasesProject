package com.example.recipeapp.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class Recipe {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int recipeID;

    @ManyToOne
    @JoinColumn(name = "userID")
    private User user;

    private String name;
    private String instructions;
    private Double protein = 0.0;
    private Double fats = 0.0;
    private Double carbs = 0.0;
    private Double calories = 0.0;
    private String origin;
    private String cuisine;
}
