package com.schedule.system.google;

public class GoogleSchedule {

    int  id_group, id_corpus, number_lesson;
    String  title_subject, type_lesson, date_lesson,special,number_room,adress, t_start, t_stop;

    public void setAdress(String adress) {
        this.adress = adress;
    }

    public String getAdress() {
        return adress;
    }

    public String getT_start() {
        return t_start;
    }

    public String getT_stop() {
        return t_stop;
    }

    public void setT_start(String t_start) {
        this.t_start = t_start;
    }

    public void setT_stop(String t_stop) {
        this.t_stop = t_stop;
    }

    public void setDate_lesson(String date_lesson) {
        this.date_lesson = date_lesson;
    }

    public void setSpecial(String special) {
        this.special = special;
    }

    public void setType_lesson(String type_lesson) {
        this.type_lesson = type_lesson;
    }

    public void setId_corpus(int id_corpus) {
        this.id_corpus = id_corpus;
    }

    public void setId_group(int id_group) {
        this.id_group = id_group;
    }

    public void setNumber_lesson(int number_lesson) {
        this.number_lesson = number_lesson;
    }

    public void setNumber_room(String number_room) {
        this.number_room = number_room;
    }

    public void setTitle_subject(String title_subject) {
        this.title_subject = title_subject;
    }

    public int getId_corpus() {
        return id_corpus;
    }

    public int getId_group() {
        return id_group;
    }

    public String getSpecial() {
        return special;
    }

    public int getNumber_lesson() {
        return number_lesson;
    }

    public String getDate_lesson() {
        return date_lesson;
    }

    public String getNumber_room() {
        return number_room;
    }

    public String getTitle_subject() {
        return title_subject;
    }

    public String getType_lesson() {
        return type_lesson;
    }
}
