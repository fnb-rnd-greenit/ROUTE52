package kr.co.itsone.route52.adapter;

import android.content.Context;
import android.os.Handler;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.google.firebase.crashlytics.FirebaseCrashlytics;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import kr.co.itsone.route52.R;
import kr.co.itsone.route52.entity.VisitorEntity;

public class VisitorAdapter extends RecyclerView.Adapter<RecyclerView.ViewHolder> {

    private Context context;
    private List<VisitorEntity> items;
    public List<VisitorEntity> filterItems;
    private ItemSelectedListener listener;

    private int white;
    private int black;

    private boolean dblFlag = false;

    public VisitorAdapter(Context context, List<VisitorEntity> items, ItemSelectedListener listener) {
        this.context = context;
        this.items = items;
        this.listener = listener;

        this.filterItems = new ArrayList<>();
        this.filterItems.addAll(items);

        white = context.getResources().getColor(R.color.white);
        black = context.getResources().getColor(R.color.dark_gray2);
    }

    public interface ItemSelectedListener {
        void onSelected(int idx);
        void onDoubleClicked(int idx);
    }

    @NonNull
    @Override
    public RecyclerView.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        LayoutInflater inflater = LayoutInflater.from(context);
        View view = inflater.inflate(R.layout.item_visitor, parent, false);
        return new VisitorViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull RecyclerView.ViewHolder holder, final int position) {
        try {
            VisitorViewHolder viewHolder = (VisitorViewHolder) holder;

            viewHolder.time.setText(String.format("%s:%s", items.get(position).getTime().substring(0, 2), items.get(position).getTime().substring(2, 4)));
            viewHolder.name.setText(items.get(position).getName());
            viewHolder.group.setText(items.get(position).getGpName());
            viewHolder.caddy.setText(items.get(position).getCyName());
            viewHolder.cart.setText(items.get(position).getCartNo());

            if(items.get(position).isSelected()){
                viewHolder.container.setSelected(true);
                viewHolder.name.setTextColor(white);
                viewHolder.group.setTextColor(white);
                viewHolder.caddy.setTextColor(white);
                viewHolder.cart.setTextColor(white);
            }else{
                viewHolder.container.setSelected(false);
                viewHolder.name.setTextColor(black);
                viewHolder.group.setTextColor(black);
                viewHolder.caddy.setTextColor(black);
                viewHolder.cart.setTextColor(black);
            }

            viewHolder.container.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if(listener != null) {
                        if(dblFlag) {
                            listener.onDoubleClicked(position);
                            return;
                        }

                        dblFlag = true;

                        new Handler().postDelayed(new Runnable() {
                            @Override
                            public void run() {
                                dblFlag = false;
                            }
                        }, 300);

                        for(int i=0; i<filterItems.size(); i++) {
                            filterItems.get(i).setSelected(false);
                        }

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

    private static class VisitorViewHolder extends RecyclerView.ViewHolder {
        LinearLayout container;
        TextView time;
        TextView name;
        TextView group;
        TextView caddy;
        TextView cart;

        VisitorViewHolder(View itemView) {
            super(itemView);
            container = itemView.findViewById(R.id.item_linear_visitor_container);
            time = itemView.findViewById(R.id.itm_txt_visitor_time);
            name = itemView.findViewById(R.id.itm_txt_visitor_name);
            group = itemView.findViewById(R.id.itm_txt_visitor_gp_name);
            caddy = itemView.findViewById(R.id.itm_txt_visitor_caddy_name);
            cart = itemView.findViewById(R.id.itm_txt_visitor_cart_no);
        }
    }

    public void setFilter(List<VisitorEntity> items) {
        this.filterItems = new ArrayList<>();
        this.filterItems.addAll(items);
    }

    public void filter(String charText, String part) {
        try {
            charText = charText.toLowerCase(Locale.getDefault());
            items.clear();
            if (charText.length() == 0) {
                items.addAll(filterItems);
            } else {
                for (VisitorEntity entity : filterItems) {
                    if (entity.getName().toLowerCase().contains(charText)||entity.getLocker().toLowerCase().contains(charText)
                            ||entity.getGpName().toLowerCase().contains(charText)||entity.getBkName().toLowerCase().contains(charText)) {
                        items.add(entity);
                    }
                }
            }

            if(!part.equals("0")) {
                for(int i=items.size()-1; i>=0; i--) {
                    if(!items.get(i).getPart().equals(part)) {
                        items.remove(i);
                    }
                }
            }

            notifyDataSetChanged();
        } catch (Exception e) {
            FirebaseCrashlytics.getInstance().recordException(e);
        }
    }
}