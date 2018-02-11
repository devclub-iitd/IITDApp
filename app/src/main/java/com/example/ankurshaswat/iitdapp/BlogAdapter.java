package com.example.ankurshaswat.iitdapp;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by ankurshaswat on 11/2/18.
 */


public class BlogAdapter extends RecyclerView.Adapter<BlogAdapter.ViewHolder> {
    private ArrayList<BlogItem> blogItems;

    // Provide a reference to the views for each data item
    // Complex data items may need more than one view per item, and
    // you provide access to all the views for a data item in a view holder
    public static class ViewHolder extends RecyclerView.ViewHolder {
        // each data item is just a string in this case
        public TextView mTextView;
        public ImageView mImageView;
        public ViewHolder(View v) {
            super(v);
            mTextView = v.findViewById(R.id.blogText);
            mImageView = v.findViewById(R.id.blogImage);
        }
    }

    public BlogAdapter(ArrayList<BlogItem> myDataset) {
        blogItems = myDataset;
    }

    @Override
    public BlogAdapter.ViewHolder onCreateViewHolder(ViewGroup parent,
                                                   int viewType) {
        View itemView = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.template_blog, parent, false);

        return new ViewHolder(itemView);
    }

    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {
//        holder.mTextView.setText(mDataset[position]);
    }

    @Override
    public int getItemCount() {
return 30;
//     return blogItems.size();
    }
}
