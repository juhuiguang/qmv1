<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>
<script src="script/common/datepicker/jquery.datetimepicker.js" type="text/javascript"></script>
<link rel="stylesheet" href="script/common/datepicker/jquery.datetimepicker.css" />
<title>校内教学质量监控运行平台</title>
<style>
	#ClassPJTabelDiv {
		margin-top: 10px;
	}
	#course_fx {
		display: inline-block;
	    width: auto;
	    vertical-align: baseline;
	    font-size: .92857143em;
	    font-weight: 700;
	    color: rgba(0,0,0,.87);
	    text-transform: none;
	    margin-left: 15px;
	    margin-bottom: 8px;
	}
	.ui.active.button {     
		color: white !important;
		background-color: #47A2FD !important;   
	}
</style> 
   
</head>   
<body>
<%@ include file="/commonjsp/header.jsp"%>
	<div id="container">
	    <h3 class="ui header"> 
		  <i class="tasks icon"></i>
		  <div class="content">班级评教情况 </div>   
		</h3> 

		<div id="ContentDiv">
			<select class="ui mini dropdown" id="dropdown">
			</select>
			
			<div id="ClassPJTabelDiv">
				<div id="moreClass"></div>
				<table class="ui blue striped table" id="PJTable"> 
					<thead>
					    <tr>
						    <th>课程名称</th> 
						    <th>任课教师</th> 
						    <th>班级人数</th>
						    <th>已评人数</th>
						    <th>查看详情</th>
					    </tr>
					    </thead>
					    <tbody id="ClassPJInfor">
					    
					    </tbody>
				</table>
			</div>
		</div>

		
		<div id="modPJdetail" class="ui modal">       
			  <div class="header">
				未评教学生名单
			    <i class="close icon" style="float: right;"></i>
			  </div>
			  <div class="content">
			  	<div class="description" id="PJdetailContent">
			  		<i class="user icon"></i> <i id="noPJscount"></i>
			  		<table class="ui striped table">
			 			<thead>
					    	<tr>        
			      				<th>学生姓名</th> 
			      				<th>学生学号</th> 
			    			</tr>
		 	 			</thead>
		 	 			<tbody id="noPJTable">  
					    
					    </tbody>
					</table> 			  
			    </div>
			  </div>
		</div>
		
	</div>
	<!--这里绘制页面-->
