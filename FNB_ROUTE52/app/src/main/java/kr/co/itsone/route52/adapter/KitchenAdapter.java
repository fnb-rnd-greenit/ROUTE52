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
import kr.co.itsone.route52.entity.KitchenEntity;

public class KitchenAdapter extends RecyclerView.Adapter<RecyclerView.ViewHolder> {

    private Context context;
    private List<KitchenEntity> items;
    private ItemSelectedListener listener;

    private int white;
    private int gray;
    private int gray2;
    private int red;
    private int blue;

    public KitchenAdapter(Context context, List<KitchenEntity> items, ItemSelectedListener listener) {
        this.context = context;
        this.items = items;
        this.listener = listener;

        white = context.getResources().getColor(R.color.white);
        gray = context.getResources().getColor(R.color.light_gray);
        gray2 = context.getResources().getColor(R.color.dark_gray2);
        red = context.getResources().getColor(R.color.red);
        blue = context.getResources().getColor(R.color.blue);
    }

    public interface ItemSelectedListener {
        void onSelected(int idx);
    }

    @NonNull
    @Override
    public RecyclerView.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        LayoutInflater inflater = LayoutInflater.from(context);
        View view = inflater.inflate(R.layout.item_kitchen_order, parent, false);
        return new KitchenViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull RecyclerView.ViewHolder holder, final int position) {
        try {
            KitchenViewHolder viewHolder = (KitchenViewHolder) holder;

            viewHolder.no.setText(items.get(position).getNo());
            viewHolder.table.setText(items.get(position).getTable());
            viewHolder.menu.setText(items.get(position).getMenu());
            viewHolder.cnt.setText(items.get(position).getCnt());

            String status = items.get(position).getStatus();
            if(status.equals("0")) {
                viewHolder.status.setText("대기");
                viewHolder.status.setTextColor(gray2);
            } else if(status.equals("1")) {
                viewHolder.status.setText("조리시작");
                viewHolder.status.setTextColor(blue);
            } else if(status.equals("2")) {
                viewHolder.status.setText("조리완료");
                viewHolder.status.setTextColor(red);
            }

            if(items.get(position).isSelected()) {
                viewHolder.container.setBackgroundColor(gray);
            } else {
                viewHolder.container.setBackgroundColor(white);
            }

            viewHolder.container.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    if(listener != null) listener.onSelected(position);
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

    private static class KitchenViewHolder extends RecyclerView.ViewHolder {
        LinearLayout container;
        TextView no;
        TextView table;
        TextView menu;
        TextView cnt;
        TextView status;

        KitchenViewHolder(View itemView) {
            super(itemView);
            container = itemView.findViewById(R.id.itm_kitchen_order_container);
            no = itemView.findViewById(R.id.itm_kitchen_order_no);
            table = itemView.findViewById(R.id.itm_kitchen_order_table);
            menu = itemView.findViewById(R.id.itm_kitchen_order_menu);
            cnt = itemView.findViewById(R.id.itm_kitchen_order_cnt);
            status = itemView.findViewById(R.id.itm_kitchen_order_status);
        }
    }
}