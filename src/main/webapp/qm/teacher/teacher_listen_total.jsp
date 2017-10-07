<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp" %>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp" %>
<!--这里引用其他样式-->
<title>欢迎使用-首页</title>
<style>
	#depdiv { 
		margin-top: 10px;
	}
	#TableChartMenu { 
		margin-left: 86%;
	} 
	#JOBTableChartMenu {  
		margin-left: 86% !important;
	} 
	.circular.inverted.icon:hover {
		cursor:pointer; 
	}
	
	/* 按部门看 的按钮 */
	i.inverted.circular.icon.TableIcon {
    	background-color: #BBEFEC !important;
	}
	i.inverted.circular.icon.ChartIcon {
	    background-color: #FFC1C1 !important;
	} 
	
	/* 按岗位看 的按钮 */
	i.inverted.circular.icon.jobTableIcon {
    	background-color: #BBEFEC !important;
	}
	i.inverted.circular.icon.jobChartIcon {
	    background-color: #FFC1C1 !important;
	}

	/* 按部门看  的鼠标经过颜色  */
	i.inverted.circular.icon.TableIcon:hover {
	    background-color: #00b5ad !important; 
	}
	i.inverted.circular.icon.active.TableIcon {
	    background-color: #00b5ad !important; 
	}
	i.inverted.circular.icon.ChartIcon:hover {
		background-color: #db2828 !important; 
	}
	i.inverted.circular.icon.active.ChartIcon {
		background-color: #db2828 !important; 
	}
	i.inverted.circular.icon.ExportIcon {
		background-color: orange !important;  
	}
	
	/* 按岗位看  的鼠标经过颜色*/
	i.inverted.circular.icon.jobTableIcon:hover {
	    background-color: #00b5ad !important; 
	}
	i.inverted.circular.icon.selected.jobTableIcon {
	    background-color: #00b5ad !important; 
	}
	i.inverted.circular.icon.jobChartIcon:hover {
		background-color: #db2828 !important; 
	}
	i.inverted.circular.icon.selected.jobChartIcon {
		background-color: #db2828 !important; 
	}
	i.inverted.circular.icon.jobExportIcon {
		background-color: orange !important;   
	}

 	.depD.center.aligned:hover {
 		cursor:pointer;  
 		color: orange;  
 		font-size: 104% !important;
 	}
 	.singlDep.center.aligned .click:hover {  
 		cursor:pointer;  
 		color: #FFBB3A;      
 		font-size: 100% !important;  
 	}
 	.JobData.center.aligned:hover {
 		cursor:pointer;   
 		color: orange;  
 		font-size: 104% !important;
 	}
 	.singlJob.center.aligned .click:hover { 
 		cursor:pointer;  
 		color: #FFBB3A;      
 		font-size: 100% !important; 
 	}
 	#ChartPanel {
 		height:600px;
 	}  
</style> 
<script src="script/common/echarts/echarts-all.js"></script>
</head>
<body>
<%@ include file="/commonjsp/header.jsp"%>
	<div id="container" class="ui container"> 
		<h3  class="ui header "> 
	  			<i class="list layout icon"></i> 
	  			<div class="content">教师听课次数统计</div>
		</h3>
		
		<select class="ui mini dropdown" id="dropdown">
		</select>
		
		<div id="depdiv"> 
			<a class="ui blue label" id="depdata">分部门查看</a>
			<a class="dep ui gray label" id="jobdata">分岗位查看</a>
		</div>
		
		<div class="menu" id="TableChartMenu">  
			<i id="TableBut" class="dep circular inverted active table icon TableIcon emptyTable" data-content="表格" data-variation="small" style="margin-right: -2px;"></i>
			<i id="ChartBut" class="dep circular inverted bar chart icon ChartIcon emptyTable" data-content="图表" data-variation="small"></i>
			<i id="ExportBut" class="dep circular inverted upload export icon ExportIcon" data-content="导出" data-variation="small" style="margin-left: 20px;"></i>
		 </div>
		  
		 <div class="menu" id="JOBTableChartMenu">  
			<i id="JobTableBut" class="job circular inverted selected table icon jobTableIcon jobTableIcon1" data-content="表格" data-variation="small" style="margin-right: -2px !important;"></i>
			<i id="JobChartBut" class="job circular inverted bar chart icon jobChartIcon jobTableIcon1" data-content="图表" data-variation="small"></i>
		 	<i id="JobExportBut" class="job circular inverted upload export icon jobExportIcon" data-content="导出" data-variation="small" style="margin-left: 20px;"></i>
		 </div>
		 
		
		<div id="DepViewPanel"> 

 		</div>
 		
 		<div id="modsup" class="ui modal gr">      
			  <div class="header">
			    教师听课详情:     
			    <i class="close icon" style="float: right;"></i>
			  </div>
			  <div class="content">
			  	<div class="description">
			  		<div class="ui two cards" id="tablemodelgr">
			  		
			  		</div>			  
			    </div>
			  </div>
		</div>
 		
	<!--这里绘制页面-->
	</div>
