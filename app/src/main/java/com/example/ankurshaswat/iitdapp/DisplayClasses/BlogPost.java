package com.example.ankurshaswat.iitdapp.DisplayClasses;

import com.google.firebase.database.IgnoreExtraProperties;

@IgnoreExtraProperties
public class BlogPost {

    public String title;
    public String time;
    public String image;
    private String uid;
    private String author;
    private String website;
    private String body;
    private String postURL;
    private String category;

    public BlogPost() {
        // Default constructor required for calls to DataSnapshot.getValue(Post.class)
    }

    public String getTitle() {
        return title;
    }

    public String getImage() {
        return image;
    }

    public String getBody() {
        return body;
    }

    public String getUid() {
        return uid;
    }

    public String getAuthor() {
        return author;
    }

    public String getTime() {
        return time;
    }

    public String getWebsite() {
        return website;
    }

    public String getPostURL() {
        return postURL;
    }

    public String getCategory() {
        return category;
    }

}
