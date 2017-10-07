package com.service.teacher;

import com.alibaba.druid.util.IOUtils;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jhg.db.ExecResult;
import com.jhg.mvc.Action;

import java.io.IOException;

/**
 * Created by 橘 on 2016/12/31.
 */
public class TeacherDepCommentAction extends Action {
    public void getCommentList(){
        //String teacher_no=request.getParameter("teacher_no");
        String jsonBody = null;
        try {
            jsonBody = IOUtils.read(request.getInputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
        JSONObject form = JSONObject.parseObject(jsonBody);
        String term_no=form.getString("term_no");
        TeacherDepCommentService service=new TeacherDepCommentService();
        ExecResult result=service.getCommentList(term_no,form.getString("teacher_no"));
        try {
            response.getWriter().write(result.toString());
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public void postComment(){
        String jsonBody = null;
        try {
            jsonBody = IOUtils.read(request.getInputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
        JSONObject form = JSONObject.parseObject(jsonBody);
        String jgh=form.getString("teacher_no");
        String term_no=form.getString("term_no");
        JSONArray content=form.getJSONArray("content");
        TeacherDepCommentService service=new TeacherDepCommentService();
        ExecResult result=service.postComment(term_no,jgh,content);
        try {
            response.getWriter().write(result.toString());
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public void getCommentStat(){
        String jsonBody = null;
        try {
            jsonBody = IOUtils.read(request.getInputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
        JSONObject form = JSONObject.parseObject(jsonBody);
        String term_no=form.getString("term_no");
        TeacherDepCommentService service=new TeacherDepCommentService();
        ExecResult result=service.getCommentStat(term_no);
        try {
            response.getWriter().write(result.toString());
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}
