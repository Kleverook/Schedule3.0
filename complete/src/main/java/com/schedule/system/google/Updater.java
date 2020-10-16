package com.schedule.system.google;

import com.schedule.system.database.DatabaseConnection;
import com.schedule.system.oreluniver.DivisionList;
import com.schedule.system.oreluniver.NumberWeak;
import com.schedule.system.oreluniver.ScheduleConnectionStudent;
import com.schedule.system.oreluniver.ScheduleList;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Updater {
    public static void main(String... args) throws Exception {
        while (true) {
            DatabaseConnection dataBase = new DatabaseConnection();
            dataBase.connectionDB();
            List id_group = dataBase.getListPersonGroup();
            List<ScheduleList> scheduleLists = new ArrayList<>();
            NumberWeak tmpNumberWeak = new NumberWeak(0);
            ScheduleConnectionStudent connectionStudent = new ScheduleConnectionStudent();

            System.out.println(id_group);
            for (int i = 0; i < id_group.size(); i++) {
                System.out.println(id_group.get(i));
                List<ScheduleList> scheduleListsTmp = connectionStudent.getShaduleList(id_group.get(i), tmpNumberWeak.numberWeakMills());
                for (int j = 0; j < scheduleListsTmp.size(); j++) {
                    scheduleLists.add(scheduleListsTmp.get(j));
                }
            }
            System.out.println(dataBase.c);

            dataBase.setSchedule(scheduleLists);
            System.out.println(dataBase.c);

            //dataBase.getDivisionList();
            CalendarAPI g = new CalendarAPI();
            System.out.println(dataBase.c);
            g.spam();

            Thread.sleep(200000);
        }
    }
}
