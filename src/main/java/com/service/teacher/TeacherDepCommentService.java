package com.service.teacher;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.response.JSONResponse;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by 橘 on 2016/12/31.
 */
public class TeacherDepCommentService {
    public ExecResult getCommentList(String term_no,String teacher_no){
        String sql="SELECT  " +
                "  '"+teacher_no+"' teacher_no, " +
                "  a.dep_no, " +
                "  a.dep_name, " +
                "  a.dep_type, " +
                "  IFNULL(lj.`per11`, 0) per11, " +
                "  IFNULL(lj.`per12`, 0) per12, " +
                "  IFNULL(lj.`per13`, 0) per13, " +
                "  IFNULL(lj.`per14`, 0) per14, " +
                "  IFNULL(lj.total, 0) total " +
                "FROM " +
                "  base_department a  " +
                "  LEFT JOIN qm_teacher_depcomment lj  " +
                "    ON lj.dep_no = a.dep_no  " +
                "    AND lj.teacher_no = '"+teacher_no+"'  and lj.term_no='"+term_no+"' " +
                "WHERE (a.dep_no=(SELECT dep_no FROM base_teacher WHERE teacher_no='"+teacher_no+"') AND a.`dep_type`='教学') " +
                "OR (a.`dep_type`='行政') " +
                "ORDER BY dep_sort ";
        JSONResponse jr=new JSONResponse();
        return jr.getSelectResult(sql,null,"comments");
    }

    public ExecResult postComment(String term_no,String jgh, JSONArray comments){
        List<String> sqls=new ArrayList<String>();
        for(int i=0;i<comments.size();i++){
            JSONObject item=comments.getJSONObject(i);
            sqls.add("INSERT INTO qm_teacher_depcomment(term_no,teacher_no,dep_no,per11,per12,per13,per14,total) " +
                    " VALUES ('"+term_no+"','"+jgh+"','"+item.getString("dep_no")+"',"+item.getInteger("per11")+","+item.getInteger("per12")+","+item.getInteger("per13")+","+item.getInteger("per14")+","+item.getInteger("total")+") " +
                    " ON DUPLICATE KEY UPDATE per11="+item.getInteger("per11")+",per12="+item.getInteger("per12")+",per13="+item.getInteger("per13")+",per14="+item.getInteger("per14")+",total="+item.getInteger("total"));
        }
        JSONResponse jr=new JSONResponse();
        return jr.getExecResult(sqls,"执行成功","执行失败");
    }

    public ExecResult getCommentStat(String term_no){
        String sql="SELECT a.dep_type,a.dep_no,a.dep_name,COUNT(DISTINCT lj1.teacher_no) teacher_count,COUNT(DISTINCT lj.teacher_no) comment_count,ROUND(AVG(lj.total),2) score FROM base_department a " +
                " LEFT JOIN qm_teacher_depcomment lj ON lj.`dep_no`=a.`dep_no` AND lj.term_no='"+term_no+"'" +
                " LEFT JOIN qm_dep_teacher lj1 ON lj1.dep_no=a.dep_no AND lj1.term_no='"+term_no+"'" +
                " GROUP BY a.dep_type,a.dep_no,a.dep_name ORDER BY a.dep_type,ROUND(AVG(lj.total),2) DESC";
        JSONResponse jr=new JSONResponse();
        return jr.getSelectResult(sql,null,"stat");
    }

}
