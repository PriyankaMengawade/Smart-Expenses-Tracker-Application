package com.project.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.project.model.User;
import com.project.repository.UserRepository;

import org.springframework.ui.Model;

@Controller
public class LoginController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/")
    public String home() {
        return "redirect:/login";
    }

    // ✅ ADD THIS
    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    @PostMapping("/registerUser")
    public String registerUser(@RequestParam String name,
                               @RequestParam String email,
                               @RequestParam String password,
                               @RequestParam Double budget,
                               Model model) {

        if (userRepository.findByEmail(email) != null) {
            model.addAttribute("msg", "Email already registered!");
            return "register";
        }

        userRepository.save(new User(name, email, password, budget));
        model.addAttribute("msg", "Registration successful. Please login.");
        return "login";
    }
    
    @PostMapping("/loginUser")
    public String loginUser(@RequestParam String email,
                            @RequestParam String password,
                            HttpSession session,
                            Model model) {

        User user = userRepository.findByEmailAndPassword(email, password);

        if (user == null) {
            model.addAttribute("msg", "Invalid Email or Password!");
            return "login";
        }

        session.setAttribute("user", user);
        session.setAttribute("uid", user.getId()); // IMPORTANT

        return "redirect:/dashboard";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
