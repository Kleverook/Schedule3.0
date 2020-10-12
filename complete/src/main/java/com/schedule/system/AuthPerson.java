package com.schedule.system;

public class AuthPerson {
    int id, id_role;
    String login, password, name, surname, google_calendar_key, phone_number, login_key;

    public int getId() {
        return id;
    }

    public String getLogin_key() {
        return login_key;
    }

    public String getLogin() {
        return login;
    }

    public String getPassword() {
        return password;
    }

    public String getName() {
        return name;
    }

    public String getGoogle_calendar_key() {
        return google_calendar_key;
    }

    public String getSurname() {
        return surname;
    }

    public int getId_role() {
        return id_role;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public void setId_role(int id_role) {
        this.id_role = id_role;
    }

    public void setGoogle_calendar_key(String google_calendar_key) {
        this.google_calendar_key = google_calendar_key;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public String getPhone_number() {
        return phone_number;
    }

}
