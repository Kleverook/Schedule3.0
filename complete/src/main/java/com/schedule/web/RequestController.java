package com.schedule.web;


import com.schedule.system.database.AuthPerson;
import com.schedule.system.database.DatabaseConnection;
import com.google.gson.Gson;
import com.schedule.system.oreluniver.DivisionList;
import com.schedule.system.oreluniver.ScheduleConnectionStudent;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
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

    public String API(@RequestBody String request) throws Exception {

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


        } else if (json.api_method.equals("get_division")){
            System.out.println("OK");
            DatabaseConnection dataBase = new DatabaseConnection();
            dataBase.connectionDB();
            List<DivisionList> divisionLists = new ScheduleConnectionStudent().getDivisionList();
            System.out.println(divisionLists);
            dataBase.setDivisionList(divisionLists);

            return gson.toJson(divisionLists);
        }
        else {
            return gson.toJson(new StateLogin());
        }
    }
}
