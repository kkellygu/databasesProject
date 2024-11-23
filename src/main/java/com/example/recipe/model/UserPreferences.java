package main.java.com.example.recipe.model;

import com.example.recipe.model.User;

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
