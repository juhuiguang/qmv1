<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>

<!--这里引用其他样式-->
<title></title>
<style>
	.circular.ui.blue.basic.icon.button {
		margin-left: 10px;
	}
	#chart {
		width:100%;
		height:450px;
	}
	#vclass_term {
		float:right;
	}
	#messageinf{
		margin-top: 20px;
	}
	#depdiv{
		margin-top: 10px;
	}
</style>
<script src="script/common/echarts/echarts-all.js"></script>
</head>
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<%
		//接收参数
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String dep_name = "";
		String term_no = "";
		if (request.getParameter("dep_name") != null && request.getParameter("term_no") != null) {
			dep_name = (String) request.getParameter("dep_name");
			dep_name = new String(dep_name.getBytes("ISO-8859-1"),"utf-8");
			term_no = (String) request.getParameter("term_no");
		} 
	%>
	<div id="container">
				<h3  class="ui header "> 
			  			<i class="unordered list icon"></i>
			  			<div class="content">督学查看部门上课质量 </div>
				</h3>		
			
		<select class="ui small dropdown" id="dropdown">
		
		</select>
			
		<div id="depdiv">
			<a class="ui blue label" id="tabledata">表格数据</a>
			<a class="dep ui gray label" id="chartdata">图表概览</a>
		</div>
		
		<div id="tableinformation" style="margin-top: 10px;">

		</div>
		
		<div id="chartinformation">
		
		</div>
		
		<div id="popdetail" class="ui modal">
			  <div class="header">
			    教师被听课详情:
			    <i class="close icon" style="float: right;"></i>
			  </div>
			  <div class="content">
			  	<div class="description">
			  		<div class="ui two cards" id="tablemodel">
			  		
			  		</div>
			    </div>
			  </div>
		</div>
		
		<div id="poppers" class="ui modal">
			  <i class="close icon"></i>
			  <div class="header">
			    督学打分详情:
			  </div>
			  <div class="content">
			  	<div class="description" id="persmod">		  	
  	
			  	</div>
			  </div>
		</div>
		
	</div>
	<!--这里绘制页面-->
