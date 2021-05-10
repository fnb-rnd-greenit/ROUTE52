package kr.co.itsone.route52.adapter;

import android.content.Context;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.google.firebase.crashlytics.FirebaseCrashlytics;

import java.util.List;

import kr.co.itsone.route52.R;
import kr.co.itsone.route52.entity.OrderEntity;
import kr.co.itsone.route52.util.Utils;

public class OrderAdapter extends RecyclerView.Adapter<RecyclerView.ViewHolder> {

    private Context context;
    private List<OrderEntity> items;
    private ItemSelectedListener listener;

    public OrderAdapter(Context context, List<OrderEntity> items, ItemSelectedListener listener) {
        this.context = context;
        this.items = items;
        this.listener = listener;
    }

    public interface ItemSelectedListener {
        void onSeatNoChange(int idx);
        void doVisitorSearch(int idx);
        void doProductSearch(int idx);
        void delProduct(int position, int index);
    }

    @NonNull
    @Override
    public RecyclerView.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        LayoutInflater inflater = LayoutInflater.from(context);
        View view = inflater.inflate(R.layout.item_order, parent, false);
        return new OrderViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull RecyclerView.ViewHolder holder, final int position) {
        try {
            OrderViewHolder viewHolder = (OrderViewHolder) holder;

            viewHolder.txtSeq.setText(items.get(position).getVisitor().getSeatNo());

            if(!items.get(position).getVisitor().isLock()) {
                viewHolder.txtSeq.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        if(listener != null) {
                            listener.onSeatNoChange(position);
                        }
                    }
                });
            }

            String cos, time, locker, name;
            cos = items.get(position).getVisitor().getCosNm();
            time = items.get(position).getVisitor().getTime();
            locker = items.get(position).getVisitor().getLocker();
            name = items.get(position).getVisitor().getName();

            if(time != null && !time.equals("") && time.trim().length() >= 4) {
                viewHolder.txtCosTime.setText(String.format("%s코스 %s시 %s분", cos, time.substring(0, 2), time.substring(2, 4)));
                viewHolder.txtLocker.setText(locker);
            } else {
                viewHolder.txtCosTime.setText("");
                viewHolder.txtLocker.setText("");
            }

            if(name != null && !name.equals("")) {
                viewHolder.txtName.setText(name);
            } else {
                viewHolder.txtName.setText("");
            }

            viewHolder.menuContainer.removeAllViews();

            int sumCost = 0;
            for(int i=0; i<items.get(position).getMenues().size(); i++) {
                final int index = i;
                LayoutInflater inflaterView = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
                LinearLayout layout = (LinearLayout) inflaterView.inflate(R.layout.item_order_product, null);

                String pdName = items.get(position).getMenues().get(i).getPdName();
                pdName = (items.get(position).getMenues().get(i).equals("3") ?  "캐디)" : "") + pdName;
                int pdAmount = Integer.valueOf(items.get(position).getMenues().get(i).getSlAmount());
                int orderCnt = items.get(position).getMenues().get(i).getOrderCnt();
                int slDcRate = Integer.valueOf(items.get(position).getMenues().get(i).getSlDcRate());
                int cost;
                if(items.get(position).getMenues().get(i).isNewYn()) {
                    cost = pdAmount * orderCnt;
                    cost = cost - (cost * slDcRate / 100);
                } else {
                    cost = pdAmount;
                }

                sumCost += cost;

                ((TextView) layout.findViewById(R.id.itm_txt_order_product_name)).setText(String.format("%s %dEA", pdName, orderCnt));

                if(items.get(position).getMenues().get(i).getSlCancel().equals("Y")) {
                    layout.findViewById(R.id.itm_btn_order_product_delete).setVisibility(View.GONE);
                } else {
                    layout.findViewById(R.id.itm_btn_order_product_delete).setVisibility(View.VISIBLE);
                }

                layout.findViewById(R.id.itm_btn_order_product_delete).setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        if(listener != null) {
                            listener.delProduct(position, index);
                        }
                    }
                });

                viewHolder.menuContainer.addView(layout);
            }

            if(sumCost != 0) {
                TextView txtCost = new TextView(context);

                LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.MATCH_PARENT);
                layoutParams.weight = 1;

                txtCost.setGravity(Gravity.CENTER);
                txtCost.setTextSize(20);
                txtCost.setTextColor(context.getResources().getColor(R.color.dark_red));
                txtCost.setText(String.format("₩ %s", Utils.moneyDecimalFormat(sumCost)));

                viewHolder.menuContainer.addView(txtCost);
            }

            viewHolder.btnVisitorSearch.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if(listener != null) {
                        listener.doVisitorSearch(position);
                    }
                }
            });

            viewHolder.btnMenuSearch.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    if(listener != null) {
                        listener.doProductSearch(position);
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
        LinearLayout container;
        LinearLayout menuContainer;

        TextView txtSeq;
        TextView txtCosTime;
        TextView txtLocker;
        TextView txtName;

        Button btnVisitorSearch;
        ImageView btnMenuSearch;

        OrderViewHolder(View itemView) {
            super(itemView);
            container = (LinearLayout) itemView;
            menuContainer = itemView.findViewById(R.id.itm_linear_order_menu_container);
            txtSeq = itemView.findViewById(R.id.itm_txt_order_seq);
            txtCosTime = itemView.findViewById(R.id.itm_txt_order_cos_time);
            txtLocker = itemView.findViewById(R.id.itm_txt_order_locker);
            txtName = itemView.findViewById(R.id.itm_txt_order_name);

            btnVisitorSearch = itemView.findViewById(R.id.itm_btn_order_visitor_search);
            btnMenuSearch = itemView.findViewById(R.id.itm_btn_order_menu_search);
        }
    }
}