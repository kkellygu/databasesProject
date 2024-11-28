package com.example.recipe.model;

import jakarta.persistence.*;

@Entity
@Table(name = "userPreferences")
public class UserPreferences {
    @Id
    @Column(name = "userID")
    private int userID;

    @Column(name = "preferences")
    private String preferences;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userID", referencedColumnName = "userID", insertable = false, updatable = false)
    private User user;

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

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