</body> 
<script>  
	$(function() {
		var termid= SYSOBJCET.term_no; 
		var userType=USEROBJECT.usertype; 
		var bj = "**";
		var flag = "**";
		var class_no = "**";
		
		CXclasses();
		function CXclasses() {
			$.ajax({
				url:"do?invoke=classViewComment@getClasses",  
				type:'POST',  
				dataType:'json',
				async: false,
				data:{
					userno:USEROBJECT.loginname
				},
				success:function(rep) {
					console.log(rep.data);
					if(rep.result==0) {
						$("#ContentDiv").remove();
						var tep = 
							'<div class="ui message" id="tipMessage">'+
								'<i class="announcement large inverted yellow up circular icon"></i>'+
								'您不是信息员或班主任，暂无权限查看此页面！'+
							'</div>';
						$("#container").append($(tep));
						return;
						
					} else {
						$("#tipMessage").remove();
						bj = "1";
						judgeClassInfor(rep.data);
					}
				}
			});
		}   
		
		function judgeClassInfor(classD) {
			if(userType != "学生" && bj == "1") {  
				//班主任
				flag = "1";
				if(classD.length >1) {
					//多个班级
					var tep = 
						'<label id="course_fx">您所带领的班级如下：</label>'+
						'<button class="ui mini button active" id="'+classD[0].class_no+'">'+classD[0].class_name+'</button>';
						for(var j=1; j<classD.length; j++) {
							tep +=
								'<button class="ui mini button" id="'+classD[j].class_no+'">'+classD[j].class_name+'</button>';
						}
					$("#moreClass").append($(tep));
					class_no = $('.ui.button.active').attr("id");
					$('.ui.button').unbind('click').click(function(){
						$('.ui.button.active').removeClass("active");
						$(this).addClass("active");    
						class_no = $(this).attr("id");
						getClassPJData(flag);   
					});
				} else {
					//一个班级
					console.log("yg");
                    class_no=classD[0].class_no;
				}
			} else if(userType == "学生" && bj == "1") {
				//信息员
				flag = "0";
			}
			downAllTerm();
			getClassPJData(flag);
		}
		
		
		function getClassPJData(flag) {
			$("#PJTable").show();  
			$("#ClassPJInfor").empty();
			$("#tipMessage").remove();  
			if(flag == "1") {
				var userno = class_no;
			} else if(flag == "0") {
				var userno = USEROBJECT.loginname;
			}
			console.log(userno);  
			$.ajax({
				url:"do?invoke=classViewComment@getClassPJD",  
				type:'POST',  
				dataType:'json',
				data:{
					termno:termid,
					userno:userno,   
					flag:flag
				},
				success:function(rep) {
					console.log(rep);   
					if(rep.result==0) { 
						$("#PJTable").hide();
						var tep =
							'<div class="ui message" id="tipMessage">'+
								'<i class="announcement large inverted yellow up circular icon"></i>'+
								'很抱歉，暂未查询到此学期本班级的班级评教数据！'+
							'</div>';
						$("#ClassPJTabelDiv").append($(tep));
						return;
						
					} else{
						var pjData = rep.data;
						for(var i=0; i<pjData.length; i++) {    
							var table = 
								'<tr>'+   								  
							     	'<td>'+pjData[i].course_name+'</td>'+ 
							     	'<td>'+pjData[i].teacher_name+'</td>'+  
							      	'<td>'+pjData[i].class_stu_amount+'</td>'+ 
							     	'<td>'+pjData[i].pj_count+'</td>';
							     	if(pjData[i].pj_count == pjData[i].class_stu_amount) {
							     		table +=
							     			'<td>'+
							     				'已评完'+
							     			'</td>';
							     	} else {
							     		table += 
								     		'<td>'+ 
										     	'<div class="btnfirst circular ui small blue basic icon button" taskno="'+pjData[i].task_no+'" classno="'+pjData[i].class_no+'">'+
						                     		'<i class="file text icon"></i>'+
							                 	'</div>'+   
									   	    '</td>';
							     	}
							     	table +=    
						   	 	'</tr>';
						    $("#ClassPJInfor").append($(table));
						}   
						 
						$('.btnfirst.circular').unbind('click').click(function() {
							var taskno = $(this).attr("taskno");
							var classno = $(this).attr("classno");   
							console.log(taskno);
							console.log(classno);  
							
							//评教详情弹出层
							showModelPage(taskno,classno);
						});
					}
						
				}
	
			}); 
		}
		
		
		function showModelPage(taskno,classno) {
			$.ajax({
				url:"do?invoke=classViewComment@getClassPJDetailD",  
				type:'POST',  
				dataType:'json',
				data:{
					taskno:taskno,  
					classno:classno, 
					termno:termid
				},
				success:function(rep) { 
					console.log(rep);  
					if(rep.result==0) { 
						return;
						
					} else {
						$("#noPJTable").empty();
						var pjdetailD=rep.data;
						$("#noPJscount").text("未评教总人数 ："+pjdetailD.length); 
						for(var i=0; i<pjdetailD.length; i++){
							var dom =
								'<tr class="pjtrD">'+
							     	 '<td>'+ pjdetailD[i].stu_name +'</td>'+ 
							     	 '<td>'+ pjdetailD[i].stu_no +'</td>'+       
							   	 '</tr>';
							$("#noPJTable").append($(dom));
						} 
						$("#modPJdetail").modal({
			 				transition:'slide down',
			 				observeChanges:true,
			 				closable:false
			 			 }).modal('show');
					}
				}
			});
		}

		
		
	    function downAllTerm(){
	    	$.ajax({
				url:"do?invoke=supervisorViewListen@getAllTerm",
				type:'POST',
				dataType:'json',
				success:function(rep){
					if(rep.result==0){
						$.alert("",rep.message);
						return;
					} else {
						var temp=rep.data;
						for(var i=0;i<temp.length;i++){
							var dom= '<option value="'+temp[i].term_no+'">'+temp[i].term_name+'</option>';
							$("#dropdown").prepend(dom);
						}
						$('.ui.dropdown').dropdown();
					}
					$("#dropdown").change(function(){
						termid=$("#dropdown").val();       
						console.log("aaaa"+termid);
						getClassPJData(flag);           
					});
				}  
	    	});       
	    }   


	});

</script>
<!--这里引用其他JS-->
</html>