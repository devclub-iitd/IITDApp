package com.example.ankurshaswat.iitdapp;

import android.app.Application;

import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

public class MyFirebaseApp extends Application {

    FirebaseDatabase database;
    private static MyFirebaseApp sInstance = null;


    @Override
    public void onCreate() {
        super.onCreate();

        sInstance = this;

        /* Enable disk persistence  */
        database = FirebaseDatabase.getInstance();
        database.setPersistenceEnabled(true);
    }

    public void getBlogs(ValueEventListener postListener) {
        DatabaseReference ref = database.getReference("blogs");
        ref.addListenerForSingleValueEvent(postListener);

    }

    // Getter to access Singleton instance
    public static MyFirebaseApp getInstance() {
        return sInstance ;
    }
}
