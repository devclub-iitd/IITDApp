package com.example.ankurshaswat.iitdapp;

import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.example.ankurshaswat.iitdapp.DisplayClasses.BlogPost;
import com.koushikdutta.ion.Ion;

import java.util.ArrayList;

import static android.support.constraint.Constraints.TAG;

/**
 * Created by ankurshaswat on 11/2/18.
 */


public class BlogAdapter extends RecyclerView.Adapter<BlogAdapter.ViewHolder> {
    private ArrayList<BlogPost> blogItems;

    BlogAdapter(ArrayList<BlogPost> blogItems) {
        this.blogItems = blogItems;
    }

    @NonNull
    @Override
    public BlogAdapter.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent,
                                                     int viewType) {
        View itemView = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.template_blog, parent, false);

        return new ViewHolder(itemView);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        holder.authorTextView.setText(blogItems.get(position).getAuthor());
        holder.mTextView.setText(blogItems.get(position).getTitle());
        holder.blogPost = blogItems.get(position);
        Ion.with(holder.mImageView)
                .load(blogItems.get(position).getImage());
        holder.setItemClickListener(new ItemClickListener() {
            @Override
            public void onClick(View v, int position) {
                Intent intent = new Intent(v.getContext(), BlogDetailActivity.class);
                intent.putExtra("body", blogItems.get(position).getBody());
                intent.putExtra("title",blogItems.get(position).getTitle());
                intent.putExtra("image",blogItems.get(position).getImage());
                intent.putExtra("author",blogItems.get(position).getAuthor());
//                Log.d(TAG, "onClick: launching intent");
                v.getContext().startActivity(intent);
            }
        });
    }

    @Override
    public int getItemCount() {
        return blogItems.size();
    }

    // Provide a reference to the views for each data item
    // Complex data items may need more than one view per item, and
    // you provide access to all the views for a data item in a view holder
    public static class ViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {
        // each data item is just a string in this case
        private ItemClickListener itemClickListener;

        TextView mTextView;
        ImageView mImageView;
        BlogPost blogPost;
        TextView authorTextView;

        ViewHolder(View v) {
            super(v);
            v.setOnClickListener(this);
            mTextView = v.findViewById(R.id.blogText);
            mImageView = v.findViewById(R.id.blogImage);
            authorTextView = v.findViewById(R.id.blogAuthor);
        }

        public void setItemClickListener(ItemClickListener itemClickListener){
            this.itemClickListener = itemClickListener;
        }

        @Override
        public void onClick(View v) {
            itemClickListener.onClick(v,getAdapterPosition());
        }
    }
}
