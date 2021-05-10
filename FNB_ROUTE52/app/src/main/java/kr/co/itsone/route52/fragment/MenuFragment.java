package kr.co.itsone.route52.fragment;

import android.content.Context;
import android.os.Bundle;
import android.os.Handler;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.google.firebase.crashlytics.FirebaseCrashlytics;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import kr.co.itsone.route52.R;
import kr.co.itsone.route52.activity.OrderWriteActivity;
import kr.co.itsone.route52.adapter.MenuAdapter;
import kr.co.itsone.route52.dialog.ImageDialog;
import kr.co.itsone.route52.entity.MenuDivisionEntity;
import kr.co.itsone.route52.entity.MenuEntity;
import kr.co.itsone.route52.util.AlertUtil;
import kr.co.itsone.route52.util.Utils;

public class MenuFragment extends Fragment {

    private int mMode = -1;
    public final int MODE_NORMAL = 1000;
    public final int MODE_SEARCH = 2000;

    private LinearLayout mMenuContainer;
    private String mMidDiv;
    private List<MenuDivisionEntity> mSmallDivs;

    private RecyclerView listMenu;
    private List<MenuEntity> mMenus = new ArrayList<>();
    private MenuAdapter menuAdapter;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        LayoutInflater inflaterView = (LayoutInflater) getActivity().getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View view = inflaterView.inflate(R.layout.fragment_menu, null);

        init(view);

