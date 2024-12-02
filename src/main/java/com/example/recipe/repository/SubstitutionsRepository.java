package com.example.recipe.repository;

import com.example.recipe.model.Substitutions;
import com.example.recipe.model.SubstitutionsKey;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SubstitutionsRepository extends JpaRepository<Substitutions, SubstitutionsKey> {
}
