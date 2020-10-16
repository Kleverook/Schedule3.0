package com.schedule.system.oreluniver;

import org.jetbrains.annotations.NotNull;

import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

public class ScheduleList  {
    String TitleSubject, TypeLesson, DateLesson, Korpus,
            NumberRoom, special, title, Family, Name, SecondName,
            link, pass, zoom_link, zoom_password;
    int id_cell, idGruop, NumberSubGruop, kurs, NumberLesson, DayWeek, employee_id;

    public String getTitleSubject() {
        return this.TitleSubject;
    }

    public String getTypeLesson() {
        return this.TypeLesson;
    }

    public int getNumberLesson() {
        return this.NumberLesson;
    }

    public int getDayWeek() {
        return this.DayWeek;
    }

    public String getDateLesson() {
        return this.DateLesson;
    }

    public String getKorpus() {
        return this.Korpus;
    }

    public String getNumberRoom() {
        return this.NumberRoom;
    }

    public int getEmployee_id() {
        return employee_id;
    }

    public String getFamily() {
        return Family;
    }

    public String getName() {
        return Name;
    }

    public String getSpecial() {
        return special;
    }

    public String getTitle() {
        return title;
    }

    public String getSecondName() {
        return SecondName;
    }

    public void setDateLesson(String dateLesson) {
        DateLesson = dateLesson;
    }

    public int getId_cell() {
        return id_cell;
    }

    public int getKurs() {
        return kurs;
    }

    public int getIdGruop() {
        return idGruop;
    }



    public String getLink() {
        return link;
    }


    public String getPass() {
        return pass;
    }

    public String getZoom_link() {
        return zoom_link;
    }


    public String getZoom_password() {
        return zoom_password;
    }

    public void setZoom_password(String zoom_password) {
        this.zoom_password = zoom_password;
    }

    public int getNumberSubGruop() {
        return NumberSubGruop;
    }


}





