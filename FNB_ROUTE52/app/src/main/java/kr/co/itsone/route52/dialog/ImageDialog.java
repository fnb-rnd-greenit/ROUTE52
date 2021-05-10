package kr.co.itsone.route52.dialog;

import android.app.Dialog;
import android.content.Context;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.bumptech.glide.request.RequestOptions;

import kr.co.itsone.route52.R;

public class ImageDialog extends Dialog {
    private Context context;
    private ImageView imgMenu;
    private TextView txtMenu;
    private TextView txtPrice;
    private String sUri, sMenu, sPrice;

    public ImageDialog(Context context) {
        super(context);
        this.context = context;
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
        setContentView(R.layout.view_image_dialog);

        init();
    }

    private void init() {
        imgMenu = findViewById(R.id.img_dialog_menu);
        txtMenu = findViewById(R.id.txt_dialog_name);
        txtPrice = findViewById(R.id.txt_dialog_price);
        if(sMenu != null && !sMenu.equals("")) {
            txtMenu.setVisibility(View.VISIBLE);
            txtMenu.setText(sMenu);
        }
        if(sPrice != null && !sPrice.equals("")) {
            txtPrice.setVisibility(View.VISIBLE);
            txtPrice.setText(sPrice + "원");
        }
        txtMenu.setText(sMenu);
        if(sUri != null && !sUri.equals("")) {
            Glide.with(context).load(sUri).apply(new RequestOptions().placeholder(R.drawable.icon_noimg)).into(imgMenu);
        }
    }

    public void setImage(String uri, String name, String price) {
        sUri = uri;
        sMenu = name;
        sPrice = price;
    }
}
