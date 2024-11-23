package main.java.com.example.recipe.repository;

import com.example.recipe.model.UserPreferences;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserPreferencesRepository extends JpaRepository<UserPreferences, Integer> {
}
