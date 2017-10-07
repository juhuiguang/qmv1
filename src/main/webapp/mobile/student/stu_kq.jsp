<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <title>我的缺勤</title>
	<%@ include file="../common/header.jsp" %>
	
    <style type="text/css">
    	.header{
    		height:0.9138rem;
    	   	padding-top:0.1rem;
    		padding-left:0.2rem;
    		font-size:0.35rem; 
    	}
    	#table_form{
    	 margin:0.3rem 0.2rem;
    	 width:90%;
    	 } 
    
    	 
    	 
    	.status{
    	color:#db2828;
    	font-weight:bold;
    	}
    	th{
    	    font-size:1.1em;
            text-align:center;
            padding-top:2px;
            padding-bottom:1px;
    	}
    	td{
    	    font-size:1.1em;
            text-align:center;
            padding-top:2px;
            padding-bottom:1px;
    	}
    	#data{
    		
    	}
    	.title{
    		margin-left:0.3rem;
    		margin-bottom:0.2rem;
    		font-size:110%;
    	}
    	.title label{
    		font-weight:600;
    	}
    	#marked_words{
    	color:#1ebc30;
    	text-align:center;
    	line-height:40px;
    	}
    	#foot{
    	background-color:#2c4041;
    	}
    </style>
     <link rel="stylesheet" href="mobile/common/fa/css/font-awesome.min.css"/>
     <script src="script/common/jquery/jquery.cookie.js" type="text/javascript"></script>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
String  teacher_name = "";
String  course_name = "";
String  task_no = "";
if (request.getParameter("teacher_name") != null) {
	teacher_name =request.getParameter("teacher_name");
	teacher_name= new String(request.getParameter("teacher_name").getBytes("ISO8859-1"),"UTF-8");
} 
if (request.getParameter("course_name") != null) {
	course_name = request.getParameter("course_name");
	course_name= new String(request.getParameter("course_name").getBytes("ISO8859-1"),"UTF-8");
} 
if (request.getParameter("task_no") != null) {
	task_no =request.getParameter("task_no");
} 

%>
	<!-- fixed定位的头部 -->
	<div class="header" id="header">
    	我的缺勤统计
    </div>
    <!-- 可以滚动的区域 -->
   	<div class="main dragloader" style="top:53px;top:0.9138rem;">
   		<div class="wrapper clearfix tab-content tab-checked" id="All">
   		<div id="data">
   			<div id = "title" class="title">
   			</div>
   			<div id = "title2" class="title">
   			</div>
   			<div id = "title3" class="title">
   			</div>
   		</div>
   		<table border="1"  id="table_form">
   		<thead id="table_form_">
   		<tr>
   		<th >  &nbsp;编 号 &nbsp;  </th>
   		<th >  &nbsp;周 次 &nbsp; </th>
   		<th >  &nbsp;星 期 &nbsp; </th>
   		<th >  &nbsp;节 次 &nbsp; </th>
   		<th >  &nbsp;状 态 &nbsp; </th>
   		</tr>
   		</thead>
   		<tbody id="check_data">
   		</tbody>
   		</table>

   		<div id="marked_words"><h2><i class="fa fa-thumbs-o-up"></i>&nbsp;&nbsp;中国好学生，无缺勤记录！</h2></div>
   		</div>
		<div class="wrapper clearfix tab-content" id="Qy"></div>
	</div>
		<div class="footer">
		<div class="row tabs" style="">
			<div class="tab tab-checked flex-center" content="#All" id="foot">
				<div>
					<div class="size16 txt" ><i class="fa fa-mail-reply"></i>&nbsp;点击返回</div>
				</div>
			</div>
		</div>
    </div>
    <script type="text/javascript">
    $(function(){
		var len= "";
        var teacher_name = '<%=teacher_name%>';
        var course_name = '<%=course_name%>' ;
    	var task_no = '<%=task_no%>';
    	console.log(teacher_name);
    	console.log(course_name);
    	var dom_course='<label id="dom_course"><i class="fa fa-book">&nbsp;课程：'+course_name+'  '+teacher_name+'</label>';
     	var dom_term = '<label id="dom_term"><i class="fa fa-history">&nbsp;学期： '+SYSOBJCET.term_name+'</label>';
    	var dom_week='<label id="dom_week"><i class="fa fa-location-arrow">&nbsp;周次：第'+SYSOBJCET.currentweek+'周</label>';
    	$('#title').append($(dom_course));
    	$('#title2').append($(dom_term));
    	$('#title3').append($(dom_week));
    	loadperson_checking();
		function loadperson_checking() {
			$.ajax({//获取个人本学期所有的缺勤记录
				url: "do?invoke=student_checking_inquire@get_checking_person_coursename",
				type: 'POST',
				dataType: 'json',
				data: {
					stu_no:USEROBJECT.loginname, 
					term_no:SYSOBJCET.term_no,
					task_no:task_no,
				},
				success: function(rep) {
						var person_checking=rep.data;
						console.log(person_checking.length);
						if(person_checking.length==0){
							len = "0";
							console.log(rep);
							if(len=="0"){
								console.log(len);
								$('#table_form').hide();
							}
						}else{
							$('#marked_words').hide();
							for(var i=0;i<person_checking.length;i++){
									var dom_person = '<tr>' +
									'<td>' + (i+1) + '</td>' +
									'<td>第&nbsp;' + person_checking[i].check_week + '&nbsp;周</td>';
									if (person_checking[i].sche_set.substring(1, 2) == 1) {
										dom_person += '<td>一</td>';
									} else if (person_checking[i].sche_set.substring(1, 2) == 2) {
										dom_person += '<td>二</td>';
									} else if (person_checking[i].sche_set.substring(1, 2) == 3) {
										dom_person += '<td>三</td>';
									} else if (person_checking[i].sche_set.substring(1, 2) == 4) {
										dom_person += '<td>四</td>';
									} else if (person_checking[i].sche_set.substring(1, 2) == 5) {
										dom_person += '<td>五</td>';
									} else if (person_checking[i].sche_set.substring(1, 2) == 6) {
										dom_person += '<td>六</td>';
									} else if (person_checking[i].sche_set.substring(1, 2) == 7) {
										dom_person += '<td>日</td>';
									} else {
										dom_person += '<td>实 训 课</td>';
									}
									if (person_checking[i].sche_set.substring(2, 3) == 1) {
										dom_person += '<td>1 , 2 节</td>';
									} else if (person_checking[i].sche_set.substring(2, 3) == 2) {
										dom_person += '<td>3 , 4 节</td>';
									} else if (person_checking[i].sche_set.substring(2, 3) == 3) {
										dom_person += '<td>5 , 6 节</td>';
									} else if (person_checking[i].sche_set.substring(2, 3) == 4) {
										dom_person += '<td>7 , 8 节</td>';
									} else if (person_checking[i].sche_set.substring(2, 3) == 5) {
										dom_person += '<td>晚 自 习</td>';
									} else {
										dom_person += '<td>无</td>';
									}
									dom_person+='<td class="status">' + person_checking[i].check_status + '</td>' +
									'</tr>';
								    $('#check_data').append($(dom_person));
								}	
						}
				}
			});
		}
		$("#foot").unbind('click').click(function(){
			window.history.back();
		});
    	 
    });
    


    </script>
</body>
</html>