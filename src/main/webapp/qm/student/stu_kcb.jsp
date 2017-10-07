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
    .kc1{
     height:85px;
     line-height:25px;
    background-color:#FCFFF5;
    }
    td{
    text-align:center;
     vertical-align:middle;
    }
    th{
    text-align:center;
    }
    tr{
       text-align:center;
    }
    .kc2{
    margin-top:-5%;
    height:85px;
     line-height:25px;
     background-color:#FFF6F6!important
    }
    .ui.table td{
    padding:0.2em 0 0 0.2em!important
    }
    .ui.divider{
    margin:0 0 12px 0!important;
    }
    .margintop{
    margin-top:4%!important;
     text-align:center;
    }

   .lefth5{
	float:left
	}
	#doubling{
margin-right:0em!important;
} 
</style>
</head>
<body>
<%@ include file="/commonjsp/header.jsp"%>
	<div id="container" class="ui container">
		<h3  class="ui header "> 
	  			<i class="ui unordered list icon"></i>
	  			本学期课表
		</h3>
	<div id="information">	
	</div>
		<table class="ui  celled table" >
		  <thead>
		    <tr>
		      <th  style="width:3%;"></th>
		      <th><h3>周一</h3></th>
		      <th><h3>周二</h3></th>
		      <th><h3>周三</h3></th>
		      <th><h3>周四</h3></th>
		      <th><h3>周五</h3></th>
		      <th><h3>周六</h3></th>
		      <th><h3>周日</h3></th>
		    </tr>
		  </thead>
		  <tbody>
		    <tr>
		      <td >第一节</td>
		      <td id="K11"></td>
		      <td id="K21"></td>
		      <td id="K31"></td>
		      <td id="K41"></td>
		      <td id="K51"></td>
		      <td id="K61"></td>
		      <td id="K71"></td>
		    </tr>
		    <tr>
		      <td style="text-align:center;">第二节</td>
		      <td id="K12"></td>
		      <td id="K22"></td>
		      <td id="K32"></td>
		      <td id="K42"></td>
		      <td id="K52"></td>
		      <td id="K62"></td>
		      <td id="K72"></td>
		    </tr>
		    <tr>
		      <td style="text-align:center;">第三节</td>
		      <td id="K13"></td>
		      <td id="K23"></td>
		      <td id="K33"></td>
		      <td id="K43"></td>
		      <td id="K53"></td>
		      <td id="K63"></td>
		      <td id="K73"></td>
		    </tr>
		    <tr>
		      <td style="text-align:center;">第四节</td>
		      <td id="K14"></td>
		      <td id="K24"></td>
		      <td id="K34"></td>
		      <td id="K44"></td>
		      <td id="K54"></td>
		      <td id="K64"></td>
		      <td id="K74"></td>
		    </tr>
		        <tr>
		      <td style="text-align:center;">晚自习</td>
		      <td id="K15"></td>
		      <td id="K25"></td>
		      <td id="K35"></td>
		      <td id="K45"></td>
		      <td id="K55"></td>
		      <td id="K65"></td>
		      <td id="K75"></td>
		    </tr>
		  </tbody>
		</table>
		<div class="ui segement" id="traningCourse">
		    <div class="ui two doubling cards" id="doubling">
		   </div>	
		</div>

	</div>
	<!--这里绘制页面-->
