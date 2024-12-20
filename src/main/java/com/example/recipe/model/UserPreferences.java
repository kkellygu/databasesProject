package com.example.recipe.model;

import jakarta.persistence.*;

@Entity
@Table(name = "userPreferences")
public class UserPreferences {

    @Id
    @ManyToOne
    @JoinColumn(name = "userID", referencedColumnName = "userID", nullable = false)
    private int userID;

    @Column(name = "preferences", nullable = false)
    private String preferences;

    public UserPreferences(int userID, String preferences) {
        this.userID = userID;
        this.preferences = preferences;
    }

    // Getters and setters
    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getPreferences() {
        return preferences;
    }

    public void setPreferences(String preferences) {
        this.preferences = preferences;
    }
}
