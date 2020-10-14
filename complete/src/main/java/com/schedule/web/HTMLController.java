package com.schedule.web;

import com.schedule.system.database.AuthPerson;
import com.schedule.system.database.DatabaseConnection;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.util.List;


@Controller
public class HTMLController {

    @GetMapping("/greeting")
    public String greeting(@RequestParam(name="name", required=false, defaultValue="World") String name, Model model) {
        model.addAttribute("name", name);
        return "greeting";
    }
    @GetMapping("/login")
    public String login(@CookieValue(value = "login_key", defaultValue = "") String login_key) throws SQLException {
        DatabaseConnection dataBase = new DatabaseConnection();
        dataBase.connectionDB();
        List<AuthPerson> person = dataBase.getAuthPerson();
        AuthPerson user = dataBase.findLoginKey(person, login_key);

        if (user!=null){
            return "redirect:/";}

        else {return "login";}
    }
    @GetMapping("/register")
    public String register(@CookieValue(value = "login_key", defaultValue = "") String login_key) throws SQLException {

        DatabaseConnection dataBase = new DatabaseConnection();
        dataBase.connectionDB();
        List<AuthPerson> person = dataBase.getAuthPerson();
        AuthPerson user = dataBase.findLoginKey(person, login_key);
        if (user!=null){return "redirect:/";}

        else {return "register";}
    }
    @GetMapping("/")
    public String index(
            @CookieValue(value = "login_key", defaultValue = "") String login_key,
            Model model) throws SQLException {
        DatabaseConnection dataBase = new DatabaseConnection();
        dataBase.connectionDB();
        List<AuthPerson> person = dataBase.getAuthPerson();
        AuthPerson user = dataBase.findLoginKey(person, login_key);
        if (user!=null){

            model.addAttribute("name", user.getName());
            model.addAttribute("surname", user.getSurname());
            return "index";}

        else {return "login";}
    }


}