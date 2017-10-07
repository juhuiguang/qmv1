<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp" %>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp" %>
<!--这里引用其他样式-->
<title>欢迎使用-首页</title>
<style>
	.results {
		overflow-y:scroll;
		height:300px;  
	} 
	
	#zc{
		color:blue!important;
	}
	#yc{
		color:red!important;
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
	
</style>
</head>
<body>
<%@ include file="/commonjsp/header.jsp"%>
	<div id="container" class="ui container">
			<h3  class="ui header "> 
		  			<i class="student icon"></i>
		  			<div class="content">信息员维护班级学生</div>
			</h3>
	  <div id="choosepand">
		<div class="ui blue basic button" id="addstu" style="float: right;margin-top:18px;">
		  <i class="write icon"></i>新添学生
		</div>

		<select class="ui mini dropdown" id="dropdown">
		</select>
		
		<div id="teaChooseClass" style="margin-top: 8px;margin-left: -8px;"> 
		    <label id="course_fx">您所带领的班级如下：</label>
	
	    </div>
	
		<table class="ui blue table"> 
		  <thead>
		    <tr>
		      <th>学期名称</th>
		      <th>班级名称</th>
		      <th>学生学号</th>
		      <th>姓名</th>
		      <th>专业名称</th>		      
		      <th>入学年</th>
		      <th>状态</th>
		      <th>操作</th>
		    </tr>
		  </thead>
		  <tbody  id="classinfor">
		    
		  </tbody>
		</table>
		
		<div id="addmod" class="ui modal">
			  <div class="header">
			    	为本班添加新学生：
			    	<i class="close icon" style="float: right;"></i>
			  </div>
			  <div class="content">
			  	<div class="description" id="addstumod">
			  	    <div class="ui form">	
			  	    <label style="color:red">*仅可填写“学生姓名”一栏，其它信息为固定的，“学期”根据下拉选项变化！</label><p>		  		  
			  		  <div class="two fields">						    
						    <div class="field">
							      <label>专业名称</label>
							      <input id="major" placeholder="" readonly="readonly" type="text">
						    </div>
						    
						    <div class="field">
							      <label>班级名称</label>
							      <input id="class" placeholder="" readonly="readonly" type="text">
						    </div>						    
					  </div> 
					  
					  <div class="two fields">
						    <div class="field">
						      <label>添加的学生</label>
						      <div class="stu ui small search">   
								  <div class="ui icon input">
						      		  <input class="prompt" id="stu" placeholder="请输入学生姓名或学号..." type="text">
						   		  </div>
						          <div class="results"></div>
						       </div>
						     </div>
						     
						     <div class="field">
						      <label>学期名称</label>
						      <input id="term" placeholder="" readonly="readonly" type="text">
						    </div>
					</div>					  
				</div>
				    </div>
				</div>
				<div class="actions">
				    <div class="ui positive right labeled icon button" id="submitadd">
				      提&nbsp;&nbsp;&nbsp;&nbsp;交
				      <i class="checkmark icon"></i>
				    </div>
				</div>	  
			  </div>			  
		  
<!-- 		  <div id="updatamod" class="ui modal">
			  <i class="close icon"></i>
			  <div class="header">
			    	修改该学生信息：
			  </div>
			  <div class="content">
			  	<div class="description" id="updatastumod">
			  		<div class="ui form">
			  		 <label style="color:red">*仅可修改“班级名称”和“专业名称”！</label><p>
			  		  <div class="three fields">
					  		<div class="field">
						      <label>学期名称</label>
						      <input id="term" placeholder="" readonly="readonly" type="text">
						    </div>
						    
						    <div class="field">
						      <label>班级名称</label>
						      <div class="class ui small search">   
								  <div class="ui icon input">
						      		  <input class="prompt" id="class" placeholder="请输入班级名称..." type="text">
						   		  </div>
						          <div class="results"></div>
						       </div>
						     </div>
						    
						    <div class="field">
						    	<label>专业名称</label>
							    <div class="major ui small search">   
								  <div class="ui icon input">
								    <input class="prompt" id="major" type="text" placeholder="请输入专业名称..."> 							    
								  </div>
								  <div class="results"></div>				 
								</div>
							</div> 
					  </div> 
					  <div class="two fields">
						    <div class="field">
						      <label>学号</label>
						      <input id="stuentno" placeholder="" readonly="readonly" type="text">
						    </div>
						    
						    <div class="field">
						      <label>姓名</label>
						      <input id="stuentname" placeholder="" readonly="readonly" type="text">
						    </div>
					   </div>
				    </div>
	    
				</div>
				
			  </div>
			  		<div class="actions">
					    <div class="ui positive right labeled icon button" id="submit">
					      提&nbsp;&nbsp;&nbsp;&nbsp;交
					      <i class="checkmark icon"></i>
					    </div>
				  	 </div>	  
		  </div> -->
	  </div>
	  		

	  	<div class="ui green large message" id="nosupview">
			<i class="frown large inverted yellow circular icon"></i>
			抱歉！您不是信息员或班主任，暂不能使用此功能！
		</div>
	</div>
	<!--这里绘制页面-->
