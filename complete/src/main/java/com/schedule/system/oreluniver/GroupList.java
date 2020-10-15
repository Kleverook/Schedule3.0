package com.schedule.system.oreluniver;

public class GroupList {
    private String title, Codedirection, levelEducation, short_title;
    private int idgruop, course, id_division;

    public int getIdgruop() {
        return this.idgruop;
    }

    public String getTitle() {
        return this.title;
    }

    public String getCodedirection() {
        return Codedirection;
    }

    public String getLevelEducation() {
        return levelEducation;
    }

    public int getCourse() {
        return course;
    }

    public int getId_division() {
        return id_division;
    }

    public void setCodedirection(String codedirection) {
        Codedirection = codedirection;
    }

    public void setCourse(int course) {
        this.course = course;
    }

    public void setIdgruop(int idgruop) {
        this.idgruop = idgruop;
    }

    public void setId_division(int id_division) {
        this.id_division = id_division;
    }

    public void setLevelEducation(String levelEducation) {
        this.levelEducation = levelEducation;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getShort_title() {
        return short_title;
    }

    public void setShort_title(String short_title) {
        this.short_title = short_title;
    }
}
