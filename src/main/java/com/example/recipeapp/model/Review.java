package com.example.recipeapp.model;

import jakarta.persistence.*;
import lombok.Data;

import java.sql.Date;

@Entity
@Data
public class Review {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int reviewID;

    @ManyToOne
    @JoinColumn(name = "recipeID")
    private Recipe recipe;

    @ManyToOne
    @JoinColumn(name = "userID")
    private User user;  // Each review is associated with a user

    private int rating;
    private Date date;
    private boolean isPublic = true;
    private String comment;
}
