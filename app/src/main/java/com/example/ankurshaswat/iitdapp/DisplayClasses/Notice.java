package com.example.ankurshaswat.iitdapp.DisplayClasses;

public class Notice {
    public String date;
    public String link;
    public String title;

    public Notice() {
        // Default constructor required for calls to DataSnapshot.getValue(Post.class)
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
