package kr.co.itsone.route52.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.google.firebase.crashlytics.FirebaseCrashlytics;

import java.util.List;

import kr.co.itsone.route52.R;
import kr.co.itsone.route52.entity.MemoEntity;

public class MemoAdapter extends RecyclerView.Adapter<RecyclerView.ViewHolder> {

    private Context context;
    private List<MemoEntity> items;
    private ItemSelectedListener listener;

    private int white;
    private int black;

    public MemoAdapter(Context context, List<MemoEntity> items, ItemSelectedListener listener) {
        this.context = context;
        this.items = items;
        this.listener = listener;

        white = context.getResources().getColor(R.color.white);
        black = context.getResources().getColor(R.color.dark_gray2);
    }

    public interface ItemSelectedListener {
        void onSelected(int idx);
    }

    @NonNull
    @Override
    public RecyclerView.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        LayoutInflater inflater = LayoutInflater.from(context);
        View view = inflater.inflate(R.layout.item_memo, parent, false);
        return new MemoViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull RecyclerView.ViewHolder holder, final int position) {
        try {
            MemoViewHolder viewHolder = (MemoViewHolder) holder;

            viewHolder.time.setText(String.format("%s:%s", items.get(position).getTime().substring(0, 2), items.get(position).getTime().substring(2, 4)));
            viewHolder.cos.setText(items.get(position).getCos());
            viewHolder.name.setText(items.get(position).getName());

            if(items.get(position).isSelected()) {
                viewHolder.container.setBackgroundResource(R.drawable.line_memo_box4);
                viewHolder.name.setTextColor(white);
                viewHolder.time.setTextColor(white);
                viewHolder.cos.setTextColor(white);
            } else {
                viewHolder.container.setBackgroundResource(R.color.white);
                viewHolder.name.setTextColor(black);
                viewHolder.time.setTextColor(black);
                viewHolder.cos.setTextColor(black);
            }

            viewHolder.container.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if(listener != null) {
                        listener.onSelected(position);
                    }
                }
            });
        } catch (Exception e) {
            FirebaseCrashlytics.getInstance().recordException(e);
        }
    }

    @Override
    public int getItemCount() {
        return items.size();
    }

    private static class MemoViewHolder extends RecyclerView.ViewHolder {
        LinearLayout container;
        TextView time;
        TextView cos;
        TextView name;

        MemoViewHolder(View itemView) {
            super(itemView);
            container = itemView.findViewById(R.id.itm_memo_container);
            time = itemView.findViewById(R.id.itm_txt_memo_time);
            cos = itemView.findViewById(R.id.itm_txt_memo_cos);
            name = itemView.findViewById(R.id.itm_txt_memo_name);
        }
    }
}