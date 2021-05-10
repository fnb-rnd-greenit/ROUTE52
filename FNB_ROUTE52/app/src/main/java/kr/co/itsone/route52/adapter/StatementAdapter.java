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
import kr.co.itsone.route52.entity.StatementEntity;
import kr.co.itsone.route52.util.Utils;

public class StatementAdapter extends RecyclerView.Adapter<RecyclerView.ViewHolder> {

    private Context context;
    private List<StatementEntity> items;
    private ItemSelectedListener listener;

    private int white;
    private int gray;

    public StatementAdapter(Context context, List<StatementEntity> items, ItemSelectedListener listener) {
        this.context = context;
        this.items = items;
        this.listener = listener;

        white = context.getResources().getColor(R.color.white);
        gray = context.getResources().getColor(R.color.light_gray);
    }

    public interface ItemSelectedListener {
        void onSelected(int idx);
    }

    @NonNull
    @Override
    public RecyclerView.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        LayoutInflater inflater = LayoutInflater.from(context);
        View view = inflater.inflate(R.layout.item_statement, parent, false);
        return new StatementViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull RecyclerView.ViewHolder holder, final int position) {
        try {
            StatementViewHolder viewHolder = (StatementViewHolder) holder;

            viewHolder.slNo.setText(items.get(position).getSlNo());
            viewHolder.tableName.setText(items.get(position).getSlTableName());
            viewHolder.gpName.setText(items.get(position).getGpName());
            viewHolder.amount.setText(Utils.moneyDecimalFormat(Integer.valueOf(items.get(position).getSlTotalAmount())) + "원");
            if(items.get(position).getSlTime() != null && items.get(position).getSlTime().trim().length() >= 4) {
                viewHolder.time.setText(String.format("%s:%s", items.get(position).getSlTime().substring(0, 2), items.get(position).getSlTime().substring(2, 4)));
            }

            String statementNm;
            if(items.get(position).getSlState().equals("1")) {
                statementNm = "판매중";
            } else if(items.get(position).getSlState().equals("2")) {
                statementNm = "정산";
            } else {
                statementNm = "주문취소";
            }
            viewHolder.state.setText(statementNm);

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

    private static class StatementViewHolder extends RecyclerView.ViewHolder {
        LinearLayout container;
        TextView slNo;
        TextView tableName;
        TextView gpName;
        TextView time;
        TextView amount;
        TextView state;

        StatementViewHolder(View itemView) {
            super(itemView);
            container = itemView.findViewById(R.id.itm_statement_container);
            slNo = itemView.findViewById(R.id.itm_txt_statement_no);
            tableName = itemView.findViewById(R.id.itm_txt_statement_table_name);
            gpName = itemView.findViewById(R.id.itm_txt_statement_gp_name);
            time = itemView.findViewById(R.id.itm_txt_statement_time);
            amount = itemView.findViewById(R.id.itm_txt_statement_amount);
            state = itemView.findViewById(R.id.itm_txt_statement_state);
        }
    }
}