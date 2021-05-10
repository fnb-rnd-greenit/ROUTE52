package kr.co.itsone.route52.adapter;

import android.content.Context;
import android.os.Handler;
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
import kr.co.itsone.route52.entity.BillEntity;
import kr.co.itsone.route52.util.Utils;

public class BillAdapter extends RecyclerView.Adapter<RecyclerView.ViewHolder> {

    private static final int TABLE = 1000;
    private static final int ROOM = 1001;

    private ItemClickListener listener;
    private Context context;
    private List<BillEntity> items;

    private int gray;
    private int white;

    private boolean dblFlag = false;

    public interface ItemClickListener{
        void onSelected(int index);
        void onDoubleClicked();
    }

    public BillAdapter(Context context, List<BillEntity> items, ItemClickListener listener) {
        this.context = context;
        this.items = items;
        this.listener = listener;

        gray = context.getResources().getColor(R.color.dark_gray2);
        white = context.getResources().getColor(R.color.white);
    }

    @NonNull
    @Override
    public RecyclerView.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        LayoutInflater inflater = LayoutInflater.from(context);
        if(viewType == TABLE){
            View v = inflater.inflate(R.layout.item_table, parent, false);
            return new BillTableViewHolder(v);
        } else if(viewType == ROOM){
            View v = inflater.inflate(R.layout.item_room, parent, false);
            return new BillRoomViewHolder(v);
        } else {
            return null;
        }
    }

    @Override
    public void onBindViewHolder(@NonNull RecyclerView.ViewHolder holder, final int position) {
        try {
            if(getItemViewType(position) == TABLE) {
                BillTableViewHolder viewHolder = (BillTableViewHolder) holder;

                viewHolder.tableName.setText(items.get(position).getSlTableName());
                if(!items.get(position).getSlEnName().equals("")){
                    viewHolder.table.setSelected(true);
                    viewHolder.visitorName.setText(items.get(position).getSlEnName());
                    viewHolder.orderCost.setText(Utils.moneyDecimalFormat(Integer.valueOf(items.get(position).getSlTotalAmount())));
                }else {
                    viewHolder.table.setSelected(false);
                    viewHolder.visitorName.setText("");
                    viewHolder.orderCost.setText("");
                }

                if(items.get(position).isSelected()){
                    viewHolder.table.setBackgroundResource(R.drawable.icon_table_cur);
                    viewHolder.tableName.setTextColor(white);
                    viewHolder.visitorName.setTextColor(white);
                    viewHolder.orderCost.setTextColor(white);
                }else{
                    viewHolder.table.setBackgroundResource(R.drawable.btn_table_select);
                    viewHolder.tableName.setTextColor(gray);
                    viewHolder.visitorName.setTextColor(gray);
                    viewHolder.orderCost.setTextColor(gray);
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
                            }, 500);

                            listener.onSelected(position);
                        }
                    }
                });
            } else if(getItemViewType(position) == ROOM) {
                BillRoomViewHolder viewHolder = (BillRoomViewHolder) holder;

                viewHolder.tableName.setText(items.get(position).getSlTableName());
                if(!items.get(position).getSlEnName().equals("")){
                    viewHolder.table.setSelected(true);
                    viewHolder.visitorName.setText(items.get(position).getSlCosNm() + " " + Utils.getTimeFormat(items.get(position).getSlTime()) + " " + items.get(position).getSlEnName());
                    viewHolder.orderCost.setText(Utils.moneyDecimalFormat(Integer.valueOf(items.get(position).getSlTotalAmount())));
                }else {
                    viewHolder.table.setSelected(false);
                    viewHolder.visitorName.setText("");
                    viewHolder.orderCost.setText("");
                }

                if(items.get(position).isSelected()){
                    viewHolder.table.setBackgroundResource(R.drawable.icon_room_cur);
                    viewHolder.tableName.setTextColor(white);
                    viewHolder.visitorName.setTextColor(white);
                    viewHolder.orderCost.setTextColor(white);
                }else{
                    viewHolder.table.setBackgroundResource(R.drawable.btn_room_select);
                    viewHolder.tableName.setTextColor(gray);
                    viewHolder.visitorName.setTextColor(gray);
                    viewHolder.orderCost.setTextColor(gray);
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
            }
        } catch (Exception e) {
            FirebaseCrashlytics.getInstance().recordException(e);
        }
    }

    @Override
    public int getItemViewType(int position) {
        if(items.get(position).getSlDiv().equals("1")){
            return ROOM;
        }else{
            return TABLE;
        }
    }

    @Override
    public int getItemCount() {
        return items.size();
    }

    private static class BillTableViewHolder extends RecyclerView.ViewHolder {
        View container;
        ImageView table;
        TextView tableName;
        TextView visitorName;
        TextView orderCost;

        BillTableViewHolder(View itemView) {
            super(itemView);
            container = itemView;
            table = itemView.findViewById(R.id.itm_img_main_table);
            tableName = itemView.findViewById(R.id.itm_txt_main_table_name);
            visitorName = itemView.findViewById(R.id.itm_txt_main_table_visitor_name);
            orderCost = itemView.findViewById(R.id.itm_txt_main_table_order_cost);
        }
    }

    private static class BillRoomViewHolder extends RecyclerView.ViewHolder {
        View container;
        ImageView table;
        TextView tableName;
        TextView visitorName;
        TextView orderCost;

        BillRoomViewHolder(View itemView) {
            super(itemView);
            container = itemView;
            table = itemView.findViewById(R.id.itm_img_main_room);
            tableName = itemView.findViewById(R.id.itm_txt_main_room_name);
            visitorName = itemView.findViewById(R.id.itm_txt_main_room_visitor_name);
            orderCost = itemView.findViewById(R.id.itm_txt_main_room_order_cost);
        }
    }
}