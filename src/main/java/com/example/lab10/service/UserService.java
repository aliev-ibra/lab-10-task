package com.example.lab10.service;

import com.example.lab10.model.User;
import com.example.lab10.repository.UserRepository;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserService {

    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public User createUser(@NonNull User user) {
        var savedUser = userRepository.save(user);

        // Dead code removed: Spring Data JPA never returns null from save()
        return savedUser;


    }

    public boolean authenticate(String email, String password) {
        Optional<User> userOptional = userRepository.findByEmail(email);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            return user.getPassword().equals(password);
        }
        return false;
    }
}
