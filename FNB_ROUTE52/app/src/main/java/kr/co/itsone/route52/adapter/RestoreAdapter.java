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
import kr.co.itsone.route52.entity.RestoreEntity;
import kr.co.itsone.route52.util.Utils;

public class RestoreAdapter extends RecyclerView.Adapter<RecyclerView.ViewHolder> {

    private Context context;
    private List<RestoreEntity> items;
    private ItemSelectedListener listener;

    public RestoreAdapter(Context context, List<RestoreEntity> items, ItemSelectedListener listener) {
        this.context = context;
        this.items = items;
        this.listener = listener;
    }

    public interface ItemSelectedListener {
        void onSelected(int idx);
    }

    @NonNull
    @Override
    public RecyclerView.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        LayoutInflater inflater = LayoutInflater.from(context);
        View view = inflater.inflate(R.layout.item_restore, parent, false);
        return new RestoreViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull RecyclerView.ViewHolder holder, final int position) {
        try {
            RestoreViewHolder viewHolder = (RestoreViewHolder) holder;

            viewHolder.cos.setText(items.get(position).getCosNm());
            viewHolder.time.setText(String.format("%s:%s", items.get(position).getTime().substring(0, 2), items.get(position).getTime().substring(2, 4)));
            viewHolder.locker.setText(items.get(position).getLocker());
            viewHolder.name.setText(items.get(position).getName());
            viewHolder.no.setText(items.get(position).getSlNo());
            viewHolder.total.setText(Utils.moneyDecimalFormat(Integer.valueOf(items.get(position).getTotalAmt())));

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

    private static class RestoreViewHolder extends RecyclerView.ViewHolder {
        LinearLayout container;
        TextView cos;
        TextView time;
        TextView locker;
        TextView name;
        TextView no;
        TextView total;

        RestoreViewHolder(View itemView) {
            super(itemView);
            container = itemView.findViewById(R.id.itm_restore_container);
            cos = itemView.findViewById(R.id.itm_txt_restore_cos);
            time = itemView.findViewById(R.id.itm_txt_restore_time);
            locker = itemView.findViewById(R.id.itm_txt_restore_locker);
            name = itemView.findViewById(R.id.itm_txt_restore_name);
            no = itemView.findViewById(R.id.itm_txt_restore_no);
            total = itemView.findViewById(R.id.itm_txt_restore_total);
        }
    }
}