</body>
<script>
$(function(){

	var SYSOBJCET=<%=SYSOBJCET%>; 
	var USEROBJECT=<%=USEROBJECT%>; 
	loadinformation();
	loading();
	function loadinformation(){
		$.ajax({
			url:"do?invoke=studentKcb@getclassinformation",
			type:'POST',
			dataType:'json',
			data:{      
				class_no:USEROBJECT.userinfo.class_no,
			},
			success:function(rep){
				var dom='当前学年:'+SYSOBJCET.term_name+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;班级:'+USEROBJECT.userinfo.class_name+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;专业:'+rep.data[0].major_name+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;第:'+SYSOBJCET.currentweek+'周';
			$('#information').append(dom);
			}
		});
	}
	function loading(){
		$.ajax({
			url:"do?invoke=studentKcb@getStuClassno",
			type:'POST',
			dataType:'json',
			data:{
				term_no:SYSOBJCET.term_no,       
				class_no:USEROBJECT.userinfo.class_no,
				stu_no:USEROBJECT.loginname
			},
			success:function(rep) {
				if(rep.result==0){
					$('#container').empty();
					var dom='<div class="ui green large message">'+
					'<i class="frown large inverted yellow circular icon"></i> 抱歉！查询不到您本学期的课程。 '+
				'</div>';
					$('#container').append(dom);
				}
				
				else{
				var deom=rep.data;
				console.log(deom)
				var course_name=[];
				var course_week=[];
				var teacher_name=[];
						var header = '<h5  class="ui header ">'+
								  			'本学期实训课信息:'+
								     '</h5>';
			                 $('#traningCourse').prepend(header);
				for(var i=0;i<deom.length;i++)
				{
				if(deom[i].sche_set=='K99' ||deom[i].sche_set=='' || deom[i].sche_set=='          '){
					course_name.push(deom[i].course_name);
				      course_week.push(deom[i].course_week);
					teacher_name.push(deom[i].teacher_name);
						var dom ='<div class="ui  card" >';
						if(deom[i].total==""){
							dom+='<div class="ui dimmer eee">'+
						     '<div class="content">'+
						        '<div class="center">';
						           dom+='<p class="pj" task_no="'+deom[i].task_no+'" flag="0">参加评教</p>';
						             dom+=  '<p>&nbsp</p> <p class="kq" task_no="'+deom[i].task_no+'">查看考勤</p>'+ 
						            '</div>'+
						        '</div>'+
						        '</div>';
						}else{
							dom+='<div class="ui dimmer eee">'+
						     '<div class="content">'+
						        '<div class="center">';
						        dom+='<p class="pj" task_no="'+deom[i].task_no+'" flag="1">修改评教</p>';
						             dom+=  '<p>&nbsp</p> <p class="kq" task_no="'+deom[i].task_no+'">查看考勤</p>'+ 
						            '</div>'+
						        '</div>'+
						        '</div>';
						}
			            dom+='<div class="content">'+
			              '<h5 class="ui header">课程名称:'+deom[i].course_name+'</h5>'+
			            '</div>'+
			            '<div class="extra content">'+
			              '<div><h5 class="lefth5 ui header" >上课时间:</h5>&nbsp'+deom[i].course_week+'周 </div>'+
			            '</div>'+
			            '<div class="extra content">'+
			              '<div><h5 class="lefth5 ui header" >任课教师:</h5>&nbsp'+deom[i].teacher_name+' </div>'+
			            '</div>';
							dom+='</div>';
							$('#doubling').append(dom);
				  }
				else{
				if(  $('#'+deom[i].sche_set+'').text()==""){
					   if(deom[i].total==''){
					  var dam='<div class="kc kc1">'+
					   '<div class="ui dimmer eee">'+
					     '<div class="content">'+
					        '<div class="center">';
					           dam+='<p class="pj" task_no="'+deom[i].task_no+'" flag="0">参加评教</p>';
					             dam+=  '<p>&nbsp</p> <p class="kq" task_no="'+deom[i].task_no+'">查看考勤</p>'+ 
					            '</div>'+
					        '</div>'+
					        '</div>'+
					  '<div class="margintop"><div>'+deom[i].course_name+'</div>'+
					  '<div>['+deom[i].course_week+']</div>'+
					  '<div>'+deom[i].teacher_name+'&nbsp&nbsp'+deom[i].sche_addr+'</div>'+
					        '</div>'+
					    '</div>';
					   }else{
						   var dam='<div class="kc kc2">'+
							   '<div class="ui dimmer eee">'+
							     '<div class="content">'+
							        '<div class="center">';
							        dam+='<p class="pj" task_no="'+deom[i].task_no+'" flag="1">修改评教</p>';
							             dam+=  '<p>&nbsp</p> <p class="kq" task_no="'+deom[i].task_no+'">查看考勤</p>'+ 
							            '</div>'+
							        '</div>'+
							        '</div>'+
						   '<div class="margintop"><div>'+deom[i].course_name+'</div>'+
							  '<div>['+deom[i].course_week+']</div>'+
							  '<div>'+deom[i].teacher_name+'&nbsp&nbsp'+deom[i].sche_addr+'</div>'+
							        '</div>'+
							    '</div>';						
					        }
					   $('#'+deom[i].sche_set+'').append(dam);
				}
						 else{
							 if(deom[i].total==''){
								  var dam='<div class="ui divider"></div><div class="kc kc1">'+
								   '<div class="ui dimmer eee">'+
								     '<div class="content">'+
								        '<div class="center">';
								           dam+='<p class="pj" task_no="'+deom[i].task_no+'" flag="0">参加评教</p>';
								             dam+=  '<p>&nbsp</p> <p class="kq" task_no="'+deom[i].task_no+'">查看考勤</p>'+ 
								            '</div>'+
								        '</div>'+
								        '</div>'+
								  '<div class="margintop"><div>'+deom[i].course_name+'</div>'+
								  '<div>['+deom[i].course_week+']</div>'+
								  '<div>'+deom[i].teacher_name+'&nbsp&nbsp'+deom[i].sche_addr+'</div>'+
								        '</div>'+
								    '</div>';
								   }else{
									   var dam='<div class="ui divider"></div><div class="kc kc2">'+
										   '<div class="ui dimmer eee">'+
										     '<div class="content">'+
										        '<div class="center">';
										        dam+='<p class="pj" task_no="'+deom[i].task_no+'" flag="1">修改评教</p>';
										             dam+=  '<p>&nbsp</p> <p class="kq" task_no="'+deom[i].task_no+'">查看考勤</p>'+ 
										            '</div>'+
										        '</div>'+
										        '</div>'+
									   '<div class="margintop"><div>'+deom[i].course_name+'</div>'+
										  '<div>['+deom[i].course_week+']</div>'+
										  '<div>'+deom[i].teacher_name+'&nbsp&nbsp'+deom[i].sche_addr+'</div>'+
										        '</div>'+
										    '</div>';						
								        }
					         $('#'+deom[i].sche_set+'').append(dam);
						} 
						}
					}
				creatTraningCourse(course_name,course_week,teacher_name,deom);
				$('.pj').bind('click',function(){
					var task_no=$(this).attr('task_no');
					var flag=$(this).attr('flag');
					 location.href=BASE_PATH+"/qm/student/stu_comment.jsp?task_no="+task_no+"&flag="+flag+"&kcb=1&module=14"
				});
				$('.kq').bind('click',function(){
					var task_no=$(this).attr('task_no');
					 location.href=BASE_PATH+"/qm/student/person_checking.jsp?task_no="+task_no+"&module=14&menu=45"
				});
					$('.eee')
					  .dimmer({
						  opacity:'0.7',
						  transition:'horizontal flip',
						  duration    : {
							  show : 1000,
							},
					    on: 'hover'
					  })
					;
					 	$('.pj').hover(function(){
							$(this).css("cursor","pointer");
						});
						$('.kq').hover(function(){
							$(this).css("cursor","pointer");
						}); 
			}
			}
		});
	}
	function creatTraningCourse(course_name,course_week,teacher_name,deom){
	/* 	if(course_name==""){
			return ;
		}else{
			var header = '<h5  class="ui header ">'+
					  			'本学期实训课信息:'+
					     '</h5>';
                 $('#traningCourse').append(header);
		}
		for(var i = 0,len=course_name.length;i<len;i++){
			var dom ='<div class="ui  card" >'+
            '<div class="content">'+
              '<h5 class="ui header">课程名称:'+course_name[i]+'</h5>'+
            '</div>'+
            '<div class="extra content">'+
              '<div><h5 class="lefth5 ui header" >上课时间:</h5>&nbsp'+course_week[i]+' </div>'+
            '</div>'+
            '<div class="extra content">'+
              '<div><h5 class="lefth5 ui header" >任课教师:</h5>&nbsp'+teacher_name[i]+' </div>'+
            '</div>';
				dom+='</div>';
				$('#traningCourse').append(dom);
		} */
	}
});
</script>
<!--这里引用其他JS-->
</html>