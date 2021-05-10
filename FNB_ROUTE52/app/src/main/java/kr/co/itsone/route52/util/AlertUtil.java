package kr.co.itsone.route52.util;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.Toast;

import kr.co.itsone.route52.R;

/**
 * Created by soonhyung on 2017-11-09.
 */

public class AlertUtil {

    private static Toast mToast;
    private static ProgressDialog dialog;
    /**
     * Progress Dialog
     * */
    public static void showProgress(Context context, String header, String message){
        if(dialog != null && dialog.isShowing()) dialog.dismiss();
        dialog = new ProgressDialog(context);
        dialog.setTitle(header);
        dialog.setMessage(message);
        dialog.show();
    }

    public static void dismissProgress(){
        if(dialog != null && dialog.isShowing()) dialog.dismiss();
    }

    /**
     * Toast 메세지 짧게
     * @param context
     * @param msg
     * */
    public static void showToastShort(Context context, String msg) {
        try {
            if (mToast == null) {
                mToast = Toast.makeText(context, msg, Toast.LENGTH_SHORT);
            } else {
                mToast.setText(msg);
            }
            mToast.show();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Toast 메세지 길게
     * @param context
     * @param msg
     * */
    public static void showToastLong(Context context, String msg) {
        try {
            if (mToast == null) {
                mToast = Toast.makeText(context, msg, Toast.LENGTH_LONG);
            } else {
                mToast.setText(msg);
            }
            mToast.show();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * OK Dialog
     * @param activity
     * @param title
     * @param message
     * @param listener
     * */
    public static void okDialog(Activity activity, String title, String message, final okDialogListener listener){
        AlertDialog.Builder ad = new AlertDialog.Builder(activity);
        ad.setTitle(title);
        ad.setMessage(message);

        ad.setPositiveButton("확인", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
                if(listener != null) listener.onOk();
            }
        });

        ad.setOnCancelListener(new DialogInterface.OnCancelListener() {
            @Override
            public void onCancel(DialogInterface dialog) {
                dialog.dismiss();
                if(listener != null) listener.onOk();
            }
        });

        ad.create();
        ad.show();
    }

    /**
     * OK Dialog Listener
     * */
    public interface okDialogListener {
        void onOk();
    }

    /**
     * YesNo Dialog
     * @param activity
     * @param title
     * @param message
     * @param positive
     * @param negative
     * @param listener
     */
    public static void yesNoDialog(Activity activity, String title, String message, String positive, String negative, final yesNoDialogListener listener) {
        AlertDialog.Builder ad = new AlertDialog.Builder(activity);
        ad.setTitle(title);
        ad.setMessage(message);
        ad.setCancelable(true);

        ad.setPositiveButton(positive, new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int id) {
                dialog.dismiss();
                if(listener != null) listener.onSelected(dialog, 1);
            }
        });

        ad.setNegativeButton(negative, new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int id) {
                dialog.dismiss();
                if(listener != null) listener.onSelected(dialog, 2);
            }
        });

        ad.setOnCancelListener(new AlertDialog.OnCancelListener() {
            @Override
            public void onCancel(DialogInterface dialog) {
                if(dialog != null) dialog.dismiss();
                if(listener != null) listener.onSelected(dialog, 0);
            }
        });

        ad.create();
        ad.show();
    }

    /**
     * YesNo Dialog Listener
     * 1 : positive, 2 : negative, 0 : cancel
     * */
    public interface yesNoDialogListener {
        void onSelected(DialogInterface dialog, int num);
    }

    /**
     * Option Dialog
     * @param activity
     * @param title
     * @param items
     * @param checkedIdx
     * @param listener
     */
    public static void optionDialog(Activity activity, String title, String[] items, int checkedIdx, final OptionDialogListener listener) {
        AlertDialog.Builder ad = new AlertDialog.Builder(activity);
        ad.setTitle(title);

        ad.setSingleChoiceItems(items, checkedIdx, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int item) {
                dialog.dismiss();
                if(listener != null) listener.onSelected(item);
            }
        });

        ad.create();
        ad.show();
    }

    /**
     * Option Dialog Listener
     * */
    public interface OptionDialogListener {
        void onSelected(int idx);
    }

    /**
     * OK Dialog
     * @param activity
     * @param title
     * @param message
     * @param listener
     * */
    public static void editDialog(Activity activity, String title, String message, final edDialogListener listener){
        final EditText et = new EditText(activity);

        et.setSingleLine(true);

        FrameLayout container = new FrameLayout(activity);

        FrameLayout.LayoutParams params = new  FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);

        params.leftMargin = activity.getResources().getDimensionPixelSize(R.dimen.edit_dialog_margin);

        params.rightMargin = activity.getResources().getDimensionPixelSize(R.dimen.edit_dialog_margin);

        et.setLayoutParams(params);

        container.addView(et);

        DialogInterface.OnClickListener positive = new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                if(listener != null) {
                    listener.onConfirm(et.getText().toString());
                }
            }
        };

        DialogInterface.OnClickListener cancel = new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        };

        final AlertDialog.Builder ad = new AlertDialog.Builder(activity);

        ad.setTitle(title);
        ad.setMessage(message);
        ad.setView(container);
        ad.setPositiveButton("확인", positive);
        ad.setNegativeButton("취소", cancel);

        AlertDialog alert = ad.create();

        alert.show();
    }

    /**
     * OK Dialog Listener
     * */
    public interface edDialogListener {
        void onConfirm(String edit);
    }
}