</body>
<script src="script/common/alert/jquery.alert.js" type="text/javascript"></script>
<script>
	 $(function() {
		 var termid= SYSOBJCET.term_no; 
		 var purview=USEROBJECT.userpurview; 
		 var dqdepno=""; 
		 var DepTeaLisD = ""; 
		 var SinglDepD = "";
		 var SinglDepTeaD = ""; 
		 var JobTeaLisD = "";  
		 var JobSinglLisD = ""; 
		 var cho_lab = "depdata";
		 var cho_but = "TableBut";  
		 var jobcho_but ="JobTableBut";
		 var teano = "";
		 downAllTerm(); 
		 console.log("---------------------"+purview);   
		 $('.circular.inverted').popup();
		 if(purview=="ALL"){
			 dqdepno="all";
			//取所有听课数据( 按部门，学期)
			 readTeaLisData();
			//取所有听课数据( 按岗位，学期)
		     readJobLisData();
			
		 }else{ 
			 dqdepno=USEROBJECT.userinfo.dep_no;
			//取所有听课数据( 按部门，学期)
			 readTeaLisData();
			
			//不是All 权限，岗位无权限查看  
		 }
		 
		 
		 
		 $("#depdiv .label").unbind("click").click(function(){
			$("#depdiv .blue").removeClass("blue");
			$(this).addClass("blue"); 
			cho_lab = this.id;
			console.log(cho_lab); 
			$("#DepViewPanel").empty();    
			$("#TableChartMenu").hide();   
			$("#JOBTableChartMenu").hide();
			if(cho_lab == "depdata") {
				
				$('i.dep.inverted.circular.active.icon').removeClass('active');
				$('i.dep.circular.inverted.table.icon.TableIcon').addClass('active');   
				cho_but = "TableBut"; 
				//取所有听课数据( 按部门，学期)
				 readTeaLisData();
				 drawDepTable();   
			} else {
				if(purview=="ALL"){ 
					
					$('i.job.inverted.circular.selected.icon').removeClass('selected');
					$('i.job.circular.inverted.table.icon.jobTableIcon').addClass('selected');   
					jobcho_but = "JobTableBut";    
					//取所有听课数据( 按岗位，学期)
				     readJobLisData(); 
					drawJobTeaLisData(); 
				} else {
					$.alert("很抱歉，您暂无权限查看该页面！");
				}
			}
		 }); 
		 
		 function exportExcel(){
	     		if(purview=='ALL'){
					var params = [];
		     		params.push(termid);
					var type = "excel";
					open(BASE_PATH+"/qm/base/export.jsp?export_id=15&params="+params+"&type="+type+"&more=3");
	     		}else{
	     			var params = [];
		     		params.push(termid);
		     		params.push(dqdepno+',');
		     		params.push(termid);
		     		params.push(dqdepno);
					var type = "excel";
					console.log(params)
					open(BASE_PATH+"/qm/base/export.jsp?export_id=16&params="+params+"&type="+type+"&more=2");
	     		} 
				
	     }
		  
		 function jobexportExcel() {
			 if(purview=='ALL'){
					var params = [];
		     		params.push(termid);
					var type = "excel";
					open(BASE_PATH+"/qm/base/export.jsp?export_id=22&params="+params+"&type="+type+"&more=3");
	     	  }
		 }
		     bindClick();
			//导出功能
			function bindClick(){
			    $('#ExportBut').unbind('click').click(function(){
			    	exportExcel();
			    });
			    $('#JobExportBut').unbind('click').click(function(){
				console.log("绑定点击事件")
			    	
			    	jobexportExcel();
			    });
			}
	 
		 
		 function readTeaLisData() {
			 console.log("vvvvvvvvvvvvv");    
			 console.log(termid);
			 console.log(dqdepno);  
			 $.ajax({
				 url: "do?invoke=teacherLisTotal@getTeaLisInfor",
				 type: 'POST',
				 async: false,
				 dataType: 'json',
				 data:{
					 term_no:termid,
					 dep_no:dqdepno
				 },  
				 success: function(rep) {
					 if(rep.result == 0) {
						 console.log("################");  
						 DepTeaLisD = ""; 
						 if(purview=="ALL"){
							 $.alert("按各部门统计教师听课数据获取失败！");
						 } else {
							 $.alert("此部门教师听课数据获取失败！"); 
						 }
						 return;
					 } else {
						 console.log(rep);
						 DepTeaLisD = rep.data;
						 //画按部门统计的表一
						 drawDepTable();
					 }
				 }
			 }); 
		 }
		 
		 function readJobLisData() {
			 $.ajax({
				 url: "do?invoke=teacherLisTotal@getJobTeaLisInfor",
				 type: 'POST',
				 async: false,
				 dataType: 'json',
				 data:{
					 term_no:termid
				 },
				 success: function(rep) {
					 if(rep.result == 0) {
						 JobTeaLisD = "";   
						 $.alert("按各岗位统计教师听课数据获取失败！");
						 return;
					 } else {
						 console.log(rep);
						 JobTeaLisD = rep.data;
						/*  //画按岗位查看教师听课统计数据的表1
						 drawJobTeaLisData(); */     /* 先不要画，等点击了 按岗位查看 的标签时再画表格出来  */
					 } 
				 }
			 });
		 }
		 
		 
		 
		  
		 
		 $('.emptyTable').unbind('click').click(function(){
			 $('i.dep.inverted.circular.active.icon').removeClass('active');
			 $(this).addClass('active');   
			 cho_but = this.id;  
			/*  if(cho_but == "ExportBut") {
				 return;
			 } else { 
			 }
			  */
			 if(cho_but == "TableBut") { 
				 $("#DepViewPanel").empty();     
				 drawDepTable(); 
			 } else if(cho_but == "ChartBut") {  
				 $("#DepViewPanel").empty();   
				 drawDepChart();
			 }

		 });
		 
		 $('.jobTableIcon1').unbind('click').click(function(){
			 $('.jobTableIcon1').removeClass('selected');
			 $(this).addClass('selected');   
			 jobcho_but = this.id;  
			 /* if(jobcho_but == "JobExportBut") {
				 return; 
			 } else {
				 $("#DepViewPanel").empty();     
			 } */
			 
			 if(jobcho_but == "JobTableBut") { 	
				 $("#DepViewPanel").empty();
				 drawJobTeaLisData();  
			 } else if(jobcho_but == "JobChartBut") {  
				 $("#DepViewPanel").empty();       
				 drawJobTeaLisChart();
			 }

		 });

		 function drawDepTable() {
			 $("#DepViewPanel").empty();  
			 $("#JOBTableChartMenu").hide();  
			 $("#TableChartMenu").show();  
			 var temp =
				 '<table class="ui striped celled table" id="tablepane">'+
				  '<thead>'+
				    '<tr>'+
				      '<th class="center aligned">部门</th>'+
				      '<th class="center aligned">部门总人数</th>'+
				      '<th class="center aligned">听课人数</th>'+ 
				      '<th class="center aligned">被听课人数</th>'+
				      '<th class="center aligned">听课总次数</th>'+
				    '</tr>'+   
				  '</thead>'+ 
				  '<tbody id="PostTableD">'+
		
				  '</tbody>'+
				'</table>';
				$("#DepViewPanel").append($(temp));  
				 
			 for(var i=0; i<DepTeaLisD.length; i++) {
				 var dom =
					 '<tr class="depD center aligned" id="'+DepTeaLisD[i].dep_no+'">'+
					 	'<td>'+DepTeaLisD[i].dep_name+'</td>';
					 if(DepTeaLisD[i].zrs == '' || DepTeaLisD[i].zrs == null) {
						 dom += '<td class="bj">0</td>'; 
						 
					 } else { 
						 dom += '<td>'+DepTeaLisD[i].zrs+'</td>';
					 }
					 if(DepTeaLisD[i].tkrs == '' || DepTeaLisD[i].tkrs == null) {
						 dom += '<td class="bj">0</td>';
					 } else {
						 dom += '<td>'+DepTeaLisD[i].tkrs+'</td>';
					 } 
					 if(DepTeaLisD[i].btkrs == '' || DepTeaLisD[i].btkrs == null) {
						 dom += '<td class="bj">0</td>';
					 } else {
						 dom += '<td>'+DepTeaLisD[i].btkrs+'</td>';
					 }
					 if(DepTeaLisD[i].tkzcs == '' || DepTeaLisD[i].tkzcs == null) {
						 dom += '<td class="bj">0</td>';
					 } else {
						 dom += '<td>'+DepTeaLisD[i].tkzcs+'</td>';
					 }
					dom += '</tr>';  
				$("#PostTableD").append($(dom)); 
			 }   
			$('.bj').css({'background-color':'#FFF7F7'});     
			$('.depD.center.aligned').unbind('click').click(function(){
				var dep_no = $(this).attr("id");
				console.log(dep_no);
				readSingDepData(dep_no,"table"); 
			});   
		 } 
		 
		 
		 //画按岗位查看教师听课统计数据的表1
		 function drawJobTeaLisData() {
			 $("#TableChartMenu").hide();   
			 $("#JOBTableChartMenu").show();  
			 var temp =
				 '<table class="ui striped celled table" id="tablepane">'+ 
				  '<thead>'+
				    '<tr>'+
				      '<th class="center aligned">岗位名称</th>'+
				      '<th class="center aligned">岗位总人数</th>'+
				      '<th class="center aligned">听课人数</th>'+  
				      '<th class="center aligned">规定听课总次数</th>'+
				      '<th class="center aligned">实际听课总次数</th>'+
				      '<th class="center aligned">听课情况</th>'+
				    '</tr>'+   
				  '</thead>'+  
				  '<tbody id="JobTeaLisTableD">'+
		
				  '</tbody>'+
				'</table>';
				$("#DepViewPanel").append($(temp)); 
				
				for(var i=0; i<JobTeaLisD.length; i++) {
				    var dom =
					   '<tr id="'+JobTeaLisD[i].job_no+'" class="JobData center aligned">'+
					  		'<td>'+JobTeaLisD[i].job_name+'</td>'+  
					  		'<td>'+JobTeaLisD[i].gjobrs+'</td>'+ 
					  		'<td>'+JobTeaLisD[i].gjobtkrs+'</td>';
					  		if(JobTeaLisD[i].job_listen_times == "" || JobTeaLisD[i].job_listen_times == null || JobTeaLisD[i].gjobrs == "" || JobTeaLisD[i].gjobrs == null) {
					  			dom += '<td></td>';
					  		} else {
					  			dom += '<td>'+eval(JobTeaLisD[i].job_listen_times) * eval(JobTeaLisD[i].gjobrs)+'</td>';
					  		}
					  		dom +=
					  		'<td>'+JobTeaLisD[i].gjobtkcs+'</td>';
					  		if(JobTeaLisD[i].job_listen_times == "" || JobTeaLisD[i].job_listen_times == null || JobTeaLisD[i].gjobrs == "" || JobTeaLisD[i].gjobrs == null) {
					  			dom += '<td></td>';
					  		} else {
					  			if(eval(JobTeaLisD[i].gjobtkcs) >= eval(JobTeaLisD[i].job_listen_times) * eval(JobTeaLisD[i].gjobrs)) {
					  				dom += '<td class="jobover">达标</td>';
					  			} else {
					  				dom += '<td class="jobunder">未达标</td>';  
					  			}
					  		}
					  	dom +=
					   '</tr>';
				    $("#JobTeaLisTableD").append($(dom));    
				}
				$('.jobover').css({'background-color':'#EAFFE8'});      
				$('.jobunder').css({'background-color':'#FFF7F7'});   
				$('.JobData.center.aligned').unbind('click').click(function(){
					var job_no = $(this).attr("id");
					console.log(job_no);   
					//取某一岗位的教师听课数据 
					readSinglJobData(job_no,"jobTable");
				});
		 }
		 
		 
		 function drawDepChart() {         
			  var count = [];  
			  var depnos = [];
			  for(var y=DepTeaLisD.length-1; y>=0; y--) {
				  depnos.push({
					  value:DepTeaLisD[y].dep_name,
					  depid:DepTeaLisD[y].dep_no
				  });
				  count.push(DepTeaLisD[y].tkzcs);
			  }
			  $("#ChartPanel").remove(); 
			  var tep =
			  		'<div class="ui segment" id="ChartPanel">'+
					
					'</div>'; 
			   $("#DepViewPanel").append($(tep));      
			   var myChart = echarts.init(document.getElementById('ChartPanel'));
	    		 myChart.setTheme("macarons");     // 设置echart的主题(改变颜色)
	    	     var option = {
	   	    		    title : {
	   	    		        text: '各部门教师听课统计'
	   	    		    },
	   	    		    tooltip : {
	   	    		        trigger: 'axis'
	   	    		    },
	   	    		    legend: {
	   	    		        data:['本部门教师听课次数']
	   	    		    },
	   	    		    toolbox: {
	   	    		        show : true,
	   	    		        feature : {
	   	    		            mark : {show: true},
	   	    		            dataView : {show: true, readOnly: false},
	   	    		            magicType: {show: true, type: ['line', 'bar']},
	   	    		            restore : {show: true},
	   	    		            saveAsImage : {show: true}
	   	    		        }
	   	    		    },
	   	    		    calculable : true,
	   	    		    xAxis : [
	   	    		        {
	   	    		            type : 'value',
	   	    		            boundaryGap : [0, 0.01]
	   	    		        }
	   	    		    ],
	   	    		    yAxis : [
	   	    		        {
	   	    		            type : 'category',
	   	    		            data : depnos
	   	    		        }
	   	    		    ],
	   	    		    series : [
	   	    		        {
	   	    		            name:'本部门教师听课次数',
	   	    		            type:'bar',
	   	    		            data:count,
	   	    		            itemStyle:{
	   	    		            	normal:{
	   	    		            		label:{
	   	    		            			show:true,
	   	    		            			textStyle:{
	   	    		            				color:'#000000'
	   	    		            			}
	   	    		            		}
	   	    		            	}
	   	    		            }  
	   	    		        
	   	    		        }
	   	    		    ] 
	   	    		};
	    	     myChart.setOption(option);
	    	      myChart.on(echarts.config.EVENT.CLICK,function(item){
	    	    	  console.log(depnos[item.dataIndex].value,depnos[item.dataIndex].depid);
	    	    	  readSingDepData(depnos[item.dataIndex].depid,"chart"); 
	    	      });
	    		 
		 }
		 
		 
		 function drawJobTeaLisChart() {
			  var count = [];  
			  var jobnos = [];
			  for(var y=JobTeaLisD.length-1; y>=0; y--) {
				  jobnos.push({
					  value:JobTeaLisD[y].job_name,
					  jobid:JobTeaLisD[y].job_no
				  });
				  count.push(JobTeaLisD[y].gjobtkcs);
			  }
			  $("#ChartPanel").remove(); 
			  var tep =
			  		'<div class="ui segment" id="ChartPanel">'+
					
					'</div>';  
			   $("#DepViewPanel").append($(tep));      
			   var myChart = echarts.init(document.getElementById('ChartPanel'));
	    		 myChart.setTheme("macarons");     // 设置echart的主题(改变颜色)
	    	     var option = {
	   	    		    title : {
	   	    		        text: '各岗位教师听课统计'
	   	    		    },
	   	    		    tooltip : {
	   	    		        trigger: 'axis'
	   	    		    },
	   	    		    legend: {
	   	    		        data:['本岗位教师听课次数']
	   	    		    },
	   	    		    toolbox: {
	   	    		        show : true,
	   	    		        feature : {
	   	    		            mark : {show: true},
	   	    		            dataView : {show: true, readOnly: false},
	   	    		            magicType: {show: true, type: ['line', 'bar']},
	   	    		            restore : {show: true},
	   	    		            saveAsImage : {show: true}
	   	    		        }
	   	    		    },
	   	    		    calculable : true,
	   	    		    xAxis : [
	   	    		        {
	   	    		            type : 'value',
	   	    		            boundaryGap : [0, 0.01]
	   	    		        }
	   	    		    ],
	   	    		    yAxis : [
	   	    		        {
	   	    		            type : 'category',
	   	    		            data : jobnos
	   	    		        }
	   	    		    ],
	   	    		    series : [
	   	    		        {
	   	    		            name:'本岗位教师听课次数',
	   	    		            type:'bar',
	   	    		            data:count,
	   	    		            itemStyle:{
	   	    		            	normal:{
	   	    		            		label:{
	   	    		            			show:true,
	   	    		            			textStyle:{
	   	    		            				color:'#000000'
	   	    		            			}
	   	    		            		}
	   	    		            	}
	   	    		            }
	   	    		        
	   	    		        }
	   	    		    ] 
	   	    		};
	    	      myChart.setOption(option);
	    	      myChart.on(echarts.config.EVENT.CLICK,function(item){ 
	    	    	  console.log(jobnos[item.dataIndex].value,jobnos[item.dataIndex].jobid);
	    	    	  readSinglJobData(jobnos[item.dataIndex].jobid,"jobChart");
	    	      });
	    		 
		 }
		 
		 
		 function readSingDepData(depno,clicktype) {
			 $.ajax({
				 url: "do?invoke=teacherLisTotal@getSinglDepLisInfor",
				 type: 'POST',
				 async: false,
				 dataType: 'json',
				 data:{
					 term_no:termid,
					 dep_no:depno
				 },  
				 success: function(rep) {
					 if(rep.result == 0) {
						 $.alert("获取本部门教师听课统计数据失败！"); 
						 return;
					 } else {
						 console.log(rep);  
						 SinglDepD = rep.data;
						 if(clicktype == "table") {
							//画点击某一部门后，该部门教师听课情况概览(表格 )
							 drawSinglDepTable();
						 } else {
							//画点击某一部门后，该部门教师听课情况概览(图表 )
							 drawSinglDepChart();
						 }
						 
					 } 
				 } 
			 });
		 }
		 
		 function readSinglJobData(jobno,clicktype) {
			 $.ajax({
				 url: "do?invoke=teacherLisTotal@getSinglJobLisInfor",
				 type: 'POST',
				 async: false,
				 dataType: 'json',
				 data:{
					 term_no:termid,
					 job_no:jobno
				 },  
				 success: function(rep) {
					 if(rep.result == 0) {
						 $.alert("获取本岗位教师听课统计数据失败！"); 
						 return;
					 } else {
						 console.log(rep);  
						 JobSinglLisD = rep.data;
						 if(clicktype == "jobTable") {
							//画某一岗位的相关教师听课数据 (表格 )
							drawSinglJobTable();
						 } else {
							 //画某一岗位的相关教师听课数据 (图表 )
							 drawSinglJobChart();   
						 }
					 }
				 }
			 });
		 }
		 
		 function drawSinglDepTable() {
			 $("#DepViewPanel").empty();  
			 $("#SingDepTable").empty(); 
			 var temp =
				 '<table class="ui striped celled table two">'+
				  '<thead>'+
				    '<tr>'+
				      '<th class="center aligned">部门</th>'+
				      '<th class="center aligned">工号</th>'+
				      '<th class="center aligned">姓名</th>'+
				      '<th class="center aligned">所属岗位</th>'+ 
				      '<th class="center aligned">被听课人数</th>'+ 
				      '<th class="center aligned">规定听课次数</th>'+
				      '<th class="center aligned">实际听课次数</th>'+
				      '<th class="center aligned">听课情况</th>'+
				    '</tr>'+   
				  '</thead>'+ 
				  '<tbody id="SingDepTable">'+
		
				  '</tbody>'+
				'</table>';
				$("#DepViewPanel").append($(temp));  
				for(var i=0; i<SinglDepD.length; i++) {
					var dom = 
						'<tr id="'+SinglDepD[i].teacher_no+'" class="singlDep center aligned">'+
							'<td>'+SinglDepD[i].dep_name+'</td>'+
							'<td>'+SinglDepD[i].teacher_no+'</td>'+
							'<td>'+SinglDepD[i].teacher_name+'</td>'+      
							'<td>'+SinglDepD[i].job_name+'</td>'+
							'<td>'+SinglDepD[i].bbrtkrs+'</td>'+
							'<td>'+SinglDepD[i].job_listen_times+'</td>';
							
							if(SinglDepD[i].grtkcs == "" || SinglDepD[i].grtkcs == null || SinglDepD[i].grtkcs <=0){
								dom += '<td>'+SinglDepD[i].grtkcs+'</td>';
							} else {
								dom += '<td class="click">'+SinglDepD[i].grtkcs+'</td>';
							}
							
							if(SinglDepD[i].job_listen_times == "" || SinglDepD[i].job_listen_times == null) {
								dom += '<td></td>';
							} else {
								if(eval(SinglDepD[i].grtkcs) >= eval(SinglDepD[i].job_listen_times)) {   
									dom += '<td class="over"> 达标 </td>';
								} else {
									dom += '<td class="under"> 未达标 </td>';  
								}
							} 
						dom +=
						'</tr>'; 
					 $("#SingDepTable").append($(dom));      
				}
				$('.over').css({'background-color':'#EAFFE8'});       
				$('.under').css({'background-color':'#FFF7F7'});    
				
				$('.singlDep.center.aligned .click').unbind('click').click(function(){
					teano = $(this).parent('.singlDep.center.aligned').attr("id");             
					readSinglDepTeaData();
				});
		 }
		 
		 function drawSinglJobTable() {
			 $("#DepViewPanel").empty();  
			 var temp =
				 '<table class="ui striped celled table three">'+
				  '<thead>'+
				    '<tr>'+
				      '<th class="center aligned">岗位名称</th>'+
				      '<th class="center aligned">工号</th>'+
				      '<th class="center aligned">姓名</th>'+
				      '<th class="center aligned">所属部门</th>'+ 
				      '<th class="center aligned">规定听课次数</th>'+
				      '<th class="center aligned">实际听课次数</th>'+
				      '<th class="center aligned">听课情况</th>'+
				    '</tr>'+   
				  '</thead>'+ 
				  '<tbody id="SinglJobTable">'+
		 
				  '</tbody>'+
				'</table>';
				$("#DepViewPanel").append($(temp));  
				for(var i=0; i<JobSinglLisD.length; i++) {
					 var dom =
						 '<tr id="'+JobSinglLisD[i].teacher_no+'" class="singlJob center aligned">'+ 
						 		'<td>'+JobSinglLisD[i].job_name+'</td>'+
						 		'<td>'+JobSinglLisD[i].teacher_no+'</td>'+
						 		'<td>'+JobSinglLisD[i].teacher_name+'</td>'+
						 		'<td>'+JobSinglLisD[i].dep_name+'</td>'+
						 		'<td>'+JobSinglLisD[i].job_listen_times+'</td>';
						 		
						 		if(JobSinglLisD[i].grtkcs == "" || JobSinglLisD[i].grtkcs == null || JobSinglLisD[i].grtkcs <= 0) {
						 			dom += '<td>'+JobSinglLisD[i].grtkcs+'</td>';
						 		} else {
						 			dom += '<td class="click">'+JobSinglLisD[i].grtkcs+'</td>';
						 		}
						 		
						 		if(JobSinglLisD[i].job_listen_times == "" || JobSinglLisD[i].job_listen_times == null) {
						 			dom += '<td></td>';
						 		} else {
						 			if(eval(JobSinglLisD[i].grtkcs) >= eval(JobSinglLisD[i].job_listen_times)) {
							 			dom += '<td class="singljobover">达标</td>';
							 		} else {
							 			dom += '<td class="singljobunder">未达标</td>';
							 		}
						 		}
						 dom+=  
						 '</tr>';
						 $("#SinglJobTable").append($(dom));
				}
				$('.singljobover').css({'background-color':'#EAFFE8'});      
				$('.singljobunder').css({'background-color':'#FFF7F7'});   
				$('.singlJob.center.aligned .click').unbind('click').click(function(){
					teano = $(this).parent('.singlJob.center.aligned').attr("id");    
					console.log(teano);   
					readSinglDepTeaData();  
				});
		 }
		 
		 function drawSinglDepChart() {  
			  var count = [];  
			  var teanos = [];
			  var depname = SinglDepD[0].dep_name;
			  for(var y=SinglDepD.length-1; y>=0; y--) {
				  teanos.push({
					  value:SinglDepD[y].teacher_name,
					  teaid:SinglDepD[y].teacher_no
				  });
				  count.push(SinglDepD[y].grtkcs);
			  }
			  $("#ChartPanel").remove();  
			  if(SinglDepD.length >30) {
				  var tep =    
				  		'<div class="ui segment" id="ChartPanel" style="height:'+eval(SinglDepD.length) * eval(30)+'px !important;">'+ 
						    
						'</div>';  
				   $("#DepViewPanel").append($(tep));  
			  } else {
				  var tep =    
				  		'<div class="ui segment" id="ChartPanel">'+ 
						    
						'</div>';    
				   $("#DepViewPanel").append($(tep));
			  }

			   var myChart = echarts.init(document.getElementById('ChartPanel'));
	    		 myChart.setTheme("macarons");     // 设置echart的主题(改变颜色)
	    	     var option = {
	   	    		    title : {
	   	    		        text: '此部门教师听课统计  (部门：'+depname+' )'
	   	    		    },
	   	    		    tooltip : {
	   	    		        trigger: 'axis'
	   	    		    },
	   	    		    legend: {
	   	    		        data:['本教师听课次数']
	   	    		    },
	   	    		    toolbox: {
	   	    		        show : true,
	   	    		        feature : {
	   	    		            mark : {show: true},
	   	    		            dataView : {show: true, readOnly: false},
	   	    		            magicType: {show: true, type: ['line', 'bar']},
	   	    		            restore : {show: true},
	   	    		            saveAsImage : {show: true}
	   	    		        }
	   	    		    },
	   	    		    calculable : true,
	   	    		    xAxis : [
	   	    		        {
	   	    		            type : 'value',
	   	    		            boundaryGap : [0, 0.01]
	   	    		        }
	   	    		    ],
	   	    		    yAxis : [
	   	    		        {
	   	    		            type : 'category',
	   	    		            data : teanos
	   	    		        }
	   	    		    ],
	   	    		    series : [
	   	    		        {
	   	    		            name:'本教师听课次数',
	   	    		            type:'bar',
	   	    		            data:count, 
	   	    		            itemStyle:{
	   	    		            	normal:{
	   	    		            		label:{
	   	    		            			show:true,
	   	    		            			textStyle:{
	   	    		            				color:'#000000'
	   	    		            			}
	   	    		            		}
	   	    		            	}
	   	    		            }
	   	    		        
	   	    		        }
	   	    		    ] 
	   	    		};
	    	     myChart.setOption(option);
    	         myChart.on(echarts.config.EVENT.CLICK,function(item){
	    	    	  console.log(teanos[item.dataIndex].value,teanos[item.dataIndex].teaid);
	    	    	  teano = teanos[item.dataIndex].teaid;
	    	    	  readSinglDepTeaData(); 
    	      	 });
		 }
		 
		 function drawSinglJobChart() {
			 var count = [];  
			 var teanos = [];
			 var jobname = JobSinglLisD[0].job_name;
			 for(var y=JobSinglLisD.length-1; y>=0; y--) {
				  teanos.push({
					  value:JobSinglLisD[y].teacher_name,
					  teaid:JobSinglLisD[y].teacher_no
				  });
				  count.push(JobSinglLisD[y].grtkcs);
			  }
			  $("#ChartPanel").remove(); 
			  if(JobSinglLisD.length >30) { 
				  var tep =     
				  		'<div class="ui segment" id="ChartPanel" style="height:'+eval(JobSinglLisD.length) * eval(30)+'px !important;">'+ 
						    
						'</div>';  
				   $("#DepViewPanel").append($(tep));  
			  } else { 
				  var tep =
				  		'<div class="ui segment" id="ChartPanel">'+ 
						   
						'</div>'; 
				   $("#DepViewPanel").append($(tep));  
			  }
			  var myChart = echarts.init(document.getElementById('ChartPanel'));
	    		 myChart.setTheme("macarons");     // 设置echart的主题(改变颜色)
	    	     var option = {
	   	    		    title : {
	   	    		        text: '此岗位教师听课统计  (岗位：'+jobname+' )'
	   	    		    },
	   	    		    tooltip : {
	   	    		        trigger: 'axis'
	   	    		    },
	   	    		    legend: {
	   	    		        data:['本教师听课次数']
	   	    		    },
	   	    		    toolbox: {
	   	    		        show : true,
	   	    		        feature : {
	   	    		            mark : {show: true},
	   	    		            dataView : {show: true, readOnly: false},
	   	    		            magicType: {show: true, type: ['line', 'bar']},
	   	    		            restore : {show: true},
	   	    		            saveAsImage : {show: true}
	   	    		        }
	   	    		    },
	   	    		    calculable : true,
	   	    		    xAxis : [
	   	    		        {
	   	    		            type : 'value',
	   	    		            boundaryGap : [0, 0.01]
	   	    		        }
	   	    		    ],
	   	    		    yAxis : [
	   	    		        {
	   	    		            type : 'category',
	   	    		            data : teanos
	   	    		        }
	   	    		    ],
	   	    		    series : [
	   	    		        {
	   	    		            name:'本教师听课次数',
	   	    		            type:'bar',
	   	    		            data:count, 
	   	    		            itemStyle:{
	   	    		            	normal:{
	   	    		            		label:{
	   	    		            			show:true,
	   	    		            			textStyle:{
	   	    		            				color:'#000000'
	   	    		            			}
	   	    		            		}
	   	    		            	}
	   	    		            }
	   	    		        
	   	    		        }
	   	    		    ] 
	   	    		};
	    	     myChart.setOption(option);
	 	         myChart.on(echarts.config.EVENT.CLICK,function(item){
		    		console.log(teanos[item.dataIndex].value,teanos[item.dataIndex].teaid);
		    		teano = teanos[item.dataIndex].teaid;
		    	   	readSinglDepTeaData();  
	 	      	 });
		 }
		 
		 
		 function readSinglDepTeaData() {
			 $.ajax({
				 url: "do?invoke=teacherLisTotal@getSinglDepTeaInfor",
				 type: 'POST',
				 async: false,
				 dataType: 'json',
				 data:{
					 term_no:termid, 
					 tea_no:teano
				 },  
				 success: function(rep) {
					 if(rep.result == 0) {
						 $.alert("获取该教师的听课详情失败！"); 
						 return;
					 } else {
						 console.log(rep); 
						 SinglDepTeaD = rep.data;
						 //画弹出框中的教师听课详细信息 
						 drawSinglDepTeaMod();
					 }
				 }
			 });
		 }
		 
		 function drawSinglDepTeaMod() {
			 $('#modsup').modal({
 				transition:'slide down',
 				observeChanges:true,
 				closable:false
 			 }).modal('show');	
			 $("#tablemodelgr .ui.card").remove();
				for(var k=0;k<SinglDepTeaD.length;k++) {
					var dom3=												
						'<div class="ui card">'+  
						  '<div class="content">'+
						    '<div class="header">'+ SinglDepTeaD[k].teaname +'</div>'+
						    '<div class="meta">'+ SinglDepTeaD[k].listen_time +'</div>'+
						    '<div class="description">'+
						      '<p>《'+ SinglDepTeaD[k].course_name +'》</p>'+
						      '<p>教学建议：'+ SinglDepTeaD[k].jxjy +'</p>'+
						      '<p>上课评价：'+ SinglDepTeaD[k].skpj +'</p>'+
						    '</div>'+
						  '</div>'+
						  '<div class="extra content">评分：'+ SinglDepTeaD[k].total +'</div>'+
						'</div>';
					$("#tablemodelgr").append($(dom3));
				}
			
		 }
		
		 
		 

		 

		 downAllTerm();
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
					
							$("#depdiv .blue").removeClass("blue");
							$("#depdata").addClass("blue");   
							cho_lab = "depdata";
							console.log("---------------"+cho_lab);    
							$("#DepViewPanel").empty();   
							$("#TableChartMenu").hide(); 
							$("#JOBTableChartMenu").hide();    
							if(cho_lab == "depdata") {
								
								$('i.dep.inverted.circular.active.icon').removeClass('active');
								$('i.dep.circular.inverted.table.icon.TableIcon').addClass('active');   
								cho_but = "TableBut"; 
								//取所有听课数据( 按部门，学期)
								 readTeaLisData();
								
								drawDepTable(); 
							} else {
								if(purview=="ALL"){ 
									
									$('i.job.inverted.circular.selected.icon').removeClass('selected');
									$('i.job.circular.inverted.table.icon.jobTableIcon').addClass('selected');   
									jobcho_but = "JobTableBut";    
									//取所有听课数据( 按岗位，学期)  
								     readJobLisData();
									drawJobTeaLisData();  
								} else {
									$.alert("很抱歉，您暂无权限查看该页面！");
								}
							}
					
					});
				}  
	    	});       
	    }
	     
	 });
</script>
<!--这里引用其他JS-->
</html>