</body>
<script>
	$(function() {	
		
		var depname="";
		var dqtermno="";
		dqtermno='<%=term_no%>'
		depname='<%=dep_name%>'
		if(depname == "") {
			depname = USEROBJECT.userinfo.dep_name;
		}
		if(dqtermno == ""){
			dqtermno=SYSOBJCET.term_no;
		}
		downAllTerm();
		var sourse = [];  
	    
		var chooseid = "tabledata";
		$("#depdiv .label").unbind("click").click(function(){
			$("#depdiv .blue").removeClass("blue");
			$(this).addClass("blue");
			chooseid = this.id;

			if(chooseid == "tabledata") {
				$('#tableinformation').empty();
				$('#chartinformation').empty();
				viewclass(dqtermno);
			} else {
				$('#tableinformation').empty();
				$('#chartinformation').empty();
				viewchart(sourse);
			}
		});
		viewclass(dqtermno);
		function viewclass(dqtermno) {	
			$("#tableinformation").empty();
			var temp=
				'<table class="ui compact blue table" >'+
					  '<thead>'+
					    '<tr>'+
					      '<th>教师工号</th>'+
					      '<th>姓名</th>'	+		      
					      '<th>平均得分</th>'+
					      '<th>被听课次数</th>'+
					      '<th>查看详情</th>'+
					    '</tr>'+
					  '</thead>'+
					  '<tbody id="tablepane">'+
					  '</tbody>'+
				'</table>';
				$('#tableinformation').append(temp);			
			$.ajax({
				url:"do?invoke=supervisorViewClass@getSupViewClass",
				type:'POST',
				dataType:'json',
				data:{
					supno:'<%= USEROBJECT.getString("loginname")%>',
					depname:depname,
					termno:dqtermno
				},
				success:function(rep) {
					console.log(rep);
					if(rep.result == 0) {
					//	$.alert("",rep.message);
						var dom1=
							'<div class="ui green large message" id="messageinf">'+
								'<i class="announcement large inverted yellow up circular icon"></i>'+
								' 没有该学期的数据！'+   
							'</div>';
						 $('#tableinformation').empty();
						 $('#tableinformation').append(dom1);
					} else {
						var table = rep.data;
						for(var i=0;i<table.length;i++) {
							var dom=
								'<tr>'+
									'<td>'+table[i].teacher_no+'</td>'+
									'<td>'+table[i].teacher_name+'</td>';	
									
									if((table[i].total == null || table[i].total == "") && table[i].listentotal == 0) {
										dom += '<td> 0 </td>';
									} else {
										dom += '<td>'+table[i].total+'</td>';
									}            
									
									dom +=
									'<td>'+table[i].listentotal+'</td>'+
									'<td>'+
										'<div class="btnfirst circular mini ui blue basic icon button" id="'+table[i].teacher_no+'" data-content="点击我可以查看本教师被听课的详情~">'+
					                     	'<i class="file text icon"></i>'+
						                 '</div>'+ 	                
					                 '</td>'+
								'</tr>';															
							$("#tablepane").append($(dom));	
							$('.btnfirst').popup();
							sourse[i] = table[i].total;
							
						}
						$('.btnfirst').click(function(){														
							var teano=$(this).attr("id");
							showModify(teano,dqtermno);	
							console.log(dqtermno);
						});						
					}
				}
			});
		}
	 
		function showModify(teano,dqtermno){
			$('#popdetail').modal({
				transition:'slide down',
				observeChanges:true,
				closable:false
			}).modal('show');
			$("#tablemodel .ui.card").remove();
			$.ajax({
				url:"do?invoke=supervisorViewClass@getSupViewClassXQ",
				type:'POST',
				dataType:'json',
				data:{
					teano:teano,
					termno:dqtermno
				},
				success:function(rep) {
					console.log(rep);
					if(rep.result == 0) {         
						$.alert("",rep.message);
					} else {
						var cont = rep.data;	
						
						for(var j=0;j<cont.length;j++) {
							var dom2=								
								'<div class="ui card">'+
								  '<div class="content">'+
								    '<div class="header">'+ cont[j].teacher_name +'</div>'+
								    '<div class="meta">'+ cont[j].listen_time +'</div>'+
								    '<div class="description">'+
								      '<p>《'+ cont[j].course_name +'》</p>'+
								      '<p>教学建议：'+ cont[j].jxjy +'</p>'+
								      '<p>上课评价：'+ cont[j].skpj +'</p>'+
								    '</div>'+
								  '</div>'+							  								  
								  '<div class="firstbut ui blue basic icon button" taskno="'+cont[j].task_no+'" teano="'+cont[j].teacher_no+'">评分：'+ cont[j].total +'</div>'+
								'</div>';
							$("#tablemodel").append($(dom2));
						}
						$('.firstbut').click(function(){
							var taskno=$(this).attr("taskno");
							var teano=$(this).attr("teano");
							showPfxqModify(taskno,teano,dqtermno);								
						});
					}
				}
			});	
		}
		
		function showPfxqModify(taskno,teano,dqtermno) {
			$('#poppers').modal({								
				transition:'slide down',
				observeChanges:true,
				closable:false
			}).modal('show');
			$.ajax({
				url:"do?invoke=supervisorViewClass@getDetails",
				type:'POST',
				dataType:'json',
				data:{
					teano:teano,
					taskno:taskno,
					termno:dqtermno
				},
				success:function(rep) {
					console.log(rep);
					if(rep.result == 0) {
						$.alert("督学评分详情数据获取为空！");
					} else {
						var pers = rep.data;	
						$('#persmod').html("");
						for(var k=0; k<pers.length; k++) {
							var x=k+1;
							var dom3=								
								'<div>'+ 
								  '<p>' + x + ' 、'  + pers[k].rule_title +'：' + pers[k].rule_per + '&nbsp;分</p>' +								   
								'</div>';
							$("#persmod").append($(dom3));
						}
					}
				}
			});
		}
		
		
		
		function viewchart(sourse){
			$("#chartinformation").empty();
			if(sourse.length!=0) {
 			var tmp=
				'<div class="ui segment" id="chart">'+
					'<div id="chart">'+
					
					'</div>'+
			    '</div>';
			    $('#chartinformation').append(tmp); 
			var sixless = 0;
			var sixseven = 0;
			var seveneight = 0;
			var eightnine = 0;
			var ninemore = 0;
			for(var j=0; j<=sourse.length-1; j++) {
				if(sourse[j] < 60) {
					sixless += 1;
				} else if (sourse[j] >= 60 && sourse[j] <70) {
					sixseven +=1;
				} else if (sourse[j] >= 70 && sourse[j] <80) {
					seveneight +=1;
				} else if (sourse[j] >= 80 && sourse[j] <90) {
					eightnine += 1;
				} else if (sourse[j] >= 90) {
					ninemore += 1;
				}
			}
   		 	var myChart = echarts.init(document.getElementById('chart'));
   		 	var option = {
   		 	    tooltip : {
   		         trigger: 'item',
   		         formatter: "{a} <br/>{b} : {c} ({d}%)"
   		     },
   		     legend: {
   		         orient : 'vertical',
   		         x : 'left',
   		         data:['60分以下','【60分-69分】','【70分-79分】','【80分-89分】','【90分以上】']
   		     },
   		     toolbox: {
   		         show : true,
   		         feature : {
   		             mark : {show: true},
   		             dataView : {show: true, readOnly: false},
   		             magicType : {
   		                 show: true, 
   		                 type: ['pie', 'funnel'],
   		                 option: {
   		                     funnel: {
   		                         x: '25%',
   		                         width: '50%',
   		                         funnelAlign: 'center',
   		                         max: 1548
   		                     }
   		                 }
   		             },
   		             restore : {show: true},
   		             saveAsImage : {show: true}
   		         }
   		     },
   		     series : [
   		         {
   		             name:'教师平均分区间划分',
   		             type:'pie',
   		             radius : ['50%', '70%'],
   		             itemStyle : {
   		                 normal : {
   		                     label : {
   		                         show : false
   		                     },
   		                     labelLine : {
   		                         show : false
   		                     }
   		                 },
   		                 emphasis : {
   		                     label : {
   		                         show : true,
   		                         position : 'center',
   		                         textStyle : {
   		                             fontSize : '30',
   		                             fontWeight : 'bold'
   		                         }
   		                     }
   		                 }   		                 
   		             },
   		             data:[
   		                 {value:sixless, name:'60分以下'},
   		                 {value:sixseven, name:'【60分-69分】'},
   		                 {value:seveneight, name:'【70分-79分】'},
   		                 {value:eightnine, name:'【80分-89分】'},
   		                 {value:ninemore, name:'【90分以上】'}
   		             ]
   		         }
   		     ]
   		 };
   		 myChart.setOption(option);    
			} else {
				var dom=
					'<div class="ui green large message" id="messageinf">'+
						'<i class="announcement large inverted yellow up circular icon"></i>'+
						' 没有该学期的数据！'+   
					'</div>';
				 $('#chartinformation').append(dom);
			}
		}
		
/* 		viewdropdown();
		function viewdropdown() {
			var drop=
				'<div class="ui selection dropdown" id="vclass_term">'+
				  '<input type="hidden" name="gender">'+
				  '<div class="default text"><--请选择学期--></div>'+
				  '<i class="dropdown icon"></i>'+
					  '<div class="menu" id="termdrowp">'+
					    
					  '</div>'+
				'</div>';
				 $('#termdropdown').append(drop);
			$.ajax({
				url:"do?invoke=supervisorViewClass@getViewTerm",
				type:'POST',
				dataType:'json',
				success:function(rep) {
					console.log(rep);
					if(rep.result == 0) {
						$.alert("学期号获取失败！");
					} else {
						var table = rep.data;
						for(var i=0;i<table.length;i++) {
							var dom =
							'<div class="item" data-value="'+table[i].term_no+'">' +table[i].term_name+ '</div>';
							$("#termdrowp").prepend($(dom));
						}
						$("#vclass_term").dropdown();
						$('.item').click(function() {
							sourse.splice(0,sourse.length);//清空sourse 数组   
							termno = $(this).attr("data-value");
							$('#tableinformation').empty();
							viewclass(termno);
						});
					}
				}
			});
		} */
		
		
	     function downAllTerm(){
	    	$.ajax({
				url:"do?invoke=supervisorViewClass@getAllTerm",
				type:'POST',
				dataType:'json',
				async:false,
				success:function(rep){
					if(rep.result==0){
						$.alert("",rep.message);
						return;
					} else {
						var temp=rep.data;
						for(var i=0;i<temp.length;i++){
							
							var dom= '<option value="'+temp[i].term_no+'">'+temp[i].term_name+'</option>';
							$("#dropdown").append(dom);
						}
						$('.ui.small.dropdown').dropdown().dropdown("set selected",dqtermno);
						
					}
					$("#dropdown").change(function(){
						console.log(dqtermno);
						sourse.splice(0,sourse.length);//清空sourse 数组   
						dqtermno=$("#dropdown").val();
						$('#tableinformation').empty();
						viewclass(dqtermno);				
					});
				}
	    	});
	    }
	});
</script>
<!--这里引用其他JS-->
</html>