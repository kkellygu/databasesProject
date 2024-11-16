package com.example.recipeapp.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import lombok.Data;

@Entity
@Data
public class UserPreferences {

    @Id
    private int userID;

    private String preferences;

    @OneToOne
    private User user;  // Assuming you have a User entity already
}
