package com.example.ankurshaswat.iitdapp;

import android.os.AsyncTask;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v4.widget.SwipeRefreshLayout;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.example.ankurshaswat.iitdapp.DisplayClasses.BlogPost;
import com.google.firebase.FirebaseApp;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;
import java.util.Objects;

import static android.content.ContentValues.TAG;

/**
 * Created by ankurshaswat on 23/1/18.
 */

public class BlogFragment extends Fragment {

    private static ArrayList<BlogPost> blogItems = new ArrayList<>();
    private static BlogAdapter blogAdapter;
    private SwipeRefreshLayout swipeRefreshLayout;
    ValueEventListener postListener = new ValueEventListener() {
        @Override
        public void onDataChange(@NonNull DataSnapshot dataSnapshot) {
            new RenderBlog(dataSnapshot).execute();
            swipeRefreshLayout.setRefreshing(false);
        }

        @Override
        public void onCancelled(DatabaseError error) {
            Log.w(TAG, "Failed to read value.", error.toException());
            swipeRefreshLayout.setRefreshing(false);

        }
    };
    SwipeRefreshLayout.OnRefreshListener onRefreshListener = new SwipeRefreshLayout.OnRefreshListener() {
        @Override
        public void onRefresh() {
        MyFirebaseApp.getInstance().getBlogs(postListener);
        }
    };

    public BlogFragment() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_blog, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {

        swipeRefreshLayout = Objects.requireNonNull(getView()).findViewById(R.id.swiperefresh);
        swipeRefreshLayout.setOnRefreshListener(onRefreshListener);

        swipeRefreshLayout.setRefreshing(true);

        MyFirebaseApp.getInstance().getBlogs(postListener);

        blogAdapter = new BlogAdapter(blogItems);

        LinearLayoutManager mLayoutManager = new LinearLayoutManager(getContext());

        RecyclerView blogPostList = getView().findViewById(R.id.blogList);

        blogPostList.setLayoutManager(mLayoutManager);
        blogPostList.setAdapter(blogAdapter);

        super.onViewCreated(view, savedInstanceState);
    }

    private static class RenderBlog extends AsyncTask<String, Void, String> {

        private DataSnapshot dataSnapshot;
        ArrayList<BlogPost> tempBlogItems;

        RenderBlog(DataSnapshot dataSnapshot) {
            this.dataSnapshot = dataSnapshot;
        }

        @Override
        protected String doInBackground(String... params) {

            tempBlogItems = new ArrayList<>();

            for (DataSnapshot postSnapshot : dataSnapshot.getChildren()) {
                BlogPost blogPost = postSnapshot.getValue(BlogPost.class);
                tempBlogItems.add(blogPost);
            }

            blogItems.clear();
            blogItems.addAll(tempBlogItems);
            return "Executed";
        }

        @Override
        protected void onPostExecute(String result) {
            blogAdapter.notifyDataSetChanged();
        }
    }

}