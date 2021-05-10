package kr.co.itsone.route52.dialog;

import android.app.Dialog;
import android.content.Context;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.view.Window;

import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;
import java.util.List;

import kr.co.itsone.route52.R;
import kr.co.itsone.route52.adapter.OrderMenuAdapter;
import kr.co.itsone.route52.entity.MenuEntity;


public class ItemListDialog extends Dialog {
    private Context context;
    private RecyclerView listAddMenu;
    private List<MenuEntity> mOrderMenus = new ArrayList<>();
    private OrderMenuAdapter orderMenuAdapter;
    private ItemListListener mListener;

    public ItemListDialog(Context context, ItemListListener listener) {
        super(context);
        this.context = context;
        this.mListener = listener;
    }

    public void setItems(List<MenuEntity> items) {
        mOrderMenus.clear();
        mOrderMenus.addAll(items);
    }

    public interface ItemListListener {
        void onDeleted(int idx);
    }

    @Override
    public void cancel() {
        super.cancel();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        getWindow().setBackgroundDrawable(new ColorDrawable(android.graphics.Color.TRANSPARENT));
        setContentView(R.layout.view_item_list_dialog);

        init();
    }

    private void init() {
        listAddMenu = findViewById(R.id.list_order_write_add_menu);
        listAddMenu.setLayoutManager(new LinearLayoutManager(context));

        orderMenuAdapter = new OrderMenuAdapter(context, mOrderMenus, new OrderMenuAdapter.ItemDeleteListener() {
            @Override
            public void onDelete(int idx) {
                mOrderMenus.get(idx).setOrderCnt(0); // 주소값이기때문에 값부터 바꾸고 삭제
                mOrderMenus.remove(idx);
                orderMenuAdapter.notifyDataSetChanged();

                if(mListener != null) {
                    mListener.onDeleted(idx);
                }
            }
        });

        listAddMenu.setAdapter(orderMenuAdapter);
    }
}
