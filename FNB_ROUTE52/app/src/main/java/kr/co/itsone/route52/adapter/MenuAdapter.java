package kr.co.itsone.route52.adapter;

import android.app.Activity;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Spinner;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.google.firebase.crashlytics.FirebaseCrashlytics;

import java.util.ArrayList;
import java.util.List;

import kr.co.itsone.route52.R;
import kr.co.itsone.route52.entity.DiscountEntity;
import kr.co.itsone.route52.entity.MenuEntity;
import kr.co.itsone.route52.entity.SaleDivEntity;
import kr.co.itsone.route52.util.AlertUtil;
import kr.co.itsone.route52.util.Globals;
import kr.co.itsone.route52.util.Utils;

public class MenuAdapter extends RecyclerView.Adapter<RecyclerView.ViewHolder> {

    private String mCoDiv;
    private Context context;
    private List<MenuEntity> items;
    private ItemAddListener listener;
    private List<String> discountItems = new ArrayList<>();
    private List<DiscountEntity> discounts = new ArrayList<>();
    private List<String> saleDivItems = new ArrayList<>();
    private List<SaleDivEntity> saleDivs = new ArrayList<>();
    private int gray;
    private int white;

    public MenuAdapter(Context context, List<MenuEntity> items, ItemAddListener listener) {
        this.mCoDiv = Utils.loadSharedPreferences(context, Globals.COMPANY);
        this.context = context;
        this.items = items;
        this.listener = listener;

        String coDiv = Utils.loadSharedPreferences(context, Globals.COMPANY);

        for(int i=0; i< Globals.mDiscounts.size(); i++){
            if(Globals.mDiscounts.get(i).getCoDiv().equals(coDiv)) {
                discounts.add(Globals.mDiscounts.get(i));
                discountItems.add(Globals.mDiscounts.get(i).getName());
            }
        }

        for(int i=0; i< Globals.mSaleDivs.size(); i++){
            if(Globals.mSaleDivs.get(i).getCoDiv().equals(coDiv)) {
                saleDivs.add(Globals.mSaleDivs.get(i));
                saleDivItems.add(Globals.mSaleDivs.get(i).getName());
            }
        }

        gray = context.getResources().getColor(R.color.light_gray);
        white = context.getResources().getColor(R.color.white);
    }

    public interface ItemAddListener {
        void onPlus(int position);
        void onMinus(int position);
        void onDisSelected(int position, int idx, String value);
        void onSaleDivSelected(int position, int idx, String value);
        void onImageView(String uri, String name, String price);
        void onEditMemo(int position, String memo);
    }

    @NonNull
    @Override
    public RecyclerView.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        LayoutInflater inflater = LayoutInflater.from(context);
        View view = inflater.inflate(R.layout.item_menu, parent, false);
        return new MenuViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull RecyclerView.ViewHolder holder, final int position) {
        try {
            final MenuViewHolder viewHolder = (MenuViewHolder) holder;

            if(position % 4 == 1 || position % 4 == 2) {
                viewHolder.container.setBackgroundColor(gray);
            } else {
                viewHolder.container.setBackgroundColor(white);
            }

            /*if(!items.get(position).getPdImageUrl().equals("")) {
                String imageUri = String.format(context.getString(R.string.image_host), mCoDiv, items.get(position).getPdImageUrl());
                Glide.with(context).load(imageUri).apply(new RequestOptions().placeholder(R.drawable.icon_noimg)).into(viewHolder.menuImg);
            }else{
                Glide.with(context).load(R.drawable.icon_noimg).into(viewHolder.menuImg);
            }*/

            viewHolder.menuName.setText(items.get(position).getPdName());
            viewHolder.menuPrice.setText(Utils.moneyDecimalFormat(Integer.valueOf(items.get(position).getSlAmount())) + " 원");
            viewHolder.menuCnt.setText(String.valueOf(items.get(position).getOrderCnt()));
            viewHolder.menuMemo.setText(items.get(position).getMemo());

            viewHolder.menuMemo.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    AlertUtil.editDialog((Activity) context, context.getString(R.string.message_header), "메모를 입력해주세요.", new AlertUtil.edDialogListener() {
                        @Override
                        public void onConfirm(String edit) {
                            if(listener != null) {
                                listener.onEditMemo(position, edit);
                            }
                        }
                    });
                }
            });

            SpinnerAdapter adapter = new SpinnerAdapter(context, android.R.layout.simple_spinner_item, discountItems, context.getResources().getColor(R.color.dark_red));

            viewHolder.menuDiscount.setAdapter(adapter);
            viewHolder.menuDiscount.setSelection(items.get(position).getSlDcRateIdx());

            viewHolder.menuDiscount.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
                @Override
                public void onItemSelected(AdapterView<?> parent, View view, int idx, long id) {
                    if(listener != null) {
                        listener.onDisSelected(position, idx, discounts.get(idx).getCode());
                    }
                }

                @Override
                public void onNothingSelected(AdapterView<?> parent) {

                }
            });

            SpinnerAdapter adapter2 = new SpinnerAdapter(context, android.R.layout.simple_spinner_item, saleDivItems, context.getResources().getColor(R.color.dark_gray3));

            viewHolder.menuSaleDiv.setAdapter(adapter2);
            viewHolder.menuSaleDiv.setSelection(items.get(position).getSaleDivIdx());

            viewHolder.menuSaleDiv.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
                @Override
                public void onItemSelected(AdapterView<?> parent, View view, int idx, long id) {
                    if(listener != null) {
                        listener.onSaleDivSelected(position, idx, saleDivs.get(idx).getCode());
                    }
                }

                @Override
                public void onNothingSelected(AdapterView<?> parent) {

                }
            });

            /*viewHolder.menuImg.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if(listener != null && !items.get(position).getPdImageUrl().equals("")) {
                        listener.onImageView(String.format(context.getString(R.string.image_host), mCoDiv, items.get(position).getPdImageUrl()), items.get(position).getPdName(), items.get(position).getSlAmount());
                    }
                }
            });*/

            viewHolder.menuMinus.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if(listener != null) {
                        listener.onMinus(position);
                    }
                }
            });

            viewHolder.menuPlus.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if(listener != null) {
                        listener.onPlus(position);
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

    private static class MenuViewHolder extends RecyclerView.ViewHolder {
        LinearLayout container;
        //ImageView menuImg;
        TextView menuName;
        TextView menuPrice;
        ImageView menuMinus;
        ImageView menuPlus;
        TextView menuCnt;
        Spinner menuDiscount;
        Spinner menuSaleDiv;
        TextView menuMemo;

        MenuViewHolder(View itemView) {
            super(itemView);
            container = itemView.findViewById(R.id.itm_linear_menu_container);
            //menuImg = itemView.findViewById(R.id.itm_img_menu);
            menuName = itemView.findViewById(R.id.itm_txt_menu_name);
            menuPrice = itemView.findViewById(R.id.itm_txt_menu_price);
            menuMinus = itemView.findViewById(R.id.itm_btn_menu_minus);
            menuPlus = itemView.findViewById(R.id.itm_btn_menu_plus);
            menuCnt = itemView.findViewById(R.id.itm_txt_menu_cnt);
            menuDiscount = itemView.findViewById(R.id.itm_spinner_menu_discount);
            menuSaleDiv = itemView.findViewById(R.id.itm_spinner_menu_sale_div);
            menuMemo = itemView.findViewById(R.id.itm_txt_menu_memo);
        }
    }
}