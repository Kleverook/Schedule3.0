package com.schedule.system.database;

import com.schedule.system.oreluniver.DivisionList;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DatabaseConnection {
    //  Database credentials
    static final String DB_URL = "jdbc:postgresql://127.0.0.1:5432/postgres";
    static final String USER = "postgres";
    static final String PASS = "0000";
    Connection c;
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
    public AuthPerson findLoginKey(List<AuthPerson> personList, String login_key){
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
