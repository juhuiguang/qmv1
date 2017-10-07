<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp" %>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp" %>
<!--这里引用其他样式-->
<title>欢迎使用-首页</title>
<style>
	.bq {
		display: inline-block; 
		width:auto;
	    vertical-align: baseline;  
	    font-size: .92857143em;
	    font-weight: 700;
	    color: rgba(0,0,0,.87); 
	    text-transform: none; 
	}
	.bq.coursename {
		margin-top: 15px;
    	margin-left: 11%;
	}
	.bq.planlist {
		margin-top: 15px;
    	margin-left: 42%; 
	}
	#CourseMenu {
		min-width: 33%;
	}
	#segmentPanel {
		top: 95px;
	    left: 34%; 
		display: inline-block; 
		width: 66%;  
		position:absolute; 
		overflow-y:auto;  
	} 
	h2.ui.header {
	    font-size: 1rem; 
	    color: #7B7B7B;
	}
	.bq3 { 
		display: inline-block;
	    width: auto;
	    vertical-align: baseline; 
	    font-size: .9em;
	    font-weight: 700;
	    color: rgba(0,0,0,.87);
	    text-transform: none;
	    margin-bottom: 8px;   
	    width: 43%;   
    	margin-left: 6%;
	}
	.bq2 { 
	    font-size: .91em;
	    font-weight: 600;
	    color: rgba(0,0,0,.87);
	}
	.see_down {
    	float: right !important;
		margin-right: 5% !important;
	}
	.unsee_down {
		float: right !important;
		margin-right: 5% !important; 
	}
	.ui.middle.list {
		margin-bottom: 10px;
	}
	.radio.icon {
		color: #EAE4E4;
		margin-right: 2%;
	}
	.radio.icon:hover {
		color: #000;
	}
	.check.circle.outline.icon {
		margin-right: 2%;
	}
	.trash.outline.icon {
		margin-right: 2%;
		color:#F58A8A;
	}
	.trash.outline.icon:hover {
		color:red;   
	}
	.NoCont {
		color:#AAAAA4;
		margin-left:2%;
	}
	.ui.blue.button.upload {
		float: right;
    	margin-top: 10px;
	}
	#CMessage {
		background: white;
	}
	.file.import {
	    display: inline-block;
	    background: #F3F4F5;
	    border-radius: 5px;
	    overflow: hidden;
	    color: #0A0A0A;
	    font-size: .95rem;
	    font-weight: 700;
	    padding: 10px;
	    margin-left: 5%;
	    width: 90%;
	}
	.ui.two.buttons {
		width: 85%;
    	margin-left: 7.5%;
	}
	.ui.button.choose.active {
		background: #00AFE6;
    	color: white;
	}
	.ui.toggle.button {
		margin-left: 90%;
	    margin-top: 10px;
	    background-color: #27BBE4;
	    color: white;
	}
</style> 
<script src="script/common/echarts/echarts-all.js"></script>
</head>
<body>
<%@ include file="/commonjsp/header.jsp"%>
	<div id="container" class="ui container"> 
	<div style="position:relative;">
		<h3  class="ui header "> 
	  			<i class="list layout icon"></i> 
	  			<div class="content">课程文件上传</div>
		</h3>
		
		<label class="bq coursename">所授课程名称</label>
		<label class="bq planlist">课程文件列表</label>
		<button class="ui mini blue button upload" id="UploadBut"> 上 传 </button>
		<div class="ui secondary vertical menu"  id="CourseMenu">
		</div>

		<div class="stretched column" id="segmentPanel">
			<div class="ui segment">
				<h2 class="ui right floated header oneself">文件名规范：（张三）计算机基础教学计划2016-2017-01</h2>
				<div class="ui clearing divider"></div>
				<div id="existCFiles">

				</div>
			</div>
		</div>

		
		<div id="modCourseFile" class="ui modal gr">      
			  <div class="header">
			    为该课程上传文件:
			    <i class="close icon" style="float: right;"></i>
			  </div>
			  <div class="content">
			  	<div class="description">
		  	 		<div class="ui message">
			  			<label class="bq3" id="C_no">课程代码：</label>
		  				<label class="bq3" id="C_name" style="margin-left: -8%;">课程名称：</label>    
		  			</div>
		  			
		  			<div class="two ui small buttons">
					  <button class="ui small button choose active" id="olds"> 该课程其它教师的文件 </button>
					  <button class="ui small button choose" id="news"> 点击上传新文件 </button>
					</div>
		  			
		  			<div class="ui message" id="CMessage">
						<form id="otherexistCFiles" action="qm/uploader.jsp" target="_blank" method="post" enctype="multipart/form-data">
							 
						</form>
					</div>
			    </div>
			  </div>
		</div>
		
	<!--这里绘制页面-->
	</div>
	</div>
