package kr.co.itsone.route52.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.google.firebase.crashlytics.FirebaseCrashlytics;

import java.util.List;

import kr.co.itsone.route52.R;
import kr.co.itsone.route52.entity.MenuEntity;

public class OrderMenuAdapter extends RecyclerView.Adapter<RecyclerView.ViewHolder> {

    private Context context;
    private List<MenuEntity> items;
    private ItemDeleteListener listener;

    public OrderMenuAdapter(Context context, List<MenuEntity> items, ItemDeleteListener listener) {
        this.context = context;
        this.items = items;
        this.listener = listener;
    }

    public interface ItemDeleteListener {
        void onDelete(int idx);
    }

    @NonNull
    @Override
    public RecyclerView.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        LayoutInflater inflater = LayoutInflater.from(context);
        View view = inflater.inflate(R.layout.item_order_menu, parent, false);
        return new OrderViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull RecyclerView.ViewHolder holder, final int position) {
        try {
            OrderViewHolder viewHolder = (OrderViewHolder) holder;

            viewHolder.menuName.setText(items.get(position).getPdName());
            viewHolder.menuCnt.setText(String.valueOf(items.get(position).getOrderCnt()));
            viewHolder.menuDelete.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if(listener != null) {
                        listener.onDelete(position);
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

    private static class OrderViewHolder extends RecyclerView.ViewHolder {
        TextView menuName;
        TextView menuCnt;
        ImageView menuDelete;

        OrderViewHolder(View itemView) {
            super(itemView);
            menuName = itemView.findViewById(R.id.itm_txt_order_menu_name);
            menuCnt = itemView.findViewById(R.id.itm_txt_order_menu_cnt);
            menuDelete = itemView.findViewById(R.id.itm_btn_order_menu_delete);
        }
    }
}