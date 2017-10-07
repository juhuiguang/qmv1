<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp" %>
<html>
<head>
<%@include file="/commonjsp/meta.jsp" %>
<!--这里引用其他样式-->
<title>校内教学质量监控运行平台</title>
	<style>
	.display{
	 	color:black;
	}
	.ui.attached.segments{
	
	margin-bottom:4%;
	}
	.ui.mini.input{
	float:right;
	}
	#searchbuttontable{
	margin-top:1%
	}
	.ui.selectable.table{
	margin-top:1%;
	}
	.field{
	margin-top:1%
	}
	#srchpnl .label{
   margin-top:5px;
   margin-bottom:10px
   } 
   .iBconfirm.max{
   top:10px!important;
   }
   .iBalert.max{
   top:10px!important;
   }
   .mydropdown{
   min-width:60%!important;
   margin-left:-18%
   }
   #dropdown{
   float:left;
   }
   #searchbutton{
       margin-left:5px;
   }
   #longmodel .content{
       padding-top:0px;
   }
   #searchbuttontable{
       margin-left: 5px;
       position: relative;
       top: 1px;
   }
   .ui.accordion .content {
  		margin-bottom: -20px;
   		margin-top: -10px; 
   }
   .ui.accordion .transition {
   		margin-left:22px;
   }
   .dropdown {
   		margin-top: 5px;
   }
   #searchlocalteacher {
   		margin-top: 7px;
   		width:10%!important;
   }
   #searchbutton { 
	   	height: 40px;
	    margin-top: 6px;
	    margin-left: -2px;
   }
   #addbutton{
       margin-top:7px;
       height：39px;
   }
   #inputId{
       width:82%!important;
   }
   #peopelCount{
       height: 39px!important;
   	   margin-top: 7px;
       text-align: center;
       line-height: 20px;
       margin-left:-52px;
   }
   #XZdepPanel{
       margin-bottom:12px;
   }
	</style>
</head>
<body>
<%@ include file="/commonjsp/header.jsp"%>
	<!--这里绘制页面-->
	<div id="container" class="ui container">
		<h3  class="ui header "> 	
	  	<i class="ui  unordered list icon"></i>
	  	部门教师管理
	</h3>
	
	<div id="srchpnl">
		<div class="ui accordion">
		  <div class="title active"><i class="dropdown icon"></i> 教学部门 </div>
		  <div class="content active">
		    <div class="transition visible" style="display: block !important;" id="JXdepPanel">
		    	
		    </div>
		  </div>
		  <div class="title"><i class="dropdown icon"></i> 行政部门</div>
		  <div class="content">
		    <div class="transition hidden" id="XZdepPanel">
		    
		    </div>
		  </div>
		</div>
    </div>
    
	<div class="container center aligned segmentsinput" id="segmentsinput"></div>
	<form class="ui form">
	<div class="fields">
	     <div class= "field">
		    <select class="ui mini dropdown" id="dropdown">
			</select>
		</div>
			<div class= "field"  >
			    <div class="ui small input" id="inputId">
				  <input type="text" placeholder="搜索教师..." id="searchlocalteacher" >
			    <div class="ui small blue button " id="searchbutton" >
			    <i  class="search icon" ></i>搜索</div>
			    </div>
		   </div>
			<div class= "field"  >
		        <div class="ui  blue label" id="peopelCount" >
			   </div> 
			</div>
		    <div class= "field"  >
		        <div class="ui small blue button " id="addbutton" >
			    <i class="user icon" ></i>增加部门教师</div> 
			</div>
	</div>		
	</form>	
    <div class="ui long modal" id="longmodel">
  <i class="close icon"></i>
  <div class="ui header">
         添加教职工
  </div>
  <div class="content">
     <div class="ui two fields" >
		<div class= "ui field"  style="float:left;"  >
			  <div class="ui small input">
			  <input type="text" placeholder="搜索教师姓名..." id="searchname">
			</div>
		    </div>
		<div class= "ui field">
			  <div class="ui small blue button" id="searchbuttontable">搜索</div>
			  <div class="ui small blue button" id="returnDepTeacher">返回部门教师</div>
		   <!--  <div class="ui small blue button "  id="searchbuttontable">
		   	  <i  class="search icon" ></i>搜索</div>-->
		    </div>  
	</div>
	  	
		<table class="ui very compact mini blue striped table">
		  <thead>
		    <tr>
		      <th>教师工号</th>
		      <th>教师姓名</th>
		      <th>添加</th>
		    </tr>
		  </thead>
		  <tbody id="addteacher">	    
		  </tbody>
		</table>		
  <div class="actions">
    <div class="ui small blue button" id="closebutton">确定</div>
  </div>
