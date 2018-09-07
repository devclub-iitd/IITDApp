package com.example.ankurshaswat.iitdapp.DisplayClasses;

import android.util.Log;

import com.google.firebase.database.Exclude;
import com.google.firebase.database.IgnoreExtraProperties;

import java.util.HashMap;
import java.util.Map;

import static android.content.ContentValues.TAG;

@IgnoreExtraProperties
    public class BlogPost {

        public String uid;
        public String author;
        public String title;
    public String time;
    public String website;
    public String body;
        public String image;
        public String postURL;
    public String category;

        public BlogPost() {
            // Default constructor required for calls to DataSnapshot.getValue(Post.class)
        }

        public BlogPost(String uid, String author, String title, String body,String image,String postURL,String time,String website,String category) {
            this.uid = uid;
            this.author = author;
            this.title = title;
            this.time = time;
            this.website = website;

            this.body = body;
            this.image = image;
            this.postURL = postURL;
            this.category = category;
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

    @Exclude
        public Map<String, Object> toMap() {
            HashMap<String, Object> result = new HashMap<>();
            result.put("uid", uid);
            result.put("author", author);
            result.put("title", title);
        result.put("time", time);
            result.put("body", body);
            result.put("image", image);
            result.put("postURL", postURL);
        result.put("category", category);

            return result;
        }

}
