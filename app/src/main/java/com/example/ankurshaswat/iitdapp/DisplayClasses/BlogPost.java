package com.example.ankurshaswat.iitdapp.DisplayClasses;

import com.google.firebase.database.IgnoreExtraProperties;

@IgnoreExtraProperties
public class BlogPost {

    private String author;
    private String body;
    private String category;
    public String image;
    private String postURL;
    public String time;
    public String title;
    private String uid;
    private String website;

    public BlogPost() {
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

    public void setAuthor(String author) {
        this.author = author;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public void setPostURL(String postURL) {
        this.postURL = postURL;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public void setWebsite(String website) {
        this.website = website;
    }
}
