package com.schedule.web;


import com.schedule.system.AuthPerson;
import com.schedule.system.DatabaseConnection;
import com.google.gson.Gson;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

class StateLogin {
    String loginKey, error;
    boolean state;


    public StateLogin(boolean state, String loginKey) {
        this.loginKey = loginKey;
        this.state = state;
    }

    public StateLogin() {
        this.loginKey = "";
        this.state = false;
    }

    public StateLogin(boolean b) {
        this.state = b;
    }
}

class RequestApi {
    String password = "", login = "", login_key = "", name = "", surname = "", api_method;
}

@RestController
public class RequestController {
//    @RequestMapping("/api")
//    public String checkUser(@RequestParam(name = "login", required = true) String login,
//                            @RequestParam(name = "password", required = true) String password,
//                            Model model) throws Exception {
//        System.out.println(login);
//        System.out.println(password);
//
//        Gson gson = new Gson();
//
//        DatabaseConnection dataBase = new DatabaseConnection();
//        dataBase.connectionDB();
//        List<AuthPerson> person = dataBase.getAuthPerson();
//        AuthPerson user = dataBase.findPerson(person, login, password);
//
//        if (user != null) {
//            return gson.toJson(new StateLogin(true, user.getLogin_key()));
//        } else {
//
//            return gson.toJson(new StateLogin(false, ""));
//        }
//    }

    @RequestMapping("/api")
    @ResponseBody
    public String API(@RequestBody String request) throws SQLException {

        Gson gson = new Gson();
        RequestApi json = new Gson().fromJson(request, RequestApi.class);

        System.out.println(json.api_method);

        if (json.api_method.equals("check_user")) {
            System.out.println(json.login);
            System.out.println(json.password);

            DatabaseConnection dataBase = new DatabaseConnection();
            dataBase.connectionDB();
            List<AuthPerson> person = dataBase.getAuthPerson();

            AuthPerson user = dataBase.findPerson(person, json.login, json.password);

            if (user != null) {
                return gson.toJson(new StateLogin(true, user.getLogin_key()));
            } else {

                return gson.toJson(new StateLogin(false, ""));
            }
        } else if (json.api_method.equals("check_login")) {
            System.out.println(json.login);


            DatabaseConnection dataBase = new DatabaseConnection();
            dataBase.connectionDB();
            List<AuthPerson> person = dataBase.getAuthPerson();
            boolean user = dataBase.findLogin(person, json.login);

            if (user != true) {
                System.out.println("true");
                return gson.toJson(new StateLogin(true));
            } else {

                return gson.toJson(new StateLogin(false));
            }

        } else if (json.api_method.equals("select_database")) {
            DatabaseConnection dataBase = new DatabaseConnection();
            dataBase.connectionDB();
            List<AuthPerson> person = dataBase.getAuthPerson();
            boolean user = dataBase.findLogin(person, json.login);

            if (user != true) {
                AuthPerson newPerson = new AuthPerson();
                newPerson.setLogin(json.login);
                newPerson.setPassword(json.password);
                newPerson.setName(json.name);
                newPerson.setSurname(json.surname);
                newPerson.setId_role(2);

                System.out.println(newPerson.toString());
                dataBase.setAuthPerson(newPerson);
                System.out.println("true");
                person =dataBase.getAuthPerson();
                AuthPerson newUser =dataBase.findPerson(person, json.login, json.password);
                return gson.toJson(new StateLogin(true, newUser.getLogin_key()));
            } else {

                return gson.toJson(new StateLogin(false, "Имя пользователя уже существует!"));
            }

        } else {
            return gson.toJson(new StateLogin());
        }
    }
}
