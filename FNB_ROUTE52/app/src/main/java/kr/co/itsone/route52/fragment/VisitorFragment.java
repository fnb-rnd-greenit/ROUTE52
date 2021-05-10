package kr.co.itsone.route52.fragment;

import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;
import java.util.List;

import kr.co.itsone.route52.R;
import kr.co.itsone.route52.activity.VisitorChoiceActivity;
import kr.co.itsone.route52.adapter.VisitorAdapter;
import kr.co.itsone.route52.entity.VisitorEntity;

public class VisitorFragment extends Fragment {
    public String mCos;

    private List<VisitorEntity> arrVisitor = new ArrayList<>();
    private RecyclerView listACos;
    private VisitorAdapter visitorAdapter;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        LayoutInflater inflaterView = (LayoutInflater) getActivity().getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View view = inflaterView.inflate(R.layout.fragment_visitor, null);

        init(view);

        return view;
    }

    private void init(View v) {
        listACos = v.findViewById(R.id.list_visitor);
        listACos.setLayoutManager(new LinearLayoutManager(getContext()));

        visitorAdapter = new VisitorAdapter(getContext(), arrVisitor, new VisitorAdapter.ItemSelectedListener() {
            @Override
            public void onSelected(int idx) {
                for(int i=0; i<arrVisitor.size(); i++){
                    if(i == idx){
                        arrVisitor.get(i).setSelected(true);
                    }else{
                        arrVisitor.get(i).setSelected(false);
                    }
                }

                visitorAdapter.notifyDataSetChanged();

                ((VisitorChoiceActivity) getActivity()).setVisitor(arrVisitor.get(idx));
            }

            @Override
            public void onDoubleClicked(int idx) {
                for(int i=0; i<arrVisitor.size(); i++){
                    if(i == idx){
                        arrVisitor.get(i).setSelected(true);
                    }else{
                        arrVisitor.get(i).setSelected(false);
                    }
                }

                visitorAdapter.notifyDataSetChanged();

                ((VisitorChoiceActivity) getActivity()).setVisitor(arrVisitor.get(idx));

                ((VisitorChoiceActivity) getActivity()).visitorChoice();
            }
        });

        listACos.setAdapter(visitorAdapter);
    }

    public void setCos(String cos) {
        mCos = cos;
    }

    public void setVisitors(List<VisitorEntity> arr){
        try {
            arrVisitor.clear();

            for(VisitorEntity entity : arr) {
                if(entity.getCos().equals(mCos)) {
                    arrVisitor.add((VisitorEntity) entity.clone());
                }
            }

            visitorAdapter.setFilter(arrVisitor);
            visitorAdapter.notifyDataSetChanged();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void clearSelected() {
        try {
            for (int i = 0; i < visitorAdapter.filterItems.size(); i++) {
                visitorAdapter.filterItems.get(i).setSelected(false);
            }

            visitorAdapter.notifyDataSetChanged();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void filter(String charText, String part) {
        try {
            visitorAdapter.filter(charText, part);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
