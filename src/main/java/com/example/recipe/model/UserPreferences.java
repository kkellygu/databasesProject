package com.example.recipe.model;

import com.example.recipe.model.UserPreferences;

import jakarta.persistence.*;

@Entity
@Table(name = "userPreferences")
public class UserPreferences {
    @Id
    @Column(name = "userID")
    private int userID;

    @Column(name="preferences")
    private String preferences;

    @ManyToOne
    @JoinColumn(name = "userID", fetch = FetchType.LAZY, referencedColumnName = "userID", nullable = false)
    private UserPreferences user; 

    public Integer getUserID() {
        return userID;
    }

    public void setUserID(Integer userID) {
        this.userID = userID;
    }

    public String getPreferences() {
        return preferences;
    }

    public void setPreferences(String preferences) {
        this.preferences = preferences;
    }

    public UserPreferences getUser() {
        return user;
    }

    public void setUser(UserPreferences user) {
        this.user = user;
    }
}
