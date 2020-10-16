package com.schedule.system.google;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.googleapis.auth.oauth2.*;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpExecuteInterceptor;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.client.util.DateTime;
import com.google.api.services.calendar.Calendar;
import com.google.api.services.calendar.CalendarRequestInitializer;
import com.google.api.services.calendar.CalendarScopes;
import com.google.api.services.calendar.model.*;
import com.google.gson.Gson;
import com.schedule.system.database.DatabaseConnection;
import sun.reflect.generics.scope.Scope;

import java.io.*;
import java.security.GeneralSecurityException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

class AccessObject {
    public String accessToken;
    public String refreshToken;
    public Long expiresInSeconds;
    public Long expirationTimeMilliseconds;
}

public class CalendarAPI {
    private static final List<String> SCOPES = Collections.singletonList(CalendarScopes.CALENDAR);
    private static final String APPLICATION_NAME = "CalendarAPI";

    private final JsonFactory JSON_FACTORY = JacksonFactory.getDefaultInstance();
    private final NetHttpTransport HTTP_TRANSPORT;
    private final String REDIRECT_URL;

    private final GoogleClientSecrets clientSecret;
    private final GoogleAuthorizationCodeFlow flow;
    private Credential credential;
    private Calendar service;

    private String calendarId = "primary";

    private AccessObject accessObject;

    public AccessObject getAccessObject() {
        return accessObject;
    }

    public String getAccessObjectJson() {
        Gson gson = new Gson();
        return gson.toJson(accessObject);
    }

    public void setAccessObject(String accessToken, String refreshToken, Long expiresInSeconds, Long expirationTimeMilliseconds) {
        accessObject.accessToken = accessToken;
        accessObject.refreshToken = refreshToken;
        accessObject.expiresInSeconds = expiresInSeconds;
        accessObject.expirationTimeMilliseconds = expirationTimeMilliseconds;
    }

    public void setAccessObjectJson(String json) {
        Gson gson = new Gson();
        AccessObject tempAccessObject = gson.fromJson(json, AccessObject.class);
        accessObject.accessToken = tempAccessObject.accessToken;
        accessObject.refreshToken = tempAccessObject.refreshToken;
        accessObject.expiresInSeconds = tempAccessObject.expiresInSeconds;
        accessObject.expirationTimeMilliseconds = tempAccessObject.expirationTimeMilliseconds;
    }

    public String getCalendarId() {
        return calendarId;
    }

    public void setCalendarId(String calendarId) {
        this.calendarId = calendarId;
    }

    public CalendarAPI(String clientSecretFilePath, String redirectURL) throws IOException, GeneralSecurityException {
        HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
        clientSecret = getClientSecretFromFile(clientSecretFilePath);
        flow = getFlow(clientSecret);
        REDIRECT_URL = redirectURL;
        accessObject = new AccessObject();
    }

    public CalendarAPI(String redirectURL) throws IOException, GeneralSecurityException {
        HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
        clientSecret = getClientSecretFromFile("/system/credentials.json");
        flow = getFlow(clientSecret);
        REDIRECT_URL = redirectURL;
        accessObject = new AccessObject();
    }

    public CalendarAPI() throws IOException, GeneralSecurityException {
        HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
        clientSecret = getClientSecretFromFile("/system/credentials.json");
        flow = getFlow(clientSecret);
        REDIRECT_URL = "http://127.0.0.1:8080";
        accessObject = new AccessObject();
    }

    private GoogleClientSecrets getClientSecretFromFile(String clientSecretFilePath) throws IOException {
        InputStream in = CalendarAPI.class.getResourceAsStream(clientSecretFilePath);
        if (in == null) {
            throw new FileNotFoundException("Resource not found: " + clientSecretFilePath);
        }
        return GoogleClientSecrets.load(JSON_FACTORY, new InputStreamReader(in));
    }

    private GoogleAuthorizationCodeFlow getFlow(GoogleClientSecrets clientSecrets) {
        return new GoogleAuthorizationCodeFlow.Builder(
                HTTP_TRANSPORT, JSON_FACTORY, clientSecrets, SCOPES)
                .setAccessType("offline")
                .build();
    }

    public String getAuthUrl() {
        GoogleAuthorizationCodeRequestUrl url = new GoogleAuthorizationCodeRequestUrl(
                flow.getAuthorizationServerEncodedUrl(),
                flow.getClientId(),
                REDIRECT_URL,
                flow.getScopes())
                .setAccessType(flow.getAccessType())
                .setApprovalPrompt(flow.getApprovalPrompt());
        return url.toString();
    }

