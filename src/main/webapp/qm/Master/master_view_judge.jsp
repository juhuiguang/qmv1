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
.ui.container.segment .button{ 
	margin-top:10px; 
	margin-right:10px;
} 
  
.ui.fluid.selection.dropdown{ 
width:25%;
} 
.ui.blue.striped.table{  
width:100%;  
}    
 
a,.titleitem{
cursor:pointer;   
} 
a:hover{
color:green;  
}  

</style>     
</head>  
<body>
<%@ include file="/commonjsp/header.jsp"%>
	<div id="container" >
		<div id="dimmerDiv" class="ui">
		<div class="ui active inverted dimmer" id="dimmerModule">
		<div class="ui text loader">正在加载中...</div>
		</div> 
	    <h3 class="ui header" id='jxzlkh'>  
		  <i class="tasks icon"></i>
		  <div class="content" id="inftitle">二级院（系、部）教师教学质量综合评价表</div>     
		</h3>   
		
			 
		<div class="ui fluid selection dropdown"> 
		  <i class="dropdown icon"></i>  
		  <span class="default text">请先选择课程</span>   
		  <div class="menu infro"> 
		   
		  </div>  
		</div> 
		</div> 
		  
		<button class="ui basic button" style="position:absolute;left:40%;top:170px;"  id="export_dc" data-content="点击导出" data-variation="small"><i class="upload icon"></i> 导 出 </button>	
		
		 <table class="ui celled center very compact blue striped table one" id="tableinf">
		 <thead id="theadone">
		 </thead>
		 <tbody class="tbody one">
		    
		  </tbody> 
		</table> 
		
		<div class="ui  modal long"> 
		  
		  <div class="header"  >  
		    <i class="close icon" style="float:right;cursor:pointer"></i>  
		  <i class="unordered list icon"></i>
		   <i id="tableTitle"></i>
		  </div>  
		  <div class="content pbl">
		 	 <table class="ui striped table two">
			 <tbody class="tbody two">
			  </tbody>
			</table>
		    
		  </div>  
		</div>   
		
	</div>
	<!--这里绘制页面-->
