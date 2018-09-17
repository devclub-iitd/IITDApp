package com.example.ankurshaswat.iitdapp;

import android.content.Intent;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.example.ankurshaswat.iitdapp.DisplayClasses.BlogPost;

import java.util.ArrayList;

import butterknife.BindView;
import butterknife.ButterKnife;

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
    public BlogAdapter.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View itemView = LayoutInflater.from(parent.getContext()).inflate(R.layout.template_blog, parent, false);
        return new ViewHolder(itemView);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        holder.authorTextView.setText(blogItems.get(position).getAuthor());
        holder.mTextView.setText(blogItems.get(position).getTitle());
        holder.blogPost = blogItems.get(position);
        GlideApp.with(holder.mTextView.getContext()).load(blogItems.get(position).getImage()).into(holder.mImageView);
        holder.setItemClickListener(new ItemClickListener() {
            @Override
            public void onClick(View v, int position) {
                Intent intent = new Intent(v.getContext(), BlogDetailActivity.class);
                intent.putExtra("body", blogItems.get(position).getBody());
                intent.putExtra("title", blogItems.get(position).getTitle());
                intent.putExtra("image", blogItems.get(position).getImage());
                intent.putExtra("author", blogItems.get(position).getAuthor());
                v.getContext().startActivity(intent);
            }
        });
    }

    @Override
    public int getItemCount() {
        return blogItems.size();
    }

    public static class ViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {
        @BindView(R.id.blogText)
        TextView mTextView;
        @BindView(R.id.blogImage)
        ImageView mImageView;
        @BindView(R.id.blogAuthor)
        TextView authorTextView;

        BlogPost blogPost;
        private ItemClickListener itemClickListener;

        ViewHolder(View v) {
            super(v);
            ButterKnife.bind(this, v);
            v.setOnClickListener(this);
        }

        void setItemClickListener(ItemClickListener itemClickListener) {
            this.itemClickListener = itemClickListener;
        }

        @Override
        public void onClick(View v) {
            itemClickListener.onClick(v, getAdapterPosition());
        }
    }
}
