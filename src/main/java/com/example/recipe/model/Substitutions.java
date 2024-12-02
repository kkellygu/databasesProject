package com.example.recipe.model;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "substitutions")
public class Substitutions implements Serializable {

    @EmbeddedId
    private SubstitutionsKey id;

    @Column(name = "ratio", nullable = false)
    private Double ratio;

    public SubstitutionsKey getId() {
        return id;
    }

    public void setId(SubstitutionsKey id) {
        this.id = id;
    }

    public Double getRatio() {
        return ratio;
    }

    public void setRatio(Double ratio) {
        this.ratio = ratio;
    }
}
