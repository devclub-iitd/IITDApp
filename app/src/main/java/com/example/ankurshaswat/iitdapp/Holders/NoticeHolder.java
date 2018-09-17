package com.example.ankurshaswat.iitdapp.Holders;

import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.TextView;

import com.example.ankurshaswat.iitdapp.ItemClickListener;
import com.example.ankurshaswat.iitdapp.R;

import butterknife.BindView;
import butterknife.ButterKnife;


public class NoticeHolder extends RecyclerView.ViewHolder implements View.OnClickListener {

    @BindView(R.id.noticeText)
    public TextView mTextView;
    private ItemClickListener itemClickListener;

    public NoticeHolder(View v) {
        super(v);
        ButterKnife.bind(this, v);
        v.setOnClickListener(this);
    }

    public void setItemClickListener(ItemClickListener itemClickListener) {
        this.itemClickListener = itemClickListener;
    }

    @Override
    public void onClick(View v) {
        itemClickListener.onClick(v, getAdapterPosition());
    }
}
