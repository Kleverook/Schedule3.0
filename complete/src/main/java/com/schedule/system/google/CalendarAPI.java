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
import com.google.api.services.calendar.model.Event;
import com.google.api.services.calendar.model.EventAttendee;
import com.google.api.services.calendar.model.EventDateTime;
import com.google.api.services.calendar.model.EventReminder;
import sun.reflect.generics.scope.Scope;

import java.io.*;
import java.security.GeneralSecurityException;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class CalendarAPI {
    private static final List<String> SCOPES = Collections.singletonList(CalendarScopes.CALENDAR);
    private static final String APPLICATION_NAME = "CalendarAPI";

    private final JsonFactory JSON_FACTORY = JacksonFactory.getDefaultInstance();
    private NetHttpTransport HTTP_TRANSPORT;
    private String REDIRECT_URL;

    private GoogleClientSecrets clientSecret;
    private GoogleAuthorizationCodeFlow flow;
    private Credential credential;
    private Calendar service;

    private String accessToken = null;

    public CalendarAPI(String clientSecretFilePath, String redirectURL) throws IOException, GeneralSecurityException {
        HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
        clientSecret = getClientSecretFromFile(clientSecretFilePath);
        flow = getFlow(clientSecret);
        REDIRECT_URL = redirectURL;
    }

    public CalendarAPI(String redirectURL) throws IOException, GeneralSecurityException {
        HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
        clientSecret = getClientSecretFromFile("/credentials.json");
        flow = getFlow(clientSecret);
        REDIRECT_URL = redirectURL;
    }

    public CalendarAPI() throws IOException, GeneralSecurityException {
        HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
        clientSecret = getClientSecretFromFile("/credentials.json");
        flow = getFlow(clientSecret);
        REDIRECT_URL = "http://127.0.0.1:8080";
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

    public void createService(String code) throws IOException {
        GoogleTokenResponse response = flow.newTokenRequest(code).setRedirectUri(REDIRECT_URL)
                .execute();
        flow.getTokenServerEncodedUrl();
        credential = new GoogleCredential.Builder()
                .setTransport(HTTP_TRANSPORT)
                .setJsonFactory(JSON_FACTORY)
                .setClientSecrets(flow.getClientId(), clientSecret.getDetails().getClientSecret())
                .build().setFromTokenResponse(response);
        service = new Calendar.Builder(HTTP_TRANSPORT, JSON_FACTORY, credential)
                .setApplicationName(APPLICATION_NAME).build();
        accessToken = credential.getAccessToken();
    }

    public String getAccessToken() {
        return accessToken;
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

        service.events().insert("primary", event).execute();
    }

    public static void main(String... args) throws IOException, GeneralSecurityException {
        CalendarAPI test = new CalendarAPI("/credentials.json", "http://127.0.0.1:8000");
        System.out.println(test.getAuthUrl());

        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
        System.out.println("code");
        String code = in.readLine();
        test.createService(code);
        test.createEvent(
                "Разработка платформенных и кросплатформенных киберфизических систем",
                "Наугорское ш., 29, Орёл, Орловская обл., 302020",
                "Кибернетические и киберфизические системы (лаб)\\nКорпус 11, аудитория 227\\nВетров А.С. http://oreluniver.ru/employee/7251\\n(создано при промощи приложения)",
                new DateTime("2020-10-14T15:30:00-00:00"),
                new DateTime("2020-10-14T17:10:00-00:00")
        );
    }
}
