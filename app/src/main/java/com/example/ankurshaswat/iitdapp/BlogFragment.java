package com.example.ankurshaswat.iitdapp;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.example.ankurshaswat.iitdapp.DisplayClasses.BlogPost;
import com.example.ankurshaswat.iitdapp.Holders.BlogPostHolder;
import com.firebase.ui.database.FirebaseRecyclerAdapter;
import com.firebase.ui.database.FirebaseRecyclerOptions;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.Query;

import java.util.Objects;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.Unbinder;

/**
 * Created by ankurshaswat on 23/1/18.
 */

public class BlogFragment extends Fragment {

    @BindView(R.id.blogList)
    RecyclerView blogPostList;

    Query query = FirebaseDatabase.getInstance().getReference().child("blogs").limitToLast(50);
    FirebaseRecyclerOptions<BlogPost> options = new FirebaseRecyclerOptions.Builder<BlogPost>().setQuery(query, BlogPost.class).build();
    FirebaseRecyclerAdapter blogAdapter = new FirebaseRecyclerAdapter<BlogPost, BlogPostHolder>(options) {
        @Override
        public BlogPostHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.template_blog, parent, false);
            return new BlogPostHolder(view);
        }

        @Override
        protected void onBindViewHolder(@NonNull BlogPostHolder holder, int position, @NonNull BlogPost model) {
            holder.mTextView.setText(model.getTitle());
            holder.authorTextView.setText(model.getAuthor());

            GlideApp.with(Objects.requireNonNull(getContext())).load(model.getImage()).into(holder.mImageView);
            holder.setItemClickListener(new ItemClickListener() {
                @Override
                public void onClick(View v, int position) {
                    Intent intent = new Intent(v.getContext(), BlogDetailActivity.class);
                    intent.putExtra("body", ((BlogPost) blogAdapter.getItem(position)).getBody());
                    intent.putExtra("title", ((BlogPost) blogAdapter.getItem(position)).getTitle());
                    intent.putExtra("image", ((BlogPost) blogAdapter.getItem(position)).getImage());
                    intent.putExtra("author", ((BlogPost) blogAdapter.getItem(position)).getAuthor());
                    v.getContext().startActivity(intent);
                }
            });
        }
    };

    private Unbinder unbinder;

    public BlogFragment() {
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_blog, container, false);
        unbinder = ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        LinearLayoutManager mLayoutManager = new LinearLayoutManager(getContext());

        blogPostList.setLayoutManager(mLayoutManager);
        blogPostList.setAdapter(blogAdapter);

        super.onViewCreated(view, savedInstanceState);
    }

    @Override
    public void onStart() {
        super.onStart();
        blogAdapter.startListening();
    }

    @Override
    public void onStop() {
        super.onStop();
        blogAdapter.stopListening();
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        unbinder.unbind();
    }
}