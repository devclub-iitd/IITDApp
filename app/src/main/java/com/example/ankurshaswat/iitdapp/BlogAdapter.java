package com.example.ankurshaswat.iitdapp;

import android.content.Context;
import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.example.ankurshaswat.iitdapp.DisplayClasses.BlogPost;
import com.koushikdutta.ion.Ion;

import java.util.ArrayList;
import java.util.List;

import static android.support.constraint.Constraints.TAG;

/**
 * Created by ankurshaswat on 11/2/18.
 */


public class BlogAdapter extends RecyclerView.Adapter<BlogAdapter.ViewHolder> {
    private ArrayList<BlogPost> blogItems;

    // Provide a reference to the views for each data item
    // Complex data items may need more than one view per item, and
    // you provide access to all the views for a data item in a view holder
    public static class ViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {
        // each data item is just a string in this case
        public TextView mTextView;
        public ImageView mImageView;
        public BlogPost blogPost;
        public ViewHolder(View v) {
            super(v);
            mTextView = v.findViewById(R.id.blogText);
            mImageView = v.findViewById(R.id.blogImage);
        }

        @Override
        public void onClick(View v) {
            Intent intent= new Intent(v.getContext(),BlogDetailActivity.class);
            intent.putExtra("body",blogPost.getBody());
            Log.d(TAG, "onClick: launching intent");
            v.getContext().startActivity(intent);
        }
    }

    public BlogAdapter(ArrayList<BlogPost> myDataset) {
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
        holder.mTextView.setText(blogItems.get(position).getTitle());
        holder.blogPost = blogItems.get(position);
        Ion.with(holder.mImageView)
                .load(blogItems.get(position).getImage());
    }

    @Override
    public int getItemCount() {
     return blogItems.size();
    }
}
