package com.example.ankurshaswat.iitdapp.Holders;

import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.TextView;

import com.example.ankurshaswat.iitdapp.DisplayClasses.Events;
import com.example.ankurshaswat.iitdapp.ItemClickListener;
import com.example.ankurshaswat.iitdapp.R;

import org.w3c.dom.Text;

public class EventsHolder extends RecyclerView.ViewHolder {
    // each data item is just a string in this case
//    private ItemClickListener itemClickListener;
    public TextView mTextView;


    Events events;

    public EventsHolder(View v) {
        super(v);
//        v.setOnClickListener(this);
        mTextView = v.findViewById(R.id.noticeText);

    }

//    public void setItemClickListener(ItemClickListener itemClickListener){
//        this.itemClickListener = itemClickListener;
//    }

//    @Override
//    public void onClick(View v) {
//        itemClickListener.onClick(v,getAdapterPosition());
//    }
}