</body> 
<script>  
	$(function() { 
		var dimmer = '<div class="ui active inverted dimmer" id="dimmerModule">'+
						'<div class="ui text loader">正在加载中...</div>'+
					'</div>';
		var SYSOBJCET=<%=SYSOBJCET%>;  
		var USEROBJECT=<%=USEROBJECT%>;  
		var term_no=SYSOBJCET.term_no;
		var tea_no=USEROBJECT.loginname;      
		var depno=USEROBJECT.userinfo.dep_no;
		$("#export_dc").popup();       
		loadDropdown(tea_no);  //初始化下拉框和当前学期信息  
		
		function loadDropdown(tea_no){   //提取学期   
			
			$.ajax({ 
				url:"do?invoke=masterViewJudge@getTermInf",  
				type:'POST',  
				dataType:'json',   
				success:function(rep){ 			 	  
						
						var termInf=rep.data;
						for(var i=0;i<termInf.length;i++) 
							{
								var dom='<div class="item termInf" name="'+termInf[i].term_no+'">'+
										termInf[i].term_name +
				  			  			'</div>';
				  					$(".menu.infro").append($(dom)); 
									if(parseInt(termInf[i].term_status)==1){ 
										loadtabletitle(termInf[i].term_no ,tea_no); //加载考核评分项
										
										$(".default.text").text(termInf[i].term_name);
									}	 				 	
							}  
						 
							$('.ui.dropdown') 
						  	.dropdown();   
							
							$(".termInf").click(function(){  //更换学期 
								 $('#tableinf').show(); 
								  $('#messageinf').remove();
								$('#dimmerDiv').prepend($(dimmer));
								$('tbody').empty(); 
								$('#theadone').empty(); 
								term_no=$(this).attr("name");     
								loadtabletitle(term_no,tea_no); 
							})	
							
				} 
			});  
		} 
		
		//导出功能
    	$("#export_dc").unbind('click').click(function(){
			var params = [];			
			params.push(term_no);
			params.push(depno);
			var type = "excel";   
			open(BASE_PATH+"/qm/base/export.jsp?export_id=8&params="+params+"&type="+type+"&more=1");			    
    	});
		
	function loadtabletitle(term_no , tea_no){
		$.ajax({
			url:"do?invoke=masterViewJudge@getjudgerule",  
			type:'POST',  
			dataType:'json', 
			async: false, 
			data:{
				term_no:term_no,
				tea_no:tea_no,
			},
			success:function(rep){ 		 
				 if(rep.result==0){
					  $('#dimmerModule').remove();  
					  $('#tableinf').hide();
					  var dom='<div class="ui green large message" id="messageinf">'+
						'<i class="announcement large inverted yellow up circular icon"></i>'+
							' 该学期没有教师考核记录！'+   
						'</div>';  

						$('#container').append($(dom)); 
					  
				  }else{ 
					 
					  var table_title=rep.data; 
						var titleinf=table_title[0].rule_title+"—"+table_title[0].dep_name;  
						$('#inftitle').text(titleinf);   
							var dom='<tr class="title">'+  
									'<th >教工号</td>'+  
									'<th id="jgxm">教工姓名</td>'+
									'<th id="jgzc">教工职称</td>';  
							for(var i=0;i<table_title.length;i++){   
								 dom+='<th class="titleitem" data-content="'+table_title[i].rule_item_formula+'%">'+table_title[i].rule_item_title+'</td>';
								 if(i==table_title.length-1){
									 dom+='<th id="sum">总分 </td>'+    
									 		'</tr>';   
								 }   
							}
							 
							$('#theadone').append($(dom));  
							$('.titleitem').popup();
						  	//===================================== 
						  	$.ajax({
								url:"do?invoke=masterViewJudge@getteacher",  
								type:'POST',
                                timeout:100000,
								dataType:'json',  
								data:{
									dep_no:table_title[0].dep_no,
									term_no:term_no,
								}, 
								success:function(tearep){  	
									
									var table_content=tearep.data; 
									//绘制表格--------------------------
									
									for(var i=0;i<table_content.length;i++){
										var dom='<tr class="content">'+
										'<td class="tea_no">'+table_content[i].teacher_no+'</td>'+ 
										 
										'<td>'+table_content[i].teacher_name+'</td>'+  
										'<td class="tea_title">'+table_content[i].teacher_inf[0].teacher_title+'</td>'; 
										var sum=""; 
										for(var j=0;j<table_title.length;j++){
											var score=0;
											
											if(table_content[i].teacher_inf[0][table_title[j].rule_item_field]!=""&&table_content[i].teacher_inf[0][table_title[j].rule_item_field]!="0.0"){ 
												score=parseFloat(table_content[i].teacher_inf[0][table_title[j].rule_item_field]); 
											} 
											sum=table_content[i].teacher_inf[0].total;      
											if(table_title[j].rule_item_field!='ddtk'&&table_title[j].rule_item_field!='xspj'){
												dom+='<td ><div class="ui mini input" id="'+table_title[j].rule_item_field+'" name="'+table_title[j].rule_item_formula+'"><input class="inputscore" type="text" placeholder="'+score+'" ></div></td>';  
											}  
											else{
												dom+='<td><a  name="'+table_title[j].rule_item_field+'">'+score+'</a></td>';  
											} 
											if(j==table_title.length-1){    
												dom+='<td class="sum">'+sum+'</td>'+'</tr>'; 
											}
										} 
										
										$(".tbody.one").append($(dom));
									}
									 
									//----------------------------
									$('#dimmerModule').remove(); 
									
									$('.inputscore').unbind('focus').focus(function(){
										if($(this).val()!=""){
											var oldgrand=parseFloat($(this).val());
										}else{ 
											var oldgrand=parseFloat($(this).attr("placeholder")); 
										}
		 							
										$(this).unbind('blur').blur(function(){   //输入分数 
											var grandMax=parseInt($(this).parent().attr("name"));
											var grand=parseFloat($(this).val());  
											var teacher_no=$(this).parents('.content').find('.tea_no').text(); 
											var field=$(this).parent().attr("id");
											if(grand>=0)
											{ 
												if(grand>=grandMax)
													{
														$(this).val(grandMax);  
													}
												else{   
														$(this).val(Math.round(grand*100)/100.);      
												}  
												var score=parseFloat($(this).val());
												 var oldsum=parseFloat($(this).parents('.content').find('.sum').text());
												
												 var newsum=oldsum-oldgrand+score; 
												$(this).parents('.content').find('.sum').text(newsum);  
												
												savescore(term_no , teacher_no , score ,field , newsum);//保存到数据库 
											} 
										else 
											{
												$(this).val("");
											} 
										})  //-----
									})
									
									
									$('a').click(function(){      //点击查看详情
										
										$('.tbody.two').empty();//清空弹出层 
										var teacher_no=$(this).parents('.content').find('.tea_no').text();
										if($(this).attr("name")=="ddtk"){
											getddtk(teacher_no , term_no);
										}
										if($(this).attr("name")=="xspj"){ 
											getxspj(teacher_no , term_no);
										}
										$(this).css("color","green");  
									})
								}
						  	});
						  
				  }
				
			}
		});
	}
	
	function savescore(term_no , teacher_no , score ,field ,newsum){
		$.ajax({
			url:"do?invoke=masterViewJudge@savescore", 
			type:'POST',  
			dataType:'json',  
			data:{ 
				term_no:term_no,
				teacher_no:teacher_no,
				score:score,
				field:field,
				newsum:newsum,
			},
			success:function(rep){
				
			}
		});
	}
	function getddtk( teacher_no, term_no){
		$.ajax({
			url:"do?invoke=masterViewJudge@getddtk", 
			type:'POST',   
			dataType:'json',  
			data:{ 
				term_no:term_no,
				teacher_no:teacher_no,
			},
			success:function(rep){
				var ddtkinf=rep.data;
				$('#tableTitle').text("教师听课详情");
				var dom='<tr>'+	      
					      '<td>听课教师</td>'+
					      '<td>听课时间</td>'+
					      '<td>课程名称</td>'+
					      '<td>上课班级</td>'+
					      '<td>课程类型</td>'+
					      '<td>得分</td>'+
					    '</tr>';
					    $('.tbody.two').append($(dom));  
				//绘制弹出层
				for(var j=0;j<ddtkinf.length;j++)
					{
						var times=ddtkinf[j].listen_time.split(" ");      
						var listentime=times[0]; 
						var table='<tr class="listenInf">'+    
					      '<td>'+ddtkinf[j].teacher_name+'</td>'+ 
					      '<td>'+listentime+'</td>'+ 
					      '<td>'+ddtkinf[j].course_name+'</td>'+ 
					      '<td>'+ddtkinf[j].class_name+'</td>'+     
					      '<td>'+ddtkinf[j].course_type+'</td>' +  
					      '<td>'+ddtkinf[j].total+'</td>' +       
					    '</tr>';
						$('.tbody.two').append($(table)); 
					}
				$('.modal.long') //弹出层初始化 
				  .modal('show')      
				;  
			} 
		}); 
	}
	
	function getxspj(teacher_no , term_no){
		$.ajax({
			url:"do?invoke=masterViewJudge@getxspj", 
			type:'POST',  
			dataType:'json',  
			data:{ 
				term_no:term_no,
				teacher_no:teacher_no,
			}, 
			success:function(rep){
				var sxpjinf=rep.data;
				$('#tableTitle').text("学生评教详情");
				var dom='<tr>'+	      
					      '<td>课程名称</td>'+
					      '<td>评教班级</td> '+
					      '<td>班级人数</td>' +
					      '<td>已评人数</td> ' +
					      '<td>平均得分</td> '+
					    '</tr>';
					    $('.tbody.two').append($(dom));  
				    for(var j=0;j<sxpjinf.length;j++)
					{
						var table='<tr class="commentInf">'+    
					      '<td>'+sxpjinf[j].course_name+'</td>'+ 
					      '<td>'+sxpjinf[j].class_name+'</td>'+ 
					      '<td>'+sxpjinf[j].class_stu_amount+'</td>'+     
					      '<td>'+sxpjinf[j].class_stu_check+'</td>' +   
					      '<td>'+Math.round(parseFloat(sxpjinf[j].total)/parseFloat(sxpjinf[j].class_stu_check)*100)/100+'</td>' +       
					    '</tr>';
						$('.tbody.two').append($(table)); 
					}
				$('.modal.long') //弹出层初始化 
				  .modal('show')      
				; 
			}
		});
	}
	});//JQ
	//--------------------------

</script>
<!--这里引用其他JS-->
</html>