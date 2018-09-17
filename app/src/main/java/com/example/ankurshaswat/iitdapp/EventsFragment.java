package com.example.ankurshaswat.iitdapp;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.example.ankurshaswat.iitdapp.DisplayClasses.Events;
import com.example.ankurshaswat.iitdapp.DisplayClasses.Notice;
import com.example.ankurshaswat.iitdapp.Holders.EventsHolder;
import com.example.ankurshaswat.iitdapp.Holders.NoticeHolder;
import com.firebase.ui.database.FirebaseRecyclerAdapter;
import com.firebase.ui.database.FirebaseRecyclerOptions;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.Query;
import com.google.firebase.events.EventHandler;

import java.util.Objects;

/**
 * Created by ankurshaswat on 23/1/18.
 */

public class EventsFragment extends Fragment {

    public EventsFragment() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_alert, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {

        LinearLayoutManager mLayoutManager = new LinearLayoutManager(getContext());

        RecyclerView blogPostList = Objects.requireNonNull(getView()).findViewById(R.id.eventsList);

        blogPostList.setLayoutManager(mLayoutManager);
        blogPostList.setAdapter(eventsAdapter);

        super.onViewCreated(view, savedInstanceState);
    }

    Query query = FirebaseDatabase.getInstance()
            .getReference()
            .child("calendar")
            .limitToLast(50);

    FirebaseRecyclerOptions<Events> options =
            new FirebaseRecyclerOptions.Builder<Events>()
                    .setQuery(query, Events.class)
                    .build();

    FirebaseRecyclerAdapter eventsAdapter = new FirebaseRecyclerAdapter<Events, EventsHolder>(options) {
        @Override
        public EventsHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(parent.getContext())
                    .inflate(R.layout.template_event, parent, false);

            return new EventsHolder(view);
        }

        @Override
        protected void onBindViewHolder(@NonNull EventsHolder holder, int position, @NonNull Events model) {

            String display = model.getDate()+": "+model.getTitle();
            holder.mTextView.setText(display);

//            holder.setItemClickListener(new ItemClickListener() {
//                @Override
//                public void onClick(View v, int position) {
//                    String url = ((Notice)eventsAdapter.getItem(position)).getLink();
//                    Intent i = new Intent(Intent.ACTION_VIEW);
//                    i.setData(Uri.parse(url));
//                    startActivity(i);
//                }
//            });
        }
    };
    @Override
    public void onStart() {
        super.onStart();
        eventsAdapter.startListening();
    }

    @Override
    public void onStop() {
        super.onStop();
        eventsAdapter.stopListening();
    }
}
