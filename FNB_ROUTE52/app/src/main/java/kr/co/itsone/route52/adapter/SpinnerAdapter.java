package kr.co.itsone.route52.adapter;

import android.content.Context;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import com.google.firebase.crashlytics.FirebaseCrashlytics;

import java.util.ArrayList;
import java.util.List;

import kr.co.itsone.route52.R;

public class SpinnerAdapter extends ArrayAdapter<String> {
    Context context;
    List<String> items = new ArrayList<>();
    int textColor = -1;

    public SpinnerAdapter(Context context, int res, List<String> objects) {
        super(context, res, objects);
        this.context = context;
        this.items.addAll(objects);
    }

    public SpinnerAdapter(Context context, int res, List<String> objects, int textColor) {
        super(context, res, objects);
        this.context = context;
        this.items.addAll(objects);
        this.textColor = textColor;
    }

    @Override
    public View getDropDownView(int position, View convertView, ViewGroup parent) {
        if (convertView == null) {
            LayoutInflater inflater = LayoutInflater.from(context);
            convertView = inflater.inflate(android.R.layout.simple_spinner_dropdown_item, parent, false);
        }

        TextView tv = convertView.findViewById(android.R.id.text1);
        tv.setGravity(Gravity.CENTER);
        tv.setText(items.get(position));
        if(textColor != -1) {
            tv.setTextColor(textColor);
        } else {
            tv.setTextColor(context.getResources().getColor(R.color.dark_gray));
        }
        tv.setTextSize(18);
        tv.setHeight(60);
        return convertView;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        if (convertView == null) {
            LayoutInflater inflater = LayoutInflater.from(context);
            convertView = inflater.inflate(android.R.layout.simple_spinner_item, parent, false);
        }

        try {
            TextView tv = convertView.findViewById(android.R.id.text1);
            tv.setGravity(Gravity.CENTER);
            tv.setText(items.get(position));
            if(textColor != -1) {
                tv.setTextColor(textColor);
            } else {
                tv.setTextColor(context.getResources().getColor(R.color.dark_gray));
            }
            tv.setTextSize(18);
        } catch (Exception e) {
            FirebaseCrashlytics.getInstance().recordException(e);
        }

        return convertView;
    }
}
