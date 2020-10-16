package com.schedule.system.google;

public class People {
    int id_person;
    String google_calendar_key,login_key;

    public void setLogin_key(String login_key) {
        this.login_key = login_key;
    }

    public String getLogin_key() {
        return login_key;
    }

    public void setGoogle_calendar_key(String google_calendar_key) {
        this.google_calendar_key = google_calendar_key;
    }
    public String getGoogle_calendar_key() {
        return google_calendar_key;
    }
    public int getId_person() {
        return id_person;
    }
    public void setId_person(int id_person) {
        this.id_person = id_person;
    }
}
