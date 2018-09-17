package com.example.ankurshaswat.iitdapp.Holders;

import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.TextView;

import com.example.ankurshaswat.iitdapp.R;

import butterknife.BindView;
import butterknife.ButterKnife;

public class EventsHolder extends RecyclerView.ViewHolder {

    @BindView(R.id.noticeText)
    public TextView mTextView;

    public EventsHolder(View v) {
        super(v);
        ButterKnife.bind(this, v);
    }

}