    public void createServiceFromCode(String code) throws IOException {
        GoogleTokenResponse response = flow.newTokenRequest(code).setRedirectUri(REDIRECT_URL)
                .execute();
        credential = new GoogleCredential.Builder()
                .setTransport(HTTP_TRANSPORT)
                .setJsonFactory(JSON_FACTORY)
                .setClientSecrets(flow.getClientId(), clientSecret.getDetails().getClientSecret())
                .build().setFromTokenResponse(response);
        service = new Calendar.Builder(HTTP_TRANSPORT, JSON_FACTORY, credential)
                .setApplicationName(APPLICATION_NAME).build();

        accessObject.accessToken = credential.getAccessToken();
        accessObject.refreshToken = credential.getRefreshToken();
        accessObject.expiresInSeconds = credential.getExpiresInSeconds();
        accessObject.expirationTimeMilliseconds = credential.getExpirationTimeMilliseconds();
    }

    public void createServiceFromAccessObject() throws IOException {
        credential = new GoogleCredential.Builder()
                .setTransport(HTTP_TRANSPORT)
                .setJsonFactory(JSON_FACTORY)
                .setClientSecrets(flow.getClientId(), clientSecret.getDetails().getClientSecret())
                .build()
                .setAccessToken(accessObject.accessToken)
                .setRefreshToken(accessObject.refreshToken)
                .setExpiresInSeconds(accessObject.expiresInSeconds)
                .setExpirationTimeMilliseconds(accessObject.expirationTimeMilliseconds);
        service = new Calendar.Builder(HTTP_TRANSPORT, JSON_FACTORY, credential)
                .setApplicationName(APPLICATION_NAME).build();
    }

    public void updateAccessObject() {
        if (!accessObject.accessToken.equals(credential.getAccessToken())) {
            accessObject.accessToken = credential.getAccessToken();
        }
        if (!accessObject.refreshToken.equals(credential.getRefreshToken())) {
            accessObject.refreshToken = credential.getRefreshToken();
        }
        if (!accessObject.expiresInSeconds.equals(credential.getExpiresInSeconds())) {
            accessObject.expiresInSeconds = credential.getExpiresInSeconds();
        }
        if (!accessObject.expirationTimeMilliseconds.equals(credential.getExpirationTimeMilliseconds())) {
            accessObject.expirationTimeMilliseconds = credential.getExpirationTimeMilliseconds();
        }
    }

    public void createEvent(String summary, String location, String description, DateTime startEvent, DateTime endEvent) throws IOException {
        Event event = new Event()
                .setSummary(summary)
                .setLocation(location)
                .setDescription(description);

        EventDateTime start = new EventDateTime()
                .setDateTime(startEvent);
        event.setStart(start);

        EventDateTime end = new EventDateTime()
                .setDateTime(endEvent);
        event.setEnd(end);

        EventReminder[] reminderOverrides = new EventReminder[]{
                new EventReminder().setMethod("email").setMinutes(1 * 60),
                new EventReminder().setMethod("popup").setMinutes(15),
        };
        Event.Reminders reminders = new Event.Reminders()
                .setUseDefault(false)
                .setOverrides(Arrays.asList(reminderOverrides));
        event.setReminders(reminders);

        service.events().insert(calendarId, event).execute();
    }

    public ArrayList<Event> getEvents(int max, DateTime startTime, DateTime endTime) throws IOException {
        ArrayList<Event> result = new ArrayList<Event>();
        Events events = service.events().list(calendarId)
                .setMaxResults(max)
                .setTimeMin(startTime)
                .setTimeMax(endTime)
                .setOrderBy("startTime")
                .setSingleEvents(true)
                .execute();
        List<Event> events_list = events.getItems();
        if (!events_list.isEmpty()) {
            for (Event event : events_list) {
                if (event.getDescription() != null) {
                    if (event.getDescription().endsWith("(" + APPLICATION_NAME + ")")) {
                        result.add(event);
                    }
                }
            }
        }
        return result;
    }

    public void deleteEvents(List<Event> events) throws IOException {
        if (!events.isEmpty()) {
            for (Event event : events) {
                service.events().delete(calendarId, event.getId()).execute();
            }
        }
    }

    public void printEvents(List<Event> events) {
        if (events.isEmpty()) {
            System.out.println("Not events");
        } else {
            for (Event event : events) {
                DateTime start = event.getStart().getDateTime();
                if (start == null) {
                    start = event.getStart().getDate();
                }
                System.out.printf("%s %s (%s)\n", event.getId(), event.getSummary(), start);
            }
        }
    }