        return view;
    }

    private void init(View v) {
        mMenuContainer = v.findViewById(R.id.linear_menu_header_container);

        if(mMode == MODE_NORMAL) {
            mSmallDivs = new ArrayList<>();

            for(MenuDivisionEntity tmp : ((OrderWriteActivity) getActivity()).mSmallDiv) {
                if(tmp.getMidCode().equals(mMidDiv)) {
                    try {
                        mSmallDivs.add((MenuDivisionEntity) tmp.clone());
                    } catch (CloneNotSupportedException e) {
                        e.printStackTrace();
                    }
                }
            }

            if(mSmallDivs.size() > 0) {
                mSmallDivs.get(0).setSelected(true);
            }

            initMenuHeader();
        } else if(mMode == MODE_SEARCH) {
            mMenuContainer.setVisibility(View.GONE);
        }

        listMenu = v.findViewById(R.id.list_menu);
        listMenu.setLayoutManager(new GridLayoutManager(getContext(), 2));
        //listMenu.setLayoutManager(new LinearLayoutManager(getContext()));

        menuAdapter = new MenuAdapter(getContext(), mMenus, new MenuAdapter.ItemAddListener() {
            @Override
            public void onPlus(int position) {
                try {
                    int cnt = mMenus.get(position).getOrderCnt() + 1;
                    mMenus.get(position).setOrderCnt(cnt);
                    menuAdapter.notifyDataSetChanged();

                    ((OrderWriteActivity) getActivity()).addMenu(mMenus.get(position));
                } catch(Exception e) {
                    AlertUtil.okDialog(getActivity(), getString(R.string.message_header), "메뉴 추가 중 오류가 발생하였습니다. 화면을 다시 열어주세요", new AlertUtil.okDialogListener() {
                        @Override
                        public void onOk() {
                            ((OrderWriteActivity) getActivity()).doSave();
                        }
                    });
                    FirebaseCrashlytics.getInstance().recordException(e);
                }
            }

            @Override
            public void onMinus(int position) {
                try {
                    int cnt = mMenus.get(position).getOrderCnt() - 1;
                    mMenus.get(position).setOrderCnt(cnt);
                    menuAdapter.notifyDataSetChanged();

                    ((OrderWriteActivity) getActivity()).addMenu(mMenus.get(position));
                } catch(Exception e) {
                    AlertUtil.okDialog(getActivity(), getString(R.string.message_header), "메뉴 추가 중 오류가 발생하였습니다. 화면을 다시 열어주세요", new AlertUtil.okDialogListener() {
                        @Override
                        public void onOk() {
                            ((OrderWriteActivity) getActivity()).doSave();
                        }
                    });
                    FirebaseCrashlytics.getInstance().recordException(e);
                }
            }

            @Override
            public void onImageView(String uri, String name, String price) {
                ImageDialog dialog = new ImageDialog(getContext());
                dialog.setImage(uri, name, Utils.moneyDecimalFormat(Integer.valueOf(price)));
                dialog.show();
            }

            @Override
            public void onDisSelected(int position, int idx, String value) {
                mMenus.get(position).setSlDcRateIdx(idx);
                mMenus.get(position).setSlDcRate(value);
            }

            @Override
            public void onSaleDivSelected(int position, int idx, String value) {
                mMenus.get(position).setSaleDivIdx(idx);
                mMenus.get(position).setSaleDiv(value);
            }

            @Override
            public void onEditMemo(int position, String memo) {
                mMenus.get(position).setMemo(memo);
                menuAdapter.notifyDataSetChanged();
            }
        });

        listMenu.setAdapter(menuAdapter);
    }

    private void initMenuHeader() {
        mMenuContainer.removeAllViews();

        for(int i=0; i<mSmallDivs.size(); i++) {
            LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.MATCH_PARENT);
            layoutParams.weight = 1;

            final int index = i;

            LayoutInflater inflaterView = (LayoutInflater) getActivity().getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            FrameLayout view = (FrameLayout) inflaterView.inflate(R.layout.item_menu_header, null);

            TextView txtMenu = view.findViewById(R.id.itm_txt_menu_header_name);
            ImageView imgMenu = view.findViewById(R.id.itm_img_menu_header_line);

            txtMenu.setText(mSmallDivs.get(i).getSmallName());
            if(mSmallDivs.get(i).isSelected()) {
                txtMenu.setTextColor(getResources().getColor(R.color.white));
                imgMenu.setVisibility(View.VISIBLE);

                setMenu(((OrderWriteActivity) getActivity()).mMenus, mSmallDivs.get(i).getSmallCode());
            } else {
                txtMenu.setTextColor(getResources().getColor(R.color.gray));
                imgMenu.setVisibility(View.GONE);
            }

            view.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    for(int i=0; i<mSmallDivs.size(); i++) {
                        if(i==index) {
                            mSmallDivs.get(i).setSelected(true);
                        } else {
                            mSmallDivs.get(i).setSelected(false);
                        }
                    }

                    initMenuHeader();
                }
            });

            mMenuContainer.addView(view, layoutParams);
        }
    }

    public void setMidDiv(String div) {
        mMidDiv = div;
    }

    public void setMode(int mode) {
        mMode = mode;
    }

    public void setKeyword(String keyword) {
        setSearchMenu(keyword);
    }

    public void setMenu(List<MenuEntity> menus, String division) {
        try {
            mMenus.clear();

            for (MenuEntity entity : menus) {
                if (entity.getSmallCode().equals(division)) {
                    mMenus.add(entity);
                }
            }

            //menuAdapter.notifyDataSetChanged();

            menuAdapter = new MenuAdapter(getContext(), mMenus, new MenuAdapter.ItemAddListener() {
                @Override
                public void onPlus(int position) {
                    int cnt = mMenus.get(position).getOrderCnt() + 1;
                    mMenus.get(position).setOrderCnt(cnt);
                    menuAdapter.notifyDataSetChanged();

                    ((OrderWriteActivity) getActivity()).addMenu(mMenus.get(position));
                }

                @Override
                public void onMinus(int position) {
                    int cnt = mMenus.get(position).getOrderCnt() - 1;
                    mMenus.get(position).setOrderCnt(cnt);
                    menuAdapter.notifyDataSetChanged();
                    ((OrderWriteActivity) getActivity()).addMenu(mMenus.get(position));
                }

                @Override
                public void onImageView(String uri, String name, String price) {
                    ImageDialog dialog = new ImageDialog(getContext());
                    dialog.setImage(uri, name, Utils.moneyDecimalFormat(Integer.valueOf(price)));
                    dialog.show();
                }

                @Override
                public void onDisSelected(int position, int idx, String value) {
                    mMenus.get(position).setSlDcRateIdx(idx);
                    mMenus.get(position).setSlDcRate(value);
                }

                @Override
                public void onSaleDivSelected(int position, int idx, String value) {
                    mMenus.get(position).setSaleDivIdx(idx);
                    mMenus.get(position).setSaleDiv(value);
                }

                @Override
                public void onEditMemo(int position, String memo) {
                    mMenus.get(position).setMemo(memo);
                }
            });

            listMenu.setAdapter(menuAdapter);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setSearchMenu(final String keyword) {
        try {
            OrderWriteActivity activity = (OrderWriteActivity) getActivity();

            if(activity == null) {
                new Handler().postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        setSearchMenu(keyword);
                    }
                }, 500);
            }

            mMenus.clear();

            String k = keyword.toLowerCase(Locale.getDefault());

            for (MenuEntity entity : ((OrderWriteActivity) getActivity()).mMenus) {
                if (entity.getPdCd().toLowerCase().contains(k) || entity.getPdName().toLowerCase().contains(k)) {
                    mMenus.add(entity);
                }
            }

            menuAdapter.notifyDataSetChanged();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void notifyDataSetChanged() {
        if(menuAdapter != null) {
            menuAdapter.notifyDataSetChanged();
        }
    }
}
