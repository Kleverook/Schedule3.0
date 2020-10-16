package com.schedule.system.database;

import com.schedule.system.google.GoogleSchedule;
import com.schedule.system.google.People;
import com.schedule.system.oreluniver.DivisionList;
import com.schedule.system.oreluniver.GroupList;
import com.schedule.system.oreluniver.ScheduleList;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DatabaseConnection {
    //  Database credentials
    static final String DB_URL = "jdbc:postgresql://0.0.0.0:5432/postgres";
    static final String USER = "postgres";
    static final String PASS = "0000";
    public Connection c;
    Statement stmt;
    String sql;

    public void connectionDB() {
        try {
            Class.forName("org.postgresql.Driver");
            c = DriverManager.getConnection(DB_URL, USER, PASS);
            c.setAutoCommit(false);
            System.out.println("-- Opened database successfully");
            String sql;
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }
    }

    public void setAuthPerson(AuthPerson personList) throws SQLException {
        stmt = c.createStatement();
        sql = "INSERT INTO AUTH_PERSON (login, password, name, surname,id_role) VALUES ";

        System.out.println("select");
        sql += String.format("('%s', '%s', '%s', '%s', %s); ", personList.getLogin(), personList.getPassword(), personList.getName(), personList.getSurname(), 2);

//        sql = sql.substring(0, sql.length() - 2) + " ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, SHORT_TITLE = EXCLUDED.SHORT_TITLE;";
        System.out.println(sql);
        stmt.execute(sql);
        c.commit();
    }

    public List<GoogleSchedule> getSchedule(int id) throws SQLException {
        List<GoogleSchedule> googleSchedules = new ArrayList<>();

        stmt = c.createStatement();
        ResultSet rs = stmt.executeQuery(
                "select a.id_group , s.title_subject, s.type_lesson, s.id_corpus, s.date_lesson, " +
                        "s.number_lesson, s.special, s.number_room " +
                        "from list_person_group as a, auth_person as p, list_schedule as s " +
                        "where p.id = "+id+" );");

        while (rs.next()) {
            GoogleSchedule schedule = new GoogleSchedule();
            schedule.setId_group(rs.getInt("id_group"));
            schedule.setTitle_subject(rs.getString("title_subject"));
            schedule.setType_lesson(rs.getString("type_lesson"));
            schedule.setId_corpus(rs.getInt("id_corpus"));
            schedule.setDate_lesson(rs.getString("date_lesson"));
            schedule.setNumber_lesson(rs.getInt("number_lesson"));
            schedule.setSpecial(rs.getString("special"));
            schedule.setNumber_room(rs.getString("number_room"));
            googleSchedules.add(schedule);
        }
        rs.close();
        stmt.close();
        c.commit();
        return googleSchedules;
    }
    public List<People> getPeople() throws SQLException {
        List<People> peoples= new ArrayList<>();

        stmt = c.createStatement();
        ResultSet rs = stmt.executeQuery
                (" select id, google_calendar_key,login_key " +
                        "from auth_person " +
                        "where google_calendar_key is not null " +
                        "  and id in (select id_person " +
                        "             from list_person_group " +
                        "             where update = false " +
                        "             group by id_person); " );

        while (rs.next()) {
            People people = new People();
            people.setId_person(rs.getInt("id"));
            people.setGoogle_calendar_key(rs.getString("google_calendar_key"));
            people.setLogin_key(rs.getString("login_key"));

            peoples.add(people);

        }
        rs.close();
        stmt.close();
        c.commit();
        return peoples;
    }




    public void setSchedule(List<ScheduleList> scheduleList) throws SQLException {
        stmt = c.createStatement();
        sql = "INSERT INTO list_schedule (id, number_sub_gruop, title_subject, type_lesson," +
                " number_lesson, day_week, date_lesson, special, link, pass," +
                " zoom_link, zoom_password, id_corpus, id_employee, id_group, number_room) VALUES ";
        for (int i = 0; i < scheduleList.size(); i++) {
            sql += String.format("(%s, %s, '%s', '%s', %s, %s,'%s','%s','%s','%s','%s', '%s', %s, %s, %s, '%s'),",
                    scheduleList.get(i).getId_cell(), scheduleList.get(i).getNumberSubGruop(), scheduleList.get(i).getTitleSubject(),
                    scheduleList.get(i).getTypeLesson(), scheduleList.get(i).getNumberLesson(), scheduleList.get(i).getDayWeek(),
                    scheduleList.get(i).getDateLesson(), scheduleList.get(i).getSpecial(), scheduleList.get(i).getLink(),
                    scheduleList.get(i).getPass(), scheduleList.get(i).getZoom_link(), scheduleList.get(i).getZoom_password(),
                    scheduleList.get(i).getKorpus(), scheduleList.get(i).getEmployee_id(), scheduleList.get(i).getIdGruop(), scheduleList.get(i).getNumberRoom());
        }
        sql = sql.substring(0, sql.length() - 1) + " ON CONFLICT (id) DO UPDATE SET " +
                "number_sub_gruop=EXCLUDED.number_sub_gruop, " +
                "title_subject=EXCLUDED.title_subject, " +
                "type_lesson=EXCLUDED.type_lesson, " +
                "number_lesson=EXCLUDED.number_lesson, " +
                "day_week=EXCLUDED.day_week, " +
                "date_lesson=EXCLUDED.date_lesson, " +
                "special=EXCLUDED.special, " +
                "link=EXCLUDED.link, " +
                "pass=EXCLUDED.pass, " +
                "zoom_link=EXCLUDED.zoom_link, " +
                "zoom_password=EXCLUDED.zoom_password, " +
                "id_corpus=EXCLUDED.id_corpus, " +
                "id_employee=EXCLUDED.id_employee, " +
                "id_group=EXCLUDED.id_group;";
////        sql+=sql.substring(0, sql.length() - 1)+";";
        //System.out.println(sql);
        stmt.execute(sql);
        c.commit();
    }

    public void setDivisionList(List<DivisionList> divisionList) throws SQLException {
        stmt = c.createStatement();
        sql = "INSERT INTO LIST_DIVISION (ID,TITLE,SHORT_TITLE) VALUES ";
        for (int i = 0; i < divisionList.size(); i++) {
            sql += String.format("(%s, '%s', '%s'), ", divisionList.get(i).getId(), divisionList.get(i).getTitleDivision(), divisionList.get(i).getShortTitle());
        }
        sql = sql.substring(0, sql.length() - 2) + " ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, SHORT_TITLE = EXCLUDED.SHORT_TITLE;";
        System.out.println(sql);
        stmt.execute(sql);
        c.commit();

    }

    public void setGroupList(List<GroupList> groupList, int idDiv, int kurNum) throws SQLException {
        stmt = c.createStatement();

        sql = "INSERT INTO list_group (id, course, title, code, level_education, id_division) VALUES ";
        for (int i = 0; i < groupList.size(); i++) {
            sql += String.format("(%s, %s, '%s', '%s', '%s', %s), ", groupList.get(i).getIdgruop(), kurNum, groupList.get(i).getTitle(), groupList.get(i).getCodedirection(), groupList.get(i).getLevelEducation(), idDiv);
        }
        sql = sql.substring(0, sql.length() - 2) + " ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, course = EXCLUDED.course, code = EXCLUDED.code, level_education = EXCLUDED.level_education, id_division = EXCLUDED.id_division;";
        System.out.println(sql);
        stmt.execute(sql);
        c.commit();

    }

    public void setListPersonGroup(int id_person, int id_group) throws SQLException {
        stmt = c.createStatement();

        sql = "SELECT count(id)" +
                "FROM list_person_group where id_person =" + id_person + " and id_group = " + id_group + ";";
        ResultSet rs = stmt.executeQuery(sql);
        int count = 0;
        while (rs.next()) {
            count = rs.getInt("count");
        }
        System.out.println(count);

        c.commit();
        if (count == 0) {

            sql = "INSERT INTO list_person_group (id_person,id_group) VALUES ";
            sql += String.format("(%s, %s); ", id_person, id_group);
//        sql = sql.substring(0, sql.length() - 2) + " ON CONFLICT (id_group) DO UPDATE SET id_person = EXCLUDED.id_person;";
            System.out.println("sql");
            stmt.execute(sql);
            c.commit();
        }
    }

    public List<DivisionList> getDivisionList() throws SQLException {
        stmt = c.createStatement();
        List<DivisionList> divisionLists = new ArrayList<>();
        ResultSet rs = stmt.executeQuery("SELECT * FROM list_division;");
        while (rs.next()) {
            DivisionList divisionList = new DivisionList();
            divisionList.setIdDivision(rs.getInt("id"));
            divisionList.setShortTitle(rs.getString("short_title"));
            divisionList.setTitleDivision(rs.getString("title"));

            divisionLists.add(divisionList);
        }
        rs.close();
        stmt.close();
        c.commit();

        return divisionLists;
    }

    public List<GroupList> getListPersonGroup() throws SQLException {
        List listGroupId = new ArrayList<>();

        stmt = c.createStatement();
        ResultSet rs = stmt.executeQuery(
                "select a.id_group from list_person_group as a group by id_group;");

        while (rs.next()) {

            listGroupId.add(rs.getInt("id_group"));
        }
        rs.close();
        stmt.close();
        c.commit();
        return listGroupId;
    }

    public List<GroupList> getGroupList(int id) throws SQLException {
        List<GroupList> listGroup = new ArrayList<>();

        stmt = c.createStatement();
        ResultSet rs = stmt.executeQuery(
                "select s.course, s.title, s.code, s.level_education, d.short_title " +
                        "from list_person_group as a, list_group as s, list_division as d " +
                        "where s.id = a.id_group and d.id = s.id_division and a.id_person = " + id +
                        " order by a.id");

        while (rs.next()) {
            GroupList group = new GroupList();
            group.setCourse(rs.getInt("course"));
            group.setTitle(rs.getString("title"));
            group.setCodedirection(rs.getString("code"));
            group.setLevelEducation(rs.getString("level_education"));
            group.setShort_title(rs.getString("short_title"));

            listGroup.add(group);
        }
        rs.close();
        stmt.close();
        c.commit();
        return listGroup;
    }

    public List<AuthPerson> getAuthPerson() throws SQLException {


        List<AuthPerson> listPerson = new ArrayList<>();

        stmt = c.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM auth_person;");
        while (rs.next()) {
            AuthPerson person = new AuthPerson();
            person.id = rs.getInt("id");
            person.id_role = rs.getInt("id_role");
            person.login = rs.getString("login");
            person.password = rs.getString("password");
            person.name = rs.getString("name");
            person.surname = rs.getString("surname");
            person.google_calendar_key = rs.getString("google_calendar_key");
            person.phone_number = rs.getString("phone_number");
            person.login_key = rs.getString("login_key");

            listPerson.add(person);
        }
        rs.close();
        stmt.close();
        c.commit();
        return listPerson;
    }

    public void setGoogleCalendarKey(String login_key, String token) throws SQLException {
        stmt = c.createStatement();
        sql = "UPDATE auth_person set google_calendar_key=" + "'" + token + "'" + "where login_key=" + "'" + login_key + "'" + ";";
        stmt.executeUpdate(sql);
        c.commit();
        stmt.close();
    }

    public AuthPerson findPerson(List<AuthPerson> personList, String login, String password) {
        int j = -1;
        for (int i = 0; i < personList.size(); i++) {
            System.out.println(personList.get(i).login);

            System.out.println(personList.get(i).login.equals(login) && personList.get(i).password.equals(password));
            if (personList.get(i).login.equals(login) && personList.get(i).password.equals(password)) {
                j = i;
                return personList.get(i);
            }
        }
        if (j != -1) {
            return personList.get(j);
        } else return null;
    }

    public boolean findLogin(List<AuthPerson> personList, String login) {
        int j = -1;
        for (int i = 0; i < personList.size(); i++) {
            if (personList.get(i).login.equals(login)) {
                j = i;
            }
        }
        if (j != -1) {
            return true;
        } else return false;
    }

    public AuthPerson findLoginKey(List<AuthPerson> personList, String login_key) {
        int j = -1;
        for (int i = 0; i < personList.size(); i++) {
            if (personList.get(i).login_key.equals(login_key)) {
                j = i;
            }
        }
        if (j != -1) {
            return personList.get(j);
        } else return null;
    }
//    public
    //-------------- CREATE TABLE ---------------
//            stmt = c.createStatement();
//            sql = "CREATE TABLE COMPANY " +
//                    "(ID INT PRIMARY KEY     NOT NULL," +
//                    " NAME           TEXT    NOT NULL, " +
//                    " AGE            INT     NOT NULL, " +
//                    " ADDRESS        VARCHAR(50), " +
//                    " SALARY         REAL)";
//            stmt.executeUpdate(sql);
//            stmt.close();
//            c.commit();
//            System.out.println("-- Table created successfully");

    //--------------- INSERT ROWS ---------------
//            stmt = c.createStatement();
//            sql = "INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY) VALUES (201002, 'Paul', 32, 'California', 20000.00 );";
//            stmt.executeUpdate(sql);
//
//            sql = "INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY) VALUES (200101, 'Allen', 25, 'Texas', 15000.00 );";
//            stmt.executeUpdate(sql);
//
//            sql = "INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY) VALUES (310000, 'Teddy', 23, 'Norway', 20000.00 );";
//            stmt.executeUpdate(sql);
//
//            sql = "INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY) VALUES (410000, 'Mark', 25, 'Rich-Mond ', 65000.00 );";
//            stmt.executeUpdate(sql);
//
//            stmt.close();
//            c.commit();
//            System.out.println("-- Records created successfully");
//
//
////            //-------------- UPDATE DATA ------------------
////            stmt = c.createStatement();
////            sql = "UPDATE COMPANY set SALARY = 25000.00 where ID=1;";
////            stmt.executeUpdate(sql);
////            c.commit();
////            stmt.close();
////
////            System.out.println("-- Operation UPDATE done successfully");
//
//
//            //--------------- SELECT DATA ------------------
//            stmt = c.createStatement();
//            ResultSet rs = stmt.executeQuery( "SELECT * FROM COMPANY;" );
//            while ( rs.next() ) {
//                int id = rs.getInt("id");
//                String  name = rs.getString("name");
//                int age  = rs.getInt("age");
//                String  address = rs.getString("address");
//                float salary = rs.getFloat("salary");
//                System.out.println(String.format("ID=%s NAME=%s AGE=%s ADDRESS=%s SALARY=%s",id,name,age,address,salary));
//            }
//            rs.close();
//            stmt.close();
//            c.commit();
//            System.out.println("-- Operation SELECT done successfully");
//
//
//            //-------------- DELETE DATA ----------------------
//            stmt = c.createStatement();
//            sql = "DELETE from COMPANY where ID=2;";
//            stmt.executeUpdate(sql);
//            c.commit();
//            stmt.close();
//            System.out.println("-- Operation DELETE done successfully");
//
//
//            c.close();
//
//        }
//        System.out.println("-- All Operations done successfully");
//    }
}