    public void spam() throws IOException, GeneralSecurityException, SQLException {
        CalendarAPI test = new CalendarAPI("/system/credentials.json", "http://127.0.0.1:8000");

        DatabaseConnection databaseConnection = new DatabaseConnection();
        databaseConnection.connectionDB();
        List<People> peoples = databaseConnection.getPeople();

        for (int i=0; i<peoples.size(); i++) {
            String accessObject = peoples.get(i).getGoogle_calendar_key();
            test.setAccessObjectJson(accessObject);
            test.createServiceFromAccessObject();
            List<Event> events = test.getEvents(
                    100,
                    new DateTime("2020-10-12T00:30:00-00:00"),
                    new DateTime("2020-10-18T15:30:00-00:00")
            );
            test.deleteEvents(events);
            List<GoogleSchedule> googleSchedules = databaseConnection.getSchedule(peoples.get(i).getId_person());
            for (int j=0;j<googleSchedules.size();j++){
                test.createEvent(
                    googleSchedules.get(j).getTitle_subject(),
                    googleSchedules,
                    "asdfghjk (CalendarAPI)",
                    new DateTime("2020-10-14T15:30:00-00:00"),
                    new DateTime("2020-10-14T17:10:00-00:00")
            );


            }
            updateAccessObject();
            databaseConnection.setGoogleCalendarKey(peoples.get(i).getLogin_key(),getAccessObjectJson());

        }


//        for (int i = 0; i<googleSchedules.size(); i ++){
//            String accessObject = googleSchedules.get(i).getGoogle_calendar_key();
//            test.setAccessObjectJson(accessObject);
//            test.createServiceFromAccessObject();
//
//            List<Event> events = test.getEvents(
//                    100,
//                    new DateTime("2020-10-12T00:30:00-00:00"),
//                    new DateTime("2020-10-18T15:30:00-00:00")
//            );
//            test.printEvents(events);
//            test.deleteEvents(events);
//
//            test.createEvent(
//                    "Разработка платформенных и кросплатформенных киберфизических систем",
//                    "Наугорское ш., 29, Орёл, Орловская обл., 302020",
//                    "asdfghjk (CalendarAPI)",
//                    new DateTime("2020-10-14T15:30:00-00:00"),
//                    new DateTime("2020-10-14T17:10:00-00:00")
//            );
    }

    public static void main(String... args) throws IOException, GeneralSecurityException {
        CalendarAPI test = new CalendarAPI("/system/credentials.json", "http://127.0.0.1:8000");
        System.out.println(test.getAuthUrl());

//        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
//        System.out.println("code");
//        String code = in.readLine();
//        test.createServiceFromCode(code);
//        System.out.println(test.getAccessObjectJson());
        test.createEvent(
                "Разработка платформенных и кросплатформенных киберфизических систем",
                "Наугорское ш., 29, Орёл, Орловская обл., 302020",
                "Кибернетические и киберфизические системы (лаб)\\nКорпус 11, аудитория 227\\nВетров А.С. http://oreluniver.ru/employee/7251\\n(создано при промощи приложения)",
                new DateTime("2020-10-14T15:30:00-00:00"),
                new DateTime("2020-10-14T17:10:00-00:00")
        );

        String accessObject = "{\"accessToken\":\"ya29.a0AfH6SMAsb8ya8RDk0frfBOtbofd8115fyYj8Mrmd4m-RYwvaqE0MHSUQByY_UpQZZCVrizkIv2oqx7Q2Qf1ELL1C5moyz0rud5aahydfLiTMbEAewhcX2xn75cLXHlycrlaMPwK08BDAEviSYX-yyD1O_0bOqfu6IbY\",\"refreshToken\":\"1//0cwtHsBVdhL0zCgYIARAAGAwSNwF-L9Irvra0zLls2YuEXnFPnbWPqDZ9Lj3wcbP1hgqUdtD24NDf08uM6m-H1_z2xb6fMYrj7h4\",\"expiresInSeconds\":3598,\"expirationTimeMilliseconds\":1602784451716}";
        test.setAccessObjectJson(accessObject);
        test.createServiceFromAccessObject();

        List<Event> events = test.getEvents(
                100,
                new DateTime("2020-10-12T00:30:00-00:00"),
                new DateTime("2020-10-18T15:30:00-00:00")
        );
        test.printEvents(events);
        test.deleteEvents(events);

        test.createEvent(
                "Разработка платформенных и кросплатформенных киберфизических систем",
                "Наугорское ш., 29, Орёл, Орловская обл., 302020",
                "asdfghjk (CalendarAPI)",
                new DateTime("2020-10-14T15:30:00-00:00"),
                new DateTime("2020-10-14T17:10:00-00:00")
        );
    }
}