</body>
<script src="script/common/alert/jquery.alert.js" type="text/javascript"></script>
<script>
	 $(function() {
		 var major_name="";
		 var major_no="";
		 var class_name="";
		 var class_no="";		 
		 var termno=SYSOBJCET.term_no;
		 var term_name="";
		 var userType = USEROBJECT.usertype;
		 var chooseid = "";
		 var flag = 0;
		 var bzrflag = 0;     
		 downAllTerm();
		 selectBZR();
		 function selectBZR() {
			 $.ajax({
				 url:"do?invoke=studentMessengerMaintain@getClasses",
				 type:'POST',
				 async: false, 
				 dataType:'json',
				 data:{
					 teano:USEROBJECT.loginname
				 },
				 success:function(rep) {
					 if(rep.result==0) {
						bzrflag = 1;
					 } else {
						 bzrflag = 0;
					 }
				 }
			 });
		 }
		 if(userType != "学生" && bzrflag == 0) {
			 $("#choosepand").hide();
			 $("#nosupview").show();
			 ChooseClassTable(termno);
		 } else {
			 $("#teaChooseClass").hide();
			 $("#nosupview").hide();
			 tableClassInfor(termno);
		 }            
		 
		/* if (userType == "教师" && bzrflag == 0) {
			 $("#choosepand").hide();
			 $("#nosupview").show();
			 ChooseClassTable(termno);
		 } else {
			 $("#teaChooseClass").hide();
			 $("#nosupview").hide();
			 tableClassInfor(termno);
		 } */
		 
		 
		 $("#addstu").unbind("click").click(function(){
				showAdd(major_name,major_no,class_name,class_no,termno,term_name);
		 });
		 
		 function ChooseClassTable(termno) {
			 $("#choosepand").show();
			 $("#teaChooseClass").empty();  
			 var demp = 
				 '<label id="course_fx">您所带领的班级如下：</label>';    
			 $("#teaChooseClass").append($(demp));
			 
			 $("#nosupview").hide();
			 $.ajax({
				 url:"do?invoke=studentMessengerMaintain@getClasses",
				 type:'POST',
				 dataType:'json',
				 data:{
					 teano:USEROBJECT.loginname
				 },
				 success:function(rep) {  
					 console.log(rep);
					 if(rep.result==0) {
						$.alert("没有获取到该班主作所管理的班级！");
					 } else {
						 var data = rep.data;
						 for(var i=0; i<data.length; i++) {
							 chooseid = data[0].class_no;
							 var dom = 
								 '<button class="ui mini button" id="'+data[i].class_no+'">'+data[i].class_name+'</button>';
							 $("#teaChooseClass").append($(dom));
						 }
						 $('#'+chooseid+'').addClass("blue");			 
						 flag = 1;
						 $("#teaChooseClass .button").unbind('click').click(function() {
								$("#teaChooseClass .blue").removeClass("blue");
								$(this).addClass("blue");
								chooseid = $(this).attr("id");	
								console.log(termno);
								tableClassInfor(termno);
						 });
						 tableClassInfor(termno);
					 }
				 }
			 });
		 }
		 
		 function showAdd(major_name,major_no,class_name,class_no,termno,term_name) {
			 var stuid="";
			 $('#addmod').modal({
					transition:'slide down',
					observeChanges:true,
					closable:false
				}).modal('show');
			 $("#major").val(major_name);
			 $("#class").val(class_name);
			 $("#stu").val("");
			 $("#term").val(term_name);
			 $.ajax({
				 url:"do?invoke=studentMessengerMaintain@getStudent",
				 type:'POST',
				 dataType:'json',
				 data:{
					 termno:termno
				 },
				 success:function(rep) {  
					 console.log(rep);
					 if(rep.result==0) {
						$.alert("没有获取到本学年无班级和专业归属的学生！");
						return;
					 } else {
						 var table=rep.data;
						 var allStu=[];
						 for(var j=0; j<table.length; j++) {
							 allStu[j] = {title:table[j].stu_name,description:table[j].stu_no,"id":table[j].stu_no};
						 }
						 $('.stu.ui.search').search({
							 source: allStu,
							 maxResults:10000,   
							 onSelect:function(itemStu) {
								 stuid = itemStu.id;
								 console.log(itemStu.description);
								 console.log(stuid);
							 }
						  });
						 $("#submitadd").unbind("click").click(function(){
							 var term_no = termno;
							 var stu_no = stuid;
							 var majorid = major_no;
							 var classid = class_no;
							 addModifyStu(term_no,stu_no,majorid,classid);
						 });
					 }
				 }
			 });
		 }
		 
		 function addModifyStu(term_no,stu_no,majorid,classid) {
			 $.ajax({
				 url:"do?invoke=studentMessengerMaintain@StuAdd",
				 type:'POST',
				 dataType:'json',
				 data:{
					 termno:term_no,
					 stuno:stu_no,
					 majorno:majorid,
					 classno:classid
				 },
				 success:function(rep) {
					 console.log(rep);
					 if(rep.result == 0) {
						 $.alert("该新学生添加失败，您可以再试一次！");
					 } else {
						 $.alert("新学生成功添加，恭喜新成员加入啦！");
						 $("#classinfor").empty();
						 tableClassInfor(term_no);
					 }
				 }
			 });
		 }
		 
		 
		 function tableClassInfor(termno) {
			 $.ajax({
				 url:"do?invoke=studentMessengerMaintain@getClassInfor",
				 type:'POST',
				 dataType:'json',
				 data:{
					 stuno:USEROBJECT.loginname,
					 termno:termno,
					 classid:chooseid,
					 flag:flag
				 },
				 success:function(rep) {
					 console.log(rep);
					 if(rep.result==0) {
						 $.alert("没有加载到本班学生的内容！");
						 $("#classinfor").html("");    
						 return;
					 } else {
						 if(flag == 1) {
						 	$("#classinfor").empty(); 
						 }
						 var stus=rep.data;
						 for(var i=0; i<stus.length; i++) {
							 var dom = 
								 '<tr>'+
							  	  	'<td>'+stus[i].term_name+ '</td>'+
							  		'<td>'+stus[i].class_name+ '</td>'+
							  	  	'<td>'+stus[i].stu_no+ '</td>'+
							  		'<td>'+stus[i].stu_name+ '</td>'+
							  		'<td>'+stus[i].major_name+ '</td>'+
							  		'<td>'+stus[i].stu_year+ '</td>';
							  		
							  		if(stus[i].stu_status == "1") {
							  			dom += '<td id="zc">正常</td>';
							  		} else {
							  			dom += '<td id="yc">异常</td>';
							  		}
									
							  		dom += 
							  		'<td>'+
									/* 	'<div class="btnupdate circular mini ui blue basic icon button" termno="'+stus[i].term_no+'" termname="'+stus[i].term_name+'"  stuno="'+stus[i].stu_no+'" stuname="'+stus[i].stu_name+'" majorno="'+stus[i].major_no+'" majorname="'+stus[i].major_name+'" classno="'+stus[i].class_no+'" classname="'+stus[i].class_name+'">'+
											'<i class="edit blue large icon"></i>'+
						                 '</div>'+  */
						                 '<div class="btndelete circular mini ui red basic icon button" termno="'+stus[i].term_no+'" stuno="'+stus[i].stu_no+'">'+
											'<i class="trash red large icon"></i>'+
						                 '</div>'+
					                 '</td>'+							  		
							  	 '</tr>';
							  	 $("#classinfor").append(dom);
							  	 major_name=stus[0].major_name;
							  	 major_no=stus[0].major_no;
							  	 class_name=stus[0].class_name;
							  	 class_no=stus[0].class_no;
							  	 term_name=stus[0].term_name;
						 }
						 /* $('.btnupdate').click(function(){
							 var termno = $(this).attr("termno");
							 var termname = $(this).attr("termname");
							 var stuno = $(this).attr("stuno");
							 var stuname = $(this).attr("stuname");
							 var majorno = $(this).attr("majorno");
							 var majorname = $(this).attr("majorname");
							 var classno = $(this).attr("classno");
							 var classname = $(this).attr("classname");
							 showModify(termno,termname,stuno,stuname,majorno,majorname,classno,classname);
						 }); */
						 
						 $('.btndelete').click(function(){
							 var termno = $(this).attr("termno");
							 var stuno = $(this).attr("stuno");
							 delStu(termno,stuno);
						 });
					 }
				 }
			 });
		 }
		 
/* 		 function showModify(termno,termname,stuno,stuname,majorno,majorname,classno,classname) {
			 var majorid="";
			 var classid="";
			 $('#updatamod').modal({
					transition:'slide down',
					observeChanges:true,
					closable:false
			  }).modal('show');			 
			 $("#term").val(termname);
			 $("#class").val(classname);
			 $("#stuentno").val(stuno);
			 $("#stuentname").val(stuname);
			 $("#major").val(majorname);			 			 
			 $.ajax({
				 url:"do?invoke=studentMessengerMaintain@getMajorClass",
				 type:'POST',
				 dataType:'json',
				 data:{
					 termno:termno
				 },
				 success:function(rep) {  
					 console.log(rep);
					 if(rep.result==0) {
						$.alert("没有获取到专业名称或班级名称~");
						return;
					 } else {
						 var majorclass=rep.data[0];
						 var allmajor=[];
						 var allclass=[];
						 for(var j=0; j<majorclass.majortb.length; j++) {
							 allmajor[j] = {title:majorclass.majortb[j].major_name,"id":majorclass.majortb[j].major_no};
						 }
						 $('.major.ui.search').search({
							 source: allmajor,
							 maxResults:10000,   
							 onSelect:function(itemmajor) {
								 majorid = itemmajor.id;
							 }
						  });						 
						 for(var k=0; k<majorclass.classtb.length; k++) {
							 allclass[k] = {title:majorclass.classtb[k].class_name,"id":majorclass.classtb[k].class_no};
						 }
						 $('.class.ui.search').search({
							 source: allclass,
							 maxResults:10000,   
							 onSelect:function(itemclass) { 
								 classid = itemclass.id;
							 }
						 });
					 }
					 $("#submit").unbind("click").click(function(){
						 var term_no = termno;
						 var stu_no = stuno;
						 var major_no = majorid;
						 var class_no = classid;
						 saveModifyStu(term_no,stu_no,major_no,class_no);
					 });
				}
			  });
			 
		 } */
		 
/* 		 function saveModifyStu(term_no,stu_no,major_no,class_no) {   
			 $.ajax({
				 url:"do?invoke=studentMessengerMaintain@StuUpdata",
				 type:'POST',
				 dataType:'json',
				 data:{
					 termno:term_no,
					 stuno:stu_no,
					 majorno:major_no,
					 classno:class_no
				 },
				 success:function(rep) {
					 console.log(rep);
					 if(rep.result == 0) {
						 $.alert("该学生信息修改失败，您可以再试一次！");
					 } else {
						 $.alert("修改信息成功！");
						 $("#classinfor").html("");
						 tableClassInfor(term_no);
					 }
				 }
			 });
		 } */
		 
		 function delStu(termno,stuno) {
				$.confirm({
					msg          :"您确定从本班移除该学生么？",
					btnSure     :'确定',
					btnCancel  :'取消',
					sureDo       : function(){													
											$.ajax({
												url:"do?invoke=studentMessengerMaintain@DeleteStu",
												type:'POST',
												dataType:'json',
												data:{
													termno:termno,
													stuno:stuno
												},
												success:function(rep) {
													console.log(rep);																
													if(rep.result == 0) {
														$.alert("删除该学生失败！");
													} else {
														$.alert("该学生这学期从本班移除成功！");
														$("#classinfor").html("");
														tableClassInfor(termno);
													}																																		
												}
											});
					}
				});
		 }
		 
		 
	     function downAllTerm(){
	    	$.ajax({
				url:"do?invoke=studentMessengerMaintain@getAllTerm",
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
						termno=$("#dropdown").val();
						$("#classinfor").html("");
						if(userType != "学生" && bzrflag == 0) {
							 $("#choosepand").hide();
							 $("#nosupview").show();
							 ChooseClassTable(termno); 
						 } else {
							 $("#teaChooseClass").hide();
							 $("#nosupview").hide();
							 tableClassInfor(termno);
						 }   				
					});
				}
	    	});
	    }
	 });
</script>
<!--这里引用其他JS-->
</html>