</div>
</div>

    <div class="ui small modal">
  <i class="close icon"></i>
  <div class="ui header">
     选择教师职位
  </div>
  <div class="content">
     <select class="ui dropdown" id="selectjob">
     </select>
      <div class="actions">
    <div class="ui small blue button" id="addjobteacher">添加</div>
  </div>
</div>
</div>
		<table class="ui very compact blue selectable table" >
		  <thead>
		    <tr>
		      <th>部门名称</th>
		      <th>教师姓名</th>
		      <th>教师状态</th>
		      <th id="jszw">教师职位</th>
		      <th>删除教师</th>
		    </tr>
		  </thead>
		  <tbody id="teacherinformation">    
		  </tbody>
		</table>		
	
	</div>
</body>

<script>
$(function(){
	//定义
	var pageindex=1;
	var totalpage;
	var temppage=1;
	var dep_name=USEROBJECT.userinfo.dep_name;
	var dep_no='';
	var term_no=SYSOBJECT.term_no;
	var job_data="";
	var departments = "";
	$('.ui.accordion').accordion();  
//	  loadjob();
	  loadterm();
	  //读取job信息，赋给全局变量
	  function loadjob(){
	    	$.ajax({
				url:"do?invoke=ManageTeacher@getjobinformation",
				type:'POST',
				dataType:'json',
				async: false,
				success:function(rep){
					job_data=rep.data;
					if(job_data==''){
						$('#jszw').remove();
					}else{
						
						for(var i=0;i<job_data.length;i++){
							var dom= ' <option value="'+job_data[i].job_no+'">'+job_data[i].job_name+'</option>';
							$("#selectjob").append(dom);
						}
						
						$('#selectjob').dropdown();
					}
				}
					});
	    }
	    //读取所有的学期信息放入下拉框
	    function loadterm(){
	    	$.ajax({
				url:"do?invoke=ManageTeacher@gettermnoinformation",
				type:'POST',
				dataType:'json',
				success:function(rep){
					if(rep.result==0){
					$.alert("",rep.message);
					return;
					}
					else{
						var temp=rep.data;
						for(var i=0;i<temp.length;i++){
							var dom= ' <option value="'+temp[i].term_no+'">'+temp[i].term_name+'</option>';
							$("#dropdown").append(dom)
						}
						/* $('#dropdown').dropdown().dropdown("set selected",term_no); */
						$('#dropdown').dropdown();
					}
					
					$("#dropdown").change(function(){
						term_no=$("#dropdown").val();
						pageindex=1;
			    		temppage=1;
						loadtable();
					});
				}
	    	});
	    }
	ifadd();
	loadtable();
	$('.ui.long.modal')
	.modal({
		transition:'slide down',
		observeChanges:true,
		closable: false
	})
	  .modal('attach events', '#addbutton', 'show')
	;
	$("#closebutton").click(function(){
		$('.ui.long.modal')
		.modal({
		    transition:'fly down',
	     })
		.modal('hide');
	});
	function ifadd(){
	if(USEROBJECT.userpurview=="ALL")
	{
		AllDeps();
		
		for(var j=0;j<departments.length;j++){
			if(departments[j].dep_type == "教学") {
				dep_no=departments[j].dep_no;
				dep_name=departments[j].dep_name; 
				break;   
			}
		}

		for(var i=0;i<departments.length;i++){
			if(departments[i].dep_type == "教学") {
				var dep=$("<div class='ui  label srchdep JX' dep_no='"+departments[i].dep_no+"'>"+departments[i].dep_name+"</div>");
				$("#JXdepPanel").append(dep);
			} else {
				var dep=$("<div class='ui  label srchdep' dep_no='"+departments[i].dep_no+"'>"+departments[i].dep_name+"</div>");
				$("#XZdepPanel").append(dep);
			}  
		}
		$(".srchdep.JX:first-child").addClass('blue'); 
		$(".srchdep").hover(function(){
			$(this).css("cursor","pointer");
		});
		$("#addbutton").attr('data-content','增加'+dep_name+'的教职工');
		$("#searchbutton").attr('data-content','在'+dep_name+'中搜索此教职工');
		 $("#srchpnl .srchdep").bind("click",function(){
			 $("#srchpnl .srchdep.blue").removeClass("blue");
			 $(this).addClass("blue");
		    	if(dep_no==$(this).attr("dep_no")){
		    		return ;
		    	}
		    	 $("#classinformation").html("");
		    	 dep_no=$(this).attr("dep_no")
		    	 dep_name=$(this).text();
				 $("#addbutton").attr('data-content','增加'+dep_name+'的教职工');
				 $("#searchbutton").attr('data-content','在'+dep_name+'中搜索此教职工');
				   pageindex=1;
				   temppage=1;
				   loadtable();
		    });
		    
		$('#searchbutton').popup();
		$('#addbutton').popup();
		  
		
	}
	else{
	   $("#addbutton").attr('data-content','增加'+USEROBJECT.userinfo.dep_name+'的教职工');
	   $('#addbutton').popup();
	   $("#searchbutton").attr('data-content','在'+USEROBJECT.userinfo.dep_name+'中搜索此教职工');
	   $('#searchbutton').popup();
	   dep_no=USEROBJECT.userinfo.dep_no
	   dep_name=USEROBJECT.userinfo.dep_name
	}
	}
	
	

	function AllDeps() {
		$.ajax({
			url:"do?invoke=supervisorMarkAdd@getAllDeps",
			type:'POST',
			dataType:'json',
			async: false,
			success:function(rep) {
				if(rep.result == 0) {  
					$.alert("很抱歉，没有取到院系相关信息！");
					return;
				} else {
					departments = rep.data;
				}
			}
		});
	}
	
	//点击跳出弹出框
    $('#addbutton').bind("click",function(){
    	 addTeacherKeypress(); 
    	$('#searchname').val('');
    	$.ajax({
			url:"do?invoke=ManageTeacher@getvoidTeacher",
			type:'POST',
			dataType:'json',
			data:{
				dep_no:dep_no,
				term_no:term_no
			},
			success:function(rep){
    	        $("#addteacher").html("")
    	        if(rep.result==0){
					 if(rep.message=="数据为空"){
						 $.alert("","没有空闲的教职工");
						 return ;
					 }
					 else{
					$.alert("",rep.result);
					return;
					 }
				}  
			    var temp=rep.data;
			    for(var i=0;i<temp.length;i++)
			    {
			    	var dom= 
						'<tr id="trtable2'+i+'">'+
						'<td >'+																                                                              						     	      		        																																			         
			      		      '<div>'+
			                    temp[i].teacher_no+
    		                 '</div>'+
    		             '</td>'+      
					'<td>'+temp[i].teacher_name+'</td>'+
		                 '<td>'+																                                                              						     	      		        																																
		                  '<div >'+				         
			                 '<div class="addclick btnfirst circular ui mini blue basic icon button"  teacherno="'+temp[i].teacher_no+'" teachername="'+temp[i].teacher_name+'" data-content="添加到'+dep_name+'">'+
			                     '<i class="plus icon"></i>'+
			                 '</div>'+ 
			                 '</div>'+
		                   '</td>';
		                   $("#addteacher").append(dom);
			    }
			    $('.circular.ui.blue.basic.icon.button').popup();
			    //添加教师
			    $('.addclick').unbind('click').bind("click",function(){
			        var tempclass=$(this).closest("tr");
			    	var teacher_no=$(this).attr('teacherno');
			    	var teacher_name=$(this).attr('teachername');
			    	addteacher(tempclass,teacher_no,teacher_name);
			});
			}
    	});
    });
    	function addteacher(tempclass,teacher_no,teacher_name){
						var job_no="";
    		if(job_data!=''){
    			$('.small.modal')
    			.modal({
					transition:'slide down',
					observeChanges:true,
					closable: false
				})
    			  .modal('show')
    			;
    		}else{
    			$.confirm({
					msg       :'确定添加'+teacher_name+'到 '+dep_name+'吗？',
					btnSure   : '确认 ',
					btnCancel : '取消',
					sureDo	  :function(){ 
						$.ajax({
							url:"do?invoke=ManageTeacher@addteacher",
							type:'POST',
							dataType:'json',
							data:{
								job_no:job_no,
								dep_no:dep_no,
								teacher_no:teacher_no,
								term_no:term_no
							},
							success:function(rep){
								if(rep.message=="添加成功")
								 tempclass.hide();
								else
									$.alert("",rep.message);
							}
				    	});
					},
					cancelDo:function(){
						return ;
					}
				});	
    		}
    		$('#addjobteacher').unbind('click').click(function(){
    			$('.small.modal')
    			.modal({
					transition:'slide down',
					observeChanges:true,
					closable: false
				})
  			 	.modal('hide')
  			;
					job_no=$("#selectjob").val();
    			$.ajax({
					url:"do?invoke=ManageTeacher@addteacher",
					type:'POST',
					dataType:'json',
					data:{
						job_no:job_no,
						dep_no:dep_no,
						teacher_no:teacher_no,
						term_no:term_no
					},
					success:function(rep){
						if(rep.message=="添加成功"){
							 pageindex=1;
							 temppage=1;
							 loadtable();
						}else{
						$.alert(rep.message)	
						}
					}
		    	});
    		})
    }
    	//绑定回车事件
    	checkTeacher();
    	 $('.ui.long.modal')
    	.modal({
    		onHide:checkTeacher
    	}); 
    //查看部门教师时的键盘回车事件
    function checkTeacher(){
    	$('#searchlocalteacher').keydown(function(event){ 
			if(event.keyCode==13){ 
				console.log(2222)
				$('#searchbutton').click();
			} 
		});
    	 $('#searchname').unbind('keydown')
    	/* $('#searchbuttontable').unbind('keypress') */
    }
    //添加部门教师时的键盘回车事件
     function addTeacherKeypress(){
    	 $('#searchlocalteacher').unbind('keydown')
    	$('#searchname').keydown(function(event){ 
			if(event.keyCode==13){ 
				console.log(3333)
				$('#searchbuttontable').click();
			} 
		});
    	$('#searchbutton').unbind('keypress')
    } 
    	$('#returnDepTeacher').unbind('click').click(function(){
    		$('#addteacher').html("");
    		$('#addbutton').click();
    	})
	//弹出框查询按钮的功能
    $('#searchbuttontable').bind("click",function(){
    	if($("#searchname").val()==""){
    		$('#addteacher').html("");
    		$('#addbutton').click();
    	}
    	else{
    		$('#addteacher').html("");
    		var teacher_name=$("#searchname").val();
    		$.ajax({
    			url:"do?invoke=ManageTeacher@searchTeacher",
    			type:'POST',
    			dataType:'json',
    			data:{
    				dep_no:dep_no,
    				teacher_name:teacher_name,
    				term_no:term_no
    			},
    			success:function(rep){
    				var temp=rep.data;
    				for(var i=0;i<temp.length;i++){
    				var dom= 
						'<tr id="trsearchtable'+i+'">';	
							dom += '<td >'+																                                                              						     	      		        																																			         
			      		                 '<div>'+
			      		                     temp[i].teacher_no+
						                 '</div>'+ 
				                       '</td>';       
							dom+='<td>'+temp[i].teacher_name+'</td>';
				                   dom += '<td>'+																                                                              						     	      		        																																
				                  '<div >'+				         
					                 '<div class="addclick btnfirst circular ui mini blue basic icon button"  teacherno="'+temp[i].teacher_no+'" teachername="'+temp[i].teacher_name+'" data-content="添加到'+dep_name+'">'+
					                     '<i class="plus icon"></i>'+
					                 '</div>'+ 
					                 '</div>'+
				                   '</td>';
    				
		                   $("#addteacher").append(dom);
    			     }
    				$('.circular.ui.blue.basic.icon.button').popup();
    				    //添加教师
    				    $('.addclick').bind("click",function(){
    				    	var tempclass=$(this).closest("tr");
    				    	var teacher_no=$(this).attr('teacherno');
    				    	var teacher_name=$(this).attr('teachername');
    				    	addteacher(tempclass,teacher_no,teacher_name);
    				    	
    				    });
    	           }
    		})
    		}
    			
    });
  // 页面查询按钮的功能
    $('#searchbutton').bind("click",function(){
    	if($("#searchlocalteacher").val()==""){
    		 pageindex=1;
    		 temppage=1;
    		loadtable();
    	}
    	else{
    		$('#teacherinformation').html("");
    		var teacher_name=$("#searchlocalteacher").val();
    		$.ajax({
    			url:"do?invoke=ManageTeacher@searchlocalTeacher",
    			type:'POST',
    			dataType:'json',
    			data:{
    				teacher_name:teacher_name,
    				dep_no:dep_no,
    				term_no:term_no
    			},
    			success:function(rep){
    				$("#spanbutton").hide();
    				 if(rep.result==0){
    					 if(rep.message=="数据为空"){
    						 return ;
    					 }
    					 else{
    					$.alert("",rep.result);
    					return;
    					 }
    				}  
    				var temp=rep.data;
    				for(var i=0;i<temp.length;i++){
    					var dom= 
    						'<tr id="trtable'+i+'">';	
    							dom += '<td >'+																                                                              						     	      		        																																			         
    			      		                 '<div id="dep_name'+i+'">'+
    			      		               dep_name+
    						                 '</div>'+ 
    				                       '</td>';       
    							dom+='<td id="teacher_name'+i+'">'+temp[i].teacher_name+'</td>';
    							dom+='<td id="teacher_status'+i+'">'+"正常"+'</td>'; 
    							if(job_data != ""){
    								dom+='<td ><select class="mydropdown ui mini dropdown" teacher_no1="'+temp[i].teacher_no+'">';
    								dom+='<option value="">'+temp[i].job_name+'</option>';
    								for(var m=0;m<job_data.length;m++){
    									dom += '<option value="'+job_data[m].job_no+'">'+job_data[m].job_name+'</option>';
    								}
    								dom+='</select></td>';
    							}
    							 dom += '<td>'+																                                                              						     	      		        																																
    	                          '<a>'+				         
    	   		                 '<div class="remove btnfirst circular ui mini blue basic icon button" teacherno="'+temp[i].teacher_no+'" teachername="'+temp[i].teacher_name+'" data-content="点击删除此教师">'+
    				                     '<i class="small remove icon" teacherno="'+temp[i].teacher_no+'" teachername="'+temp[i].teacher_name+'" data-content="点击删除此教师"></i>'+
    				                 '</div>'+ 
    				                 '</a>'+
    		                       '</td>';
		                   $("#teacherinformation").append(dom);
    			     }
    				$('.mydropdown').dropdown()
    				$('.mydropdown').change(function(){
    					var teacher_no=$(this).attr('teacher_no1')
    					var job_no=$(this).val();
    					changeteacherjob(teacher_no,job_no);
    				})
    				$('.circular.ui.blue.basic.icon.button').popup();
    				    //添加教师
    				    $('.remove').bind("click",function(){
    				    	var tempclass=$(this).closest("tr");
    				    	var teacher_no=$(this).attr('teacherno');
    			            var teacher_name=$(this).attr('teachername');    	
    						removetableteacher(tempclass,teacher_no,teacher_name);
    				    });
    	           }
    		})
    		}
    			
    });
	//绘制表格
	function loadtable(){
		$('#teacherinformation').html("");
		$("#spanbutton").show();
		var pagelength=7;
		$.ajax({
			url:"do?invoke=ManageTeacher@getDepartmentTeacher",
			type:'POST',
			dataType:'json',
			async: false,
			data:{
				pageindex:pageindex,
				pagelength:pagelength,
				dep_no:dep_no,
                temppage:temppage,
                term_no:term_no
			},
			success:function(rep){
			
				if(rep.result==0){
					$('#peopelCount').html("共0位教师 ");
					if( rep.message=="插入教师失败"){
						$.alert(rep.message)
					}
					return;
				}
				if(temppage==1){
					var count=0;
					if(rep.total%pagelength!=0)count=1;
					$('#peopelCount').html("共"+rep.rows.length+"位教师 ");
				    totalpage=parseInt(rep.total/7) +count;
					$("#spanLast").attr("page",totalpage);
					$("#spanTotalPage").text(totalpage)
				}
				temppage++;
				renderTable(rep.rows);
			}
		});
	}
	function changeteacherjob(teacher_no,job_no){
		$.ajax({
			url:"do?invoke=ManageTeacher@changeteacherjob",
			type:'POST',
			dataType:'json',
			data:{
				teacher_no:teacher_no,
				job_no:job_no,
                term_no:term_no
			},
			success:function(rep){
			}
		});
	}
	function renderTable(a){
		var temp = a;
		for(var i = 0; i<temp.length; i++) {  
			var dom= 
					'<tr id="tr'+i+'">';	
						dom += '<td >'+																                                                              						     	      		        																																			         
		      		                 '<div id="dep_name'+i+'">'+
					                     temp[i].dep_name+
					                 '</div>'+ 
			                       '</td>';       
						dom+='<td id="teacher_name'+i+'">'+temp[i].teacher_name+'</td>';
						dom+='<td id="teacher_status'+i+'">'+"正常"+'</td>'; 
						 /* if(job_data!=''){
							dom+='<td ><select class="mydropdown ui mini dropdown" teacher_no1="'+temp[i].teacher_no+'">';
							dom+='<option value="">'+temp[i].job_name+'</option>';
						   for(var m=0;m<job_data.length;m++){
								dom += '<option value="'+job_data[m].job_no+'">'+job_data[m].job_name+'</option>';
							} 
							dom+='</select></td>';
						}  */
						 dom +='<td>'+temp[i].job_name+'</td>';  
						 dom += '<td>'+																                                                              						     	      		        																																
                          '<a>'+				         
   		                 '<div class="remove btnfirst circular ui mini blue basic icon button" teacherno="'+temp[i].teacher_no+'" teachername="'+temp[i].teacher_name+'" data-content="点击删除此教师">'+
			                     '<i class="remove icon"></i>'+
			                 '</div>'+ 
			                 '</a>'+
	                       '</td>';
                     $('#teacherinformation').append(dom);
                     
		}
					$('.mydropdown').change(function(){
						var teacher_no=$(this).attr("teacher_no1")
						var job_no=$(this).val();
						changeteacherjob(teacher_no,job_no);
					})
		$('.mydropdown').dropdown();
		$('.circular.ui.blue.basic.icon.button').popup();
		   	

		 $('.remove').bind("click",function(){
		    	var tempclass=$(this).closest("tr");
		    	var teacher_no=$(this).attr('teacherno');
		    	var teacher_name=$(this).attr('teachername');
		    	removetableteacher(tempclass,teacher_no,teacher_name);
		 });
	}
	
	$("#spanFirst").bind("click",function(){
		if(pageindex==1)return;
		if(totalpage>1){
			$("#teacherinformation").html("");
		    pageindex=1;
		loadtable();
		}
	});
		function removetableteacher(tempclass,teacher_no,teacher_name){
		$.confirm({
			msg       :'确定从'+dep_name+'删除'+teacher_name+' 吗？',
			btnSure   : '确认 ',
			btnCancel : '取消',
			sureDo	  :function(){ 
				$.ajax({
					url:"do?invoke=ManageTeacher@removeteacher",
					type:'POST',
					dataType:'json',
					data:{
						teacher_no:teacher_no,
						term_no:term_no
					},
					success:function(rep){
						if(rep.message=="删除成功"){
						 tempclass.remove();
						pageindex=1;
			    		temppage=1;
			    		loadtable();
						}else{
							$.alert(rep.message)
						}
					}
		    	})
			},
			cancelDo:function(){
				return ;
			}
		});
		}
});
</script>
<!--这里引用其他JS-->
</html>