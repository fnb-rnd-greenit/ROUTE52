package kr.co.itsone.route52.adapter;

import android.content.Context;
import android.os.Handler;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.google.firebase.crashlytics.FirebaseCrashlytics;

import java.util.List;

import kr.co.itsone.route52.R;
import kr.co.itsone.route52.entity.BillEntity;
import kr.co.itsone.route52.util.Utils;

public class GpsAdapter extends RecyclerView.Adapter<RecyclerView.ViewHolder> {

    private ItemClickListener listener;
    private Context context;
    private List<BillEntity> items;

    private int black;
    private int gray;
    private int white;

    private boolean dblFlag = false;

    public interface ItemClickListener{
        void onSelected(int index);
        void onDoubleClicked();
    }

    public GpsAdapter(Context context, List<BillEntity> items, ItemClickListener listener) {
        this.context = context;
        this.items = items;
        this.listener = listener;

        black = context.getResources().getColor(R.color.dark_gray2);
        gray = context.getResources().getColor(R.color.light_gray);
        white = context.getResources().getColor(R.color.white);
    }

    @NonNull
    @Override
    public RecyclerView.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        LayoutInflater inflater = LayoutInflater.from(context);
        View v = inflater.inflate(R.layout.item_gps, parent, false);
        return new GpsViewHolder(v);
    }

    @Override
    public void onBindViewHolder(@NonNull RecyclerView.ViewHolder holder, final int position) {
        try {
            GpsViewHolder viewHolder = (GpsViewHolder) holder;

            viewHolder.status.setText(items.get(position).getSendYn().equals("Y") ? "접수" : "");
            viewHolder.orderTime.setText(Utils.getTimeFormat(items.get(position).getOrderTime()));
            viewHolder.cos.setText(items.get(position).getSlCosNm());
            viewHolder.name.setText(items.get(position).getBkName());
            viewHolder.time.setText(Utils.getTimeFormat(items.get(position).getSlTime()));
            viewHolder.cart.setText(items.get(position).getCartNo());
            viewHolder.arrive.setText(Utils.getTimeFormat(items.get(position).getArrivalTime()));
            if(items.get(position).getMenuList().equals("")) {
                viewHolder.menu.setVisibility(View.GONE);
            } else {
                viewHolder.menu.setVisibility(View.VISIBLE);
            }
            if(items.get(position).getMenuNList().equals("")) {
                viewHolder.menuN.setVisibility(View.GONE);
            } else {
                viewHolder.menuN.setVisibility(View.VISIBLE);
            }
            viewHolder.menu.setText(items.get(position).getMenuList());
            viewHolder.menuN.setText(items.get(position).getMenuNList());

            if(items.get(position).isSelected()) {
                viewHolder.container.setBackgroundColor(gray);
            } else {
                viewHolder.container.setBackgroundColor(white);
            }

            viewHolder.container.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if(listener != null) {
                        if(dblFlag) {
                            listener.onDoubleClicked();
                            return;
                        }

                        dblFlag = true;

                        new Handler().postDelayed(new Runnable() {
                            @Override
                            public void run() {
                                dblFlag = false;
                            }
                        }, 300);

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

    private static class GpsViewHolder extends RecyclerView.ViewHolder {
        View container;
        TextView status;
        TextView orderTime;
        TextView cos;
        TextView name;
        TextView time;
        TextView cart;
        TextView arrive;
        TextView menu;
        TextView menuN;

        GpsViewHolder(View itemView) {
            super(itemView);
            container = itemView;
            status = itemView.findViewById(R.id.itm_txt_gps_status);
            orderTime = itemView.findViewById(R.id.itm_txt_gps_order_time);
            cos = itemView.findViewById(R.id.itm_txt_gps_cos);
            name = itemView.findViewById(R.id.itm_txt_gps_name);
            time = itemView.findViewById(R.id.itm_txt_gps_time);
            cart = itemView.findViewById(R.id.itm_txt_gps_cart);
            arrive = itemView.findViewById(R.id.itm_txt_gps_arrive);
            menu = itemView.findViewById(R.id.itm_txt_gps_menu);
            menuN = itemView.findViewById(R.id.itm_txt_gps_menu_n);
        }
    }
}