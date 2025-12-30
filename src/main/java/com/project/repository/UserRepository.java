package com.project.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.project.model.User;

public interface UserRepository extends JpaRepository<User, Long> {

    // For Login
    User findByEmailAndPassword(String email, String password);

    // For checking existing user
    User findByEmail(String email);
}

