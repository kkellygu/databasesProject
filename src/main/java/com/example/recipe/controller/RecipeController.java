package com.example.recipe.controller;

import com.example.recipe.model.User;
import com.example.recipe.repository.UserRepository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@CrossOrigin
@RestController
@RequestMapping("/api")
public class RecipeController {

    @Autowired
    UserRepository UserRepository;

    @GetMapping("/users")
    public ResponseEntity<List<User>> getAllPatients(@RequestParam(required = false) String firstName) {
        try {
            List<User> users = new ArrayList<User>();

            if (firstName == null)
                UserRepository.findAll().forEach(users::add);
            else
                UserRepository.findByFirstNameContaining(firstName).forEach(users::add);

            if (users.isEmpty()) {
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            }

            return new ResponseEntity<>(users, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // @GetMapping("/users/{id}")
    // public ResponseEntity<User> getPatientById(@PathVariable("id") long id) {
    // Optional<User> patientData = UserRepository.findById(id);

    // if (patientData.isPresent()) {
    // return new ResponseEntity<>(patientData.get(), HttpStatus.OK);
    // } else {
    // return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    // }
    // }

    // @PostMapping("/users")
    // public ResponseEntity<User> createPatient(@RequestBody User user) {
    // try {
    // User _patient = UserRepository
    // .save(new User(user.getFirstName(), user.getLastName(), user.getDob(),
    // user.getStreet(), user.getCity(), user.getState(), user.getZipCode(),
    // user.getPhoneNo(), user.getEmailAddress()));
    // return new ResponseEntity<>(_patient, HttpStatus.CREATED);
    // } catch (Exception e) {
    // return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
    // }
    // }

    // @PutMapping("/users/{id}")
    // public ResponseEntity<User> updatePatient(@PathVariable("id") long id,
    // @RequestBody User user) {
    // Optional<User> patientData = UserRepository.findById(id);

    // if (patientData.isPresent()) {
    // User _patient = patientData.get();
    // _patient.setFirstName(user.getFirstName());
    // _patient.setLastName(user.getLastName());
    // _patient.setDob(user.getDob());
    // _patient.setStreet(user.getStreet());
    // _patient.setCity(user.getCity());
    // _patient.setState(user.getState());
    // _patient.setZipCode(user.getZipCode());
    // _patient.setPhoneNo(user.getPhoneNo());
    // return new ResponseEntity<>(UserRepository.save(_patient), HttpStatus.OK);
    // } else {
    // return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    // }
    // }

    // @DeleteMapping("/users/{id}")
    // public ResponseEntity<HttpStatus> deletePatient(@PathVariable("id") long id)
    // {
    // try {
    // UserRepository.deleteById(id);
    // return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    // } catch (Exception e) {
    // return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    // }
    // }

    // @DeleteMapping("/users")
    // public ResponseEntity<HttpStatus> deleteAllPatients() {
    // try {
    // UserRepository.deleteAll();
    // return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    // } catch (Exception e) {
    // return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    // }

    // }

}