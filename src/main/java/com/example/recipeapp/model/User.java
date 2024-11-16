package com.example.recipeapp.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int userID;

    private String name;
    
    @Column(unique = true)
    private String username;

    private String password;
}
