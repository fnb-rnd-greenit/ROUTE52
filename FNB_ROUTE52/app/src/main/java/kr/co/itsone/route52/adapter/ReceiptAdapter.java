package kr.co.itsone.route52.adapter;

import android.content.Context;
import android.os.Handler;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.google.firebase.crashlytics.FirebaseCrashlytics;

import java.util.List;

import kr.co.itsone.route52.R;
import kr.co.itsone.route52.entity.ReceiptEntity;

public class ReceiptAdapter extends RecyclerView.Adapter<RecyclerView.ViewHolder> {

    private Context context;
    private List<ReceiptEntity> items;
    private ItemSelectedListener listener;

    private int white;
    private int gray;
    private int gray2;
    private int red;
    private int blue;

    private boolean dblFlag = false;

    public ReceiptAdapter(Context context, List<ReceiptEntity> items, ItemSelectedListener listener) {
        this.context = context;
        this.items = items;
        this.listener = listener;

        white = context.getResources().getColor(R.color.white);
        gray = context.getResources().getColor(R.color.light_gray);
        gray2 = context.getResources().getColor(R.color.dark_gray3);
        red = context.getResources().getColor(R.color.red);
        blue = context.getResources().getColor(R.color.blue);
    }

    public interface ItemSelectedListener {
        void onSelected(int idx);
        void onDoubleClicked(int idx);
        void onLongClicked(int idx);
    }

    @NonNull
    @Override
    public RecyclerView.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        LayoutInflater inflater = LayoutInflater.from(context);
        View view = inflater.inflate(R.layout.item_print, parent, false);
        return new ReceiptViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull RecyclerView.ViewHolder holder, final int position) {
        try {
            ReceiptViewHolder viewHolder = (ReceiptViewHolder) holder;

            viewHolder.seq.setText(items.get(position).getSeq());
            viewHolder.slNo.setText(items.get(position).getSlNo());
            viewHolder.table.setText(items.get(position).getTable());
            viewHolder.staff.setText(items.get(position).getStaff());
            viewHolder.time.setText(items.get(position).getTime());
            viewHolder.chk.setSelected(items.get(position).isChecked());

            String printYn = items.get(position).getPrintYn();
            if(printYn.equals("Y")) {
                viewHolder.printYn.setText("출력 성공");
                viewHolder.printYn.setTextColor(blue);
            } else if(printYn.equals("C")) {
                viewHolder.printYn.setText("출력 취소");
                viewHolder.printYn.setTextColor(gray2);
            } else {
                viewHolder.printYn.setText("출력 대기");
                viewHolder.printYn.setTextColor(red);
            }

            if(items.get(position).isSelected()) {
                viewHolder.container.setBackgroundColor(gray);
            } else {
                viewHolder.container.setBackgroundColor(white);
            }

            viewHolder.container.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
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
                        }, 500);

                        listener.onSelected(position);
                    }
                }
            });

            viewHolder.container.setOnLongClickListener(new View.OnLongClickListener() {
                @Override
                public boolean onLongClick(View v) {
                    if(listener != null) {
                        listener.onLongClicked(position);
                    }

                    return true;
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

    private static class ReceiptViewHolder extends RecyclerView.ViewHolder {
        LinearLayout container;
        TextView seq;
        TextView slNo;
        TextView table;
        TextView staff;
        TextView time;
        TextView printYn;
        ImageView chk;

        ReceiptViewHolder(View itemView) {
            super(itemView);
            container = itemView.findViewById(R.id.itm_print_container);
            seq = itemView.findViewById(R.id.itm_txt_print_seq);
            slNo = itemView.findViewById(R.id.itm_txt_print_sl_no);
            table = itemView.findViewById(R.id.itm_txt_print_table);
            staff = itemView.findViewById(R.id.itm_txt_print_staff);
            time = itemView.findViewById(R.id.itm_txt_print_time);
            printYn = itemView.findViewById(R.id.itm_txt_print_yn);
            chk = itemView.findViewById(R.id.itm_chk_print);
        }
    }
}