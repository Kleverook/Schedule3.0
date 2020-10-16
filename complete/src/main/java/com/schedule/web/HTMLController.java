package com.schedule.web;

import com.google.api.client.util.DateTime;
import com.schedule.system.database.AuthPerson;
import com.schedule.system.database.DatabaseConnection;
import com.schedule.system.google.CalendarAPI;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.sql.SQLException;
import java.util.List;


@Controller
public class HTMLController {

    @GetMapping("/greeting")
    public String greeting(@RequestParam(name = "name", required = false, defaultValue = "World") String name, Model model) {
        model.addAttribute("name", name);
        return "greeting";
    }

    @GetMapping("/login")
    public String login(@CookieValue(value = "login_key", defaultValue = "") String login_key) throws SQLException {
        DatabaseConnection dataBase = new DatabaseConnection();
        dataBase.connectionDB();
        List<AuthPerson> person = dataBase.getAuthPerson();
        AuthPerson user = dataBase.findLoginKey(person, login_key);

        if (user != null) {
            return "redirect:/";
        } else {
            return "login";
        }
    }

    @GetMapping("/register")
    public String register(@CookieValue(value = "login_key", defaultValue = "") String login_key) throws SQLException {

        DatabaseConnection dataBase = new DatabaseConnection();
        dataBase.connectionDB();
        List<AuthPerson> person = dataBase.getAuthPerson();
        AuthPerson user = dataBase.findLoginKey(person, login_key);
        if (user != null) {
            return "redirect:/";
        } else {
            return "register";
        }
    }

    @GetMapping("/")
    public String index(
            @CookieValue(value = "login_key", defaultValue = "") String login_key,
            Model model) throws SQLException, IOException, GeneralSecurityException {
        DatabaseConnection dataBase = new DatabaseConnection();
        dataBase.connectionDB();
        List<AuthPerson> person = dataBase.getAuthPerson();
        AuthPerson user = dataBase.findLoginKey(person, login_key);
        if (user != null) {
            CalendarAPI calendarAPI = new CalendarAPI("http://127.0.0.1:8080/google_auth?id=" + user.getId());
            model.addAttribute("name", user.getName());
            model.addAttribute("surname", user.getSurname());
            model.addAttribute("auth_url", calendarAPI.getAuthUrl());
            return "index";
        } else {
            return "login";
        }
    }

    @GetMapping("/google_auth")
    public String google_auth(
            @CookieValue(value = "login_key", defaultValue = "") String login_key,
            @RequestParam(name = "id", required = false, defaultValue = "") String id,
            @RequestParam(name = "code", required = false, defaultValue = "") String code) throws SQLException, IOException, GeneralSecurityException {

        System.out.println(id);
        System.out.println(code);
        CalendarAPI calendarAPI = new CalendarAPI("http://127.0.0.1:8080/google_auth?id=" + id);
        calendarAPI.createServiceFromCode(code);
        String token = calendarAPI.getAccessObjectJson();

        System.out.println(token);
        DatabaseConnection dataBase = new DatabaseConnection();
        dataBase.connectionDB();

        dataBase.setGoogleCalendarKey(login_key, token);
        return "redirect:/";
    }

}