package com.schedule.system.oreluniver;

import java.time.LocalDateTime;
import java.util.Calendar;
import java.util.Date;

public class NumberWeak {
    int computed, numberWeak;
    private long computedMills, numberWeakMills;

    public NumberWeak(int computed) {
        Date date = new Date();
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        int dayOfWeek = c.get(Calendar.DAY_OF_WEEK) - 1;
        if (dayOfWeek == 0) {
            dayOfWeek = 7;
        }

        LocalDateTime localDate = LocalDateTime.now();
        this.computed = computed;
        this.computedMills = System.currentTimeMillis();
        this.numberWeak = computed;
        this.numberWeakMills = computedMills + 86400000 - 86400000 * dayOfWeek;
        this.numberWeakMills = (numberWeakMills - (-180 * 60000)) - (3600 * localDate.getHour() + 60 * localDate.getMinute() + (1 * localDate.getSecond())) * 1000;
    }

    public int getNumberWeak() {
        return numberWeak;
    }

    public long numberWeakMills() {
        return numberWeakMills;
    }

    public void setNumberWeak(int numberWeak) {
        this.numberWeak = numberWeak;
        this.numberWeakMills = numberWeakMills + (numberWeak - this.computed) * 7 * 24 * 60 * 60 * 60 * 1000;
    }
}
