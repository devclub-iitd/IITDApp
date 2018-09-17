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

import com.example.ankurshaswat.iitdapp.DisplayClasses.Notice;
import com.example.ankurshaswat.iitdapp.Holders.NoticeHolder;
import com.firebase.ui.database.FirebaseRecyclerAdapter;
import com.firebase.ui.database.FirebaseRecyclerOptions;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.Query;
import com.koushikdutta.ion.Ion;

import java.util.Objects;

/**
 * Created by ankurshaswat on 23/1/18.
 */

public class NoticeFragment extends Fragment {
    public NoticeFragment() {
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
        return inflater.inflate(R.layout.fragment_notice, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {

        LinearLayoutManager mLayoutManager = new LinearLayoutManager(getContext());

        RecyclerView noticeList = Objects.requireNonNull(getView()).findViewById(R.id.noticeList);

        noticeList.setLayoutManager(mLayoutManager);
        noticeList.setAdapter(noticeAdapter);

        super.onViewCreated(view, savedInstanceState);
    }

    Query query = FirebaseDatabase.getInstance()
            .getReference()
            .child("notices")
            .limitToLast(50);

    FirebaseRecyclerOptions<Notice> options =
            new FirebaseRecyclerOptions.Builder<Notice>()
                    .setQuery(query, Notice.class)
                    .build();

    FirebaseRecyclerAdapter noticeAdapter = new FirebaseRecyclerAdapter<Notice, NoticeHolder>(options) {
        @Override
        public NoticeHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(parent.getContext())
                    .inflate(R.layout.template_notice, parent, false);

            return new NoticeHolder(view);
        }

        @Override
        protected void onBindViewHolder(@NonNull NoticeHolder holder, int position, @NonNull Notice model) {

            holder.mTextView.setText(model.getTitle());
            holder.dateTextView.setText(model.getDate());

            holder.setItemClickListener(new ItemClickListener() {
                @Override
                public void onClick(View v, int position) {
                    String url = ((Notice)noticeAdapter.getItem(position)).getLink();
                    Intent i = new Intent(Intent.ACTION_VIEW);
                    i.setData(Uri.parse(url));
                    startActivity(i);
                }
            });
        }
    };

    @Override
    public void onStart() {
        super.onStart();
        noticeAdapter.startListening();
    }

    @Override
    public void onStop() {
        super.onStop();
        noticeAdapter.stopListening();
    }
}