</body>
<script src="script/common/alert/jquery.alert.js" type="text/javascript"></script>
<script>
	 $(function() {
		 var termid= SYSOBJCET.term_no; 
		 var usertype=USEROBJECT.usertype; 
		 var user=USEROBJECT.loginname
		 var CourseListD = "";
		 var SinglCFileInfor = "";
		 var SinglCFileInforOwn = "";
		 var course_no = "";
		 var course_name = "";
         $('.tabular.menu .item').tab();
		 if(usertype == "教师" ||usertype.indexOf("教师")>=0){
			//获取当前登录教师的所有课程
			 readLoginTeaAllCourse();
		 } else {
			 $.alert("很抱歉，您不是教师身份，暂无课程文件可显示！");
		 }
         
		 function readLoginTeaAllCourse() {
			 $.ajax({
				 url: "do?invoke=TeaUploadCoursePlan@getTeaAllCourseData",
				 type: 'POST',
				 dataType: 'json',
				 data:{
					 termno:termid,
					 teano:USEROBJECT.loginname
				 },
				 success: function(rep) {
					 if(rep.result == 0) {
						 $.alert("暂未获取到该相关信息！"); 
						 return;
					 } else {
						 console.log(rep);   
						 CourseListD = rep.data; 
						 drawCourseList();
					 }
				 }
			 });
		 }
		 
		 function drawCourseList() {
			 var dom = "";
			 if(CourseListD[0].course_name.length > 15) {          
				 coursename= CourseListD[0].course_name.substring(0,14) + "...";  
				 dom += 
					 '<a class="item active" id="'+ CourseListD[0].course_no +'" name="'+CourseListD[0].course_name+'" data-content="'+CourseListD[0].course_name+'" data-variation="small">'+ coursename +'</a>';
			 } else { 
				 dom += 
					 '<a class="item active" id="'+ CourseListD[0].course_no +'" name="'+CourseListD[0].course_name+'">'+ CourseListD[0].course_name +'</a>';
			 }
			 for(var i=1; i<CourseListD.length; i++) {
				 if(CourseListD[i].course_name.length > 15) {          
					coursename= CourseListD[i].course_name.substring(0,14) + "...";  
					dom +=
						 '<a class="item" id="'+ CourseListD[i].course_no +'" name="'+CourseListD[i].course_name+'" data-content="'+CourseListD[i].course_name+'" data-variation="small">'+ coursename +'</a>';
				 } else { 
					 dom +=
						 '<a class="item" id="'+ CourseListD[i].course_no +'" name="'+CourseListD[i].course_name+'">'+ CourseListD[i].course_name +'</a>';
				 }
			 }
			 $("#CourseMenu").append($(dom));  
			 $('.item').popup();         
			 
			 course_no = CourseListD[0].course_no;
			 course_name = CourseListD[0].course_name;
			 $('#otherexistCFiles').attr('action','qm/uploader.jsp?teacher_no='+user+'&term_no='+termid+'&course_no='+course_no+'');
	/* 		 $("#SinglCoursePlanUpload").bind('click').click(function(){
				 $('form').submit();
					setTimeout(function(){
						ClickSinglCourseFileInfor();
					}, 1000);  

			 }); */
			 ClickSinglCourseFileInfor();         
			 
			 $('#CourseMenu .item').unbind('click').click(function(){
				 $('#CourseMenu .item.active').removeClass('active');
				 $(this).addClass('active');    
				 
				 course_no = $(this).attr("id");                     
				 course_name = $(this).attr("name");  
				 $('#otherexistCFiles').attr('action','qm/uploader.jsp?teacher_no='+user+'&term_no='+termid+'&course_no='+course_no+'');
				 
				 ClickSinglCourseFileInfor();
			 });          
			 
			 
		 }
		 
		 function ClickSinglCourseFileInfor() {
			 $("#existCFiles").empty();        
//			 $("#otherexistCFiles").empty();     
			 SinglCFileInfor = "";
			 SinglCFileInforOwn = "";       
			 $.ajax({
				 url: "do?invoke=TeaUploadCoursePlan@getSinglCourseAllFileData",
				 type: 'POST',
				 dataType: 'json',
				 data:{
					 termno:termid,
					 courseno:course_no,
					 teano:USEROBJECT.loginname       
				 },
				 success: function(rep) {
					 if(rep.other.result == 0 && rep.oneself.result == 0) { 
						 $("#existCFiles").append($('<p class="NoCont">暂无文件！</p>'));
						 drawModOtherCourseFileD();
			//			 return;      
					 } else {
						 console.log(rep);      
						 SinglCFileInfor = rep.other.data;   
						 SinglCFileInforOwn = rep.oneself.data;
					     drawSinglCourseFileD();
					     drawModOtherCourseFileD();
					     
					 }
				 }
			 });
		 }
		 
		 function drawModOtherCourseFileD() { 
			 $("#UploadBut").unbind('click').click(function() {
				 $("#modCourseFile").modal({
		 				transition:'slide down',
		 				observeChanges:true,
		 				closable:false 
		 		 }).modal('show'); 
				 $("#otherexistCFiles").empty();     
				 $("#C_no").text('课程代码：' + course_no );
				 $("#C_name").text('课程名称：' + course_name );
				 drawOldsPanel();
				 
			 });
		 }
		 
		 function Clickcircle(callback) {
			 $('.click.radio.icon').unbind('click').click(function(){
				 var fileno = $(this).attr("id");      
				 var fileurl = $(this).attr("fileurl");
				 var filename = $(this).attr("filename");
                 var filetype = $(this).attr("filetype");
				 AddThisCourseFilePlan(fileno,fileurl,filename,filetype);
				 
				 Clickcheck();  
			 });
		 }
		 
		function Clickcheck(callback) {  
			$('.click.check.circle.outline.icon').unbind('click').click(function(){
				 $('.click.check.circle.outline.icon').removeClass("check circle outline icon");
				 $(this).addClass("radio icon");         
				 Clickcircle();   
			 });
		}
		
		function drawOldsPanel() {
			$('.ui.small.button.choose.active').removeClass("active");
			$("#olds").addClass("active"); 
			var clickbj = "olds";  
			if(SinglCFileInfor == null || SinglCFileInfor == "") { 
				 $("#otherexistCFiles").append($('<p class="NoCont" style="margin-left: 6%;">暂无文件！</p>'));
			 } else {
				 for(var j=0; j<SinglCFileInfor.length; j++) {
					 var dom =
							'<div class="ui middle aligned selection list" id="'+SinglCFileInfor[j].file_id+'">'+
								'<div class="item" id="'+SinglCFileInfor[j].file_id+'">'+
									'<div class="bq2" style="margin-left: 5%;">';
										if(SinglCFileInfor[j].file_url == null || SinglCFileInfor[j].file_url == "") { 
											dom += 
												'<i class="unclick radio icon" filetype="'+SinglCFileInfor[j].filetype+'" id="'+SinglCFileInfor[j].file_id+'" data-content="该文件暂无地址，无法选择！"></i>';
										} else {
											dom +=
												'<i class="click radio icon" filetype="'+SinglCFileInfor[j].filetype+'" id="'+SinglCFileInfor[j].file_id+'" filename="'+SinglCFileInfor[j].file_name+'" fileurl="'+SinglCFileInfor[j].file_url+'" data-content="点击后该文件可复用~"></i>';
										}
										if(SinglCFileInfor[j].file_name.length >10) { 
											var filename= SinglCFileInfor[j].file_name.substring(0,9) + "...";   
											dom +=
													' 【 '+ SinglCFileInfor[j].filetype +' 】&nbsp;&nbsp;&nbsp;&nbsp;：&nbsp;&nbsp;'+
													'<span class="spanFileName" data-content="'+ SinglCFileInfor[j].file_name +'" data-variation="small">'+ filename +'</span>'+
													'&nbsp;&nbsp;&nbsp;&nbsp;（上传者：'+ SinglCFileInfor[j].teacher_name +'）';
										} else {
											dom +=  
													'【 '+ SinglCFileInfor[j].filetype +' 】&nbsp;&nbsp;&nbsp;&nbsp;：&nbsp;&nbsp;'+ SinglCFileInfor[j].file_name +'&nbsp;&nbsp;&nbsp;&nbsp;（上传者：'+ SinglCFileInfor[j].teacher_name +'）';
										}
										if(SinglCFileInfor[j].file_url == null || SinglCFileInfor[j].file_url == "") {
											dom +=
											'<div class="unsee_down mini circular ui white basic icon button" href="" data-content="暂无文件下载地址！" data-variation="small">'+ 
						                        '<i class="hide small icon"></i>'+      
							                '</div>';  
										} else {
											dom +=
											'<a class="see_down mini circular ui black basic icon button" href="" id="'+SinglCFileInfor[j].file_url+'" data-content="点击可下载文件" data-variation="small">'+
						                        '<i class="unhide black small icon"></i>'+      
							                '</a>';  
										}
										dom +=
									'</div>'+ 
								'</div>'+        
							 '</div>';
					 $("#otherexistCFiles").append($(dom));      
				 }
			 }
			$('.radio.icon').popup();
			 $('.circular.button').popup();   
			 $('.spanFileName').popup();    
			 $('.unsee_down.button').css({'cursor':'default'});    
			 $('.unclick.radio.icon').css({'cursor':'default','color':'#EAE4E4'});   
			 
			 $('.ui.small.button.choose').unbind('click').click(function(){
				 $('.ui.small.button.choose.active').removeClass("active");
				 $(this).addClass("active");
				 clickbj = $(this).attr("id");
				 console.log(clickbj);  
				 
				 $("#otherexistCFiles").empty();  
				 if(clickbj == "news") {
					 drawNewsPanel();
					 
				 } else if(clickbj == "olds") {
					 drawOldsPanel();
				 }
			 });
			 
			 $('.see_down.button').unbind('click').click(function(){
				 var fileurl = $(this).attr("id");
				 $(this).attr("href",fileurl);           
			 }); 
			 Clickcircle();
			
		}
		
		function drawNewsPanel() {
			var dom =
                '<select type="select" id="upfiletype" name="filetype" style="margin-bottom:10px;margin-left:50px;">'+
                	'<option value="1">授课计划</option>'+
                	'<option value="2">课程标准</option>'+

                '</select>'+
				'<a href="javascript:;" class="file import">'+
					'<input  type="file" name="uploadfile" id="CourseUploadPlan" />'+
				'</a>'+
				'<button type="submit" class="ui toggle mini button" id="SinglCoursePlanUpload"> 上 传 '+
				'</button>';   
			$("#otherexistCFiles").append($(dom));      
			
			$("#SinglCoursePlanUpload").unbind('click').click(function(){
			    var filetype=$("#upfiletype").val();
			    var f=$('form');
			    var pos=f[0].action.indexOf("filetype");
			    if(pos<0){
                    f[0].action=f[0].action+"&filetype="+filetype;
				}else{
                    f[0].action=f[0].action.substring(0,pos)+"&filetype="+filetype;
				}
				f.submit();
				setTimeout(function(){     
					ClickSinglCourseFileInfor();    
				}, 1000); 
			});
		}
		
		 function drawSinglCourseFileD() {
			 if(SinglCFileInforOwn == null || SinglCFileInforOwn == "") {
				 $("#existCFiles").append($('<p class="NoCont">暂无文件！</p>'));
			 } else {
				 if(SinglCFileInforOwn.length + SinglCFileInfor.length > 5) {
					 $('#segmentPanel').css({'height':'170%'}); 
				 }
				 for(var k=0; k<SinglCFileInforOwn.length; k++) {
					 var tep =
						 '<div class="ui middle aligned selection list" id="'+SinglCFileInforOwn[k].file_id+'">'+
							'<div class="item" id="'+SinglCFileInforOwn[k].file_id+'">'+
								'<div class="bq2">'+
									'<i class="trash outline icon" filetype="'+SinglCFileInforOwn[k].filetype+'" id="'+SinglCFileInforOwn[k].file_id+'" data-content="点击删除！"></i>';
									 if(SinglCFileInforOwn[k].file_name.length >20) {  
											var filename= SinglCFileInforOwn[k].file_name.substring(0,19) + "...";  
											tep +=
													' 【 '+ SinglCFileInforOwn[k].filetype +' 】&nbsp;&nbsp;：&nbsp;&nbsp;'+
													'<span class="spanFileName" data-content="'+ SinglCFileInforOwn[k].file_name +'" data-variation="small">'+ filename +'</span>';
													
										} else {
											tep +=  
													'【 '+ SinglCFileInforOwn[k].filetype +' 】&nbsp;&nbsp;：&nbsp;&nbsp;'+ SinglCFileInforOwn[k].file_name ;
										}
										if(SinglCFileInforOwn[k].file_url == null || SinglCFileInforOwn[k].file_url == "") {
											tep +=  
											'<div class="unsee_down mini circular ui white basic icon button" href="" data-content="暂无文件下载地址！" data-variation="small">'+ 
						                        '<i class="hide small icon"></i>'+      
							                '</div>';  
										} else {
											tep +=
											'<a class="see_down mini circular ui black basic icon button" href="" id="'+SinglCFileInforOwn[k].file_url+'" data-content="点击可下载文件查看" data-variation="small">'+
						                        '<i class="unhide black small icon"></i>'+      
							                '</a>';  
										}
										tep += 
									'</div>'+ 
								'</div>'+        
							 '</div>';
							 $("#existCFiles").append($(tep));             
				 }
			 }

			 $('.circular.button').popup();   
			 $('.spanFileName').popup();    
			 $('.unsee_down.button').css({'cursor':'default'});    
			 $('.unclick.radio.icon').css({'cursor':'default','color':'#EAE4E4'});   
			 
			 $('.see_down.button').unbind('click').click(function(){
				 var fileurl = $(this).attr("id");
				 $(this).attr("href",fileurl);           
			 }); 
			 
			 $('.trash.outline.icon').popup();      
			 $('.trash.outline.icon').unbind('click').click(function(){
				 var fileno = $(this).attr("id");
                 var filetype = $(this).attr("filetype");
                 if(filetype=="授课计划")filetype="1";
                 //			 console.log(fileno);
				 DelSinglCourseSinglFile(fileno,filetype);
			 });    
		 }
		 
		
		function AddThisCourseFilePlan(fileno,fileurl,filename,filetype) {
		     if(filetype=="授课计划")filetype="1";
			$.confirm({
				msg          :"您确定要使用该课程文件吗？",
				btnSure     :'确定',
				btnCancel  :'取消',   
				sureDo       : function(){
					$.ajax({
			   			 url:"do?invoke=TeaUploadCoursePlan@AddThisCoursePlanInfor",
							 type: 'POST',
							 dataType: 'json',
							 data:{
								 termno:termid,
								 courseno:course_no,
								 teano:USEROBJECT.loginname,
								 fileno:fileno,
								 fileurl:fileurl,
								 filename:filename,
								 filetype:filetype
							 },
							 success: function(rep) {
								 console.log(rep);  
								 if(rep.result == 0) {
									 $.alert("本课程文件复制失败");
									 return;
								 } else { 
									 if((rep.message == null || rep.message == "") && rep.result == 1) {
										 $.alert("本课程文件已存在，不可重复添加！");
										 return;
									 } else {
										 $.alert("本课程文件复制成功！");
									 }
									 
									 $('.click.radio.icon').removeClass("radio icon");
									 $('.click').addClass("check circle outline icon");  
									 ClickSinglCourseFileInfor();   
								 }           
							 }
						}); 
				},
				cancelDo:function(){
					
				}
			});
		}
		
		function DelSinglCourseSinglFile(fileno,filetype) {
			$.confirm({
				msg          :"您确定要删除该课程文件么？",
				btnSure     :'确定',
				btnCancel  :'取消',   
				sureDo       : function(){
					$.ajax({
			   			 url:"do?invoke=TeaUploadCoursePlan@DelSinglCourseFileData",
							 type: 'POST',
							 dataType: 'json',
							 data:{
								 termno:termid,
								 courseno:course_no,
								 teano:USEROBJECT.loginname,
								 fileno:fileno,
                                 filetype:filetype
							 },
							 success: function(rep) { 
								 if(rep.result == 0) {
									 $.alert("本课程文件删除失败");
									 return;
								 } else {  
									 $('#existCFiles .middle.aligned.selection#'+fileno+'').remove();  
									 if($('#existCFiles .middle.aligned.selection').length == 0) { 
										 $("#existCFiles").append($('<p class="NoCont">暂无文件！</p>'));
									 }
									 $("#modCourseFile").modal('hide');   
								 }           
							 }
						}); 
				},
				cancelDo:function(){
					
				}
			});
		}
		 
	 });
</script>
<!--这里引用其他JS-->
</html>