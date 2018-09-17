package com.example.ankurshaswat.iitdapp;

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
import com.example.ankurshaswat.iitdapp.Holders.EventsHolder;
import com.firebase.ui.database.FirebaseRecyclerAdapter;
import com.firebase.ui.database.FirebaseRecyclerOptions;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.Query;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.Unbinder;

/**
 * Created by ankurshaswat on 23/1/18.
 */

public class EventsFragment extends Fragment {

    @BindView(R.id.eventsList)
    RecyclerView blogPostList;

    Query query = FirebaseDatabase.getInstance().getReference().child("calendar").limitToLast(50);
    FirebaseRecyclerOptions<Events> options = new FirebaseRecyclerOptions.Builder<Events>().setQuery(query, Events.class).build();
    FirebaseRecyclerAdapter eventsAdapter = new FirebaseRecyclerAdapter<Events, EventsHolder>(options) {
        @Override
        public EventsHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.template_notice, parent, false);
            return new EventsHolder(view);
        }

        @Override
        protected void onBindViewHolder(@NonNull EventsHolder holder, int position, @NonNull Events model) {
            holder.dateTextView.setText(model.getDate());
            holder.mTextView.setText(model.getTitle());
        }
    };

    private Unbinder unbinder;

    public EventsFragment() {
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_alert, container, false);
        unbinder = ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        LinearLayoutManager mLayoutManager = new LinearLayoutManager(getContext());

        blogPostList.setLayoutManager(mLayoutManager);
        blogPostList.setAdapter(eventsAdapter);

        super.onViewCreated(view, savedInstanceState);
    }

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

    @Override
    public void onDestroy() {
        super.onDestroy();
        unbinder.unbind();
    }
}
