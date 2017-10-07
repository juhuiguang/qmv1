<%@ page language="java" import="java.util.*" pageEncoding="GB2312"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <title>�ҵ�ȱ��</title>
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
	<!-- fixed��λ��ͷ�� -->
	<div class="header" id="header">
    	�ҵ�ȱ��ͳ��
    </div>
    <!-- ���Թ��������� -->
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
   		<th >  &nbsp;�� �� &nbsp;  </th>
   		<th >  &nbsp;�� �� &nbsp; </th>
   		<th >  &nbsp;�� �� &nbsp; </th>
   		<th >  &nbsp;�� �� &nbsp; </th>
   		<th >  &nbsp;״ ̬ &nbsp; </th>
   		</tr>
   		</thead>
   		<tbody id="check_data">
   		</tbody>
   		</table>

   		<div id="marked_words"><h2><i class="fa fa-thumbs-o-up"></i>&nbsp;&nbsp;�й���ѧ������ȱ�ڼ�¼��</h2></div>
   		</div>
		<div class="wrapper clearfix tab-content" id="Qy"></div>
	</div>
		<div class="footer">
		<div class="row tabs" style="">
			<div class="tab tab-checked flex-center" content="#All" id="foot">
				<div>
					<div class="size16 txt" ><i class="fa fa-mail-reply"></i>&nbsp;�������</div>
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
    	var dom_course='<label id="dom_course"><i class="fa fa-book">&nbsp;�γ̣�'+course_name+'  '+teacher_name+'</label>';
     	var dom_term = '<label id="dom_term"><i class="fa fa-history">&nbsp;ѧ�ڣ� '+SYSOBJCET.term_name+'</label>';
    	var dom_week='<label id="dom_week"><i class="fa fa-location-arrow">&nbsp;�ܴΣ���'+SYSOBJCET.currentweek+'��</label>';
    	$('#title').append($(dom_course));
    	$('#title2').append($(dom_term));
    	$('#title3').append($(dom_week));
    	loadperson_checking();
		function loadperson_checking() {
			$.ajax({//��ȡ���˱�ѧ�����е�ȱ�ڼ�¼
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
									'<td>��&nbsp;' + person_checking[i].check_week + '&nbsp;��</td>';
									if (person_checking[i].sche_set.substring(1, 2) == 1) {
										dom_person += '<td>һ</td>';
									} else if (person_checking[i].sche_set.substring(1, 2) == 2) {
										dom_person += '<td>��</td>';
									} else if (person_checking[i].sche_set.substring(1, 2) == 3) {
										dom_person += '<td>��</td>';
									} else if (person_checking[i].sche_set.substring(1, 2) == 4) {
										dom_person += '<td>��</td>';
									} else if (person_checking[i].sche_set.substring(1, 2) == 5) {
										dom_person += '<td>��</td>';
									} else if (person_checking[i].sche_set.substring(1, 2) == 6) {
										dom_person += '<td>��</td>';
									} else if (person_checking[i].sche_set.substring(1, 2) == 7) {
										dom_person += '<td>��</td>';
									} else {
										dom_person += '<td>ʵ ѵ ��</td>';
									}
									if (person_checking[i].sche_set.substring(2, 3) == 1) {
										dom_person += '<td>1 , 2 ��</td>';
									} else if (person_checking[i].sche_set.substring(2, 3) == 2) {
										dom_person += '<td>3 , 4 ��</td>';
									} else if (person_checking[i].sche_set.substring(2, 3) == 3) {
										dom_person += '<td>5 , 6 ��</td>';
									} else if (person_checking[i].sche_set.substring(2, 3) == 4) {
										dom_person += '<td>7 , 8 ��</td>';
									} else if (person_checking[i].sche_set.substring(2, 3) == 5) {
										dom_person += '<td>�� �� ϰ</td>';
									} else {
										dom_person += '<td>��</td>';
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