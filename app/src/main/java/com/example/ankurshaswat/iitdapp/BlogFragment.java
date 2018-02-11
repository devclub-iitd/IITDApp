package com.example.ankurshaswat.iitdapp;

/**
 * Created by ankurshaswat on 23/1/18.
 */
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.text.method.ScrollingMovementMethod;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;
import android.widget.TextView;

import java.util.ArrayList;

public class BlogFragment extends Fragment{

    private RecyclerView blogPostList;
    private BlogAdapter blogAdapter;
    private LinearLayoutManager mLayoutManager;

    public BlogFragment() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {



        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_blog, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {

        blogAdapter=new BlogAdapter(new ArrayList<BlogItem>(10));

        mLayoutManager = new LinearLayoutManager(getContext());

        blogPostList = getView().findViewById(R.id.blogList);

        blogPostList.setLayoutManager(mLayoutManager);
        blogPostList.setAdapter(blogAdapter);

        super.onViewCreated(view, savedInstanceState);
    }
}