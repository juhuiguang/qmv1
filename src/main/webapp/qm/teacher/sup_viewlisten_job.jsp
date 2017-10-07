<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>

<!--这里引用其他样式-->
<title></title>
<style>
	#jobtype .label{
		margin-bottom:10px;
	}
	#chart{
		width:100%;
		height:450px;
	}
	#chartdiv{
		width:100%;
		height:450px;
	}
	#depdiv .label{
		margin-bottom:10px;
	}

</style>
<script src="script/common/echarts/echarts-all.js"></script>
</head>
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<div id="container">
			<h3  class="ui header "> 
		  			<i class="unordered list icon"></i>
		  			<div class="content">分岗位查看督学听课</div>
			</h3>

		<select class="ui mini dropdown" id="dropdown">
		</select>
		
		<div id="jobtype">
			<a class="ui blue label" id="xz">行政岗位</a>
			<a class="dep ui gray label" id="jx">教学岗位</a>
		</div>

		<div id="xzinformation">

		</div>
		
		<div id="jxinformation">
			<div id="depdiv">
			
			</div>
			<div class="ui segment" id="chartdiv">
			
			</div>
		</div>
		
		<div id="modJob" class="ui modal gr">
			  <i class="close icon"></i>
			  <div class="header">
			    督学听课详情:
			  </div>
			  <div class="content">
			  	<div class="description">
			  		<div class="ui two cards" id="tablemodelgr">
			  		
			  		</div>			  
			    </div>
			  </div>
		</div>
		

		
	</div>
	<!--这里绘制页面-->
</body>

<script type="text/javascript">
	$(function(){
		var termid=SYSOBJCET.term_no;
		var purview=USEROBJECT.userpurview;
		var dqdepno="";
		var jobtype="";
		$("#jobtype").hide();
		if(purview == "ALL") {
			dqdepno = "all";
			initload();
		} else {
			dqdepno=USEROBJECT.userinfo.dep_no;
			jobtype = "jx";
			JXDepData(dqdepno,jobtype);
		}		
		function initload() {
			$("#jobtype").show();
			$("#jobtype .label").click(function(){
				$("#jobtype .blue").removeClass("blue");
				$(this).addClass("blue");
				var job_type=this.id;
				console.log(job_type);
				if(job_type == "xz"){
					jobtype = "xz";
					$("#depdiv").empty();
					$("#chart").empty();
					loadXZData(jobtype);
				} else {
					jobtype = "jx";
					$("#xzinformation").empty();
					loadJXData(jobtype);
				}
			});	
		}
		
		function loadJXData(jobtype){
			var deps=SYSOBJECT.departments;
			$("#depdiv").empty();
			var dep = 
				 '<a class="ui gray label" id="all" style="margin_left:20px;">全&nbsp;&nbsp;&nbsp;&nbsp;部</a>';
			$("#depdiv").append(dep);
    		for(var i=0;i<deps.length;i++){
    			var dom = '<a class="dep ui gray label"" id="'+deps[i].dep_no+'">'+deps[i].dep_name+'</a>';
    			$("#depdiv").append(dom);
    		}
    		$("#depdiv").fadeIn();
    		$("#depdiv .label").click(function(){
    			$("#depdiv .blue").removeClass("blue");
    			$(this).addClass("blue");
    			dqdepno = this.id;
    			JXDepData(dqdepno,jobtype);
    		});
		}
		
		function JXDepData(depno,jobtype) {
			$.ajax({
				url:"do?invoke=supervisorViewListenJob@getDepData",
				type:'POST',
				dataType:'json',
				data:{
					depno:depno,
					termno:termid,
					type:jobtype
				},
				success:function(rep) {
					console.log(rep);
					if(depno == "all") {
						if(rep.result==0) {
							$.alert("没有加载到部门相关的信息");
							return;
						} else {
							JXDepChart(depno,rep.data,jobtype);							
						}
					} else {
						JXDepDataJob(depno,jobtype);
					}

				}
			});
		}
		
		function JXDepChart(depno,data,jobtype) {
			var depnos=[];
			var count=[];
			for (var y=data.length-1; y>=0; y--) {
				depnos.push({
					value:data[y].gname,
					depid:data[y].gid
				});
				count.push(data[y].listentotal);
			}
		    $("#chart").remove();
			var tmp=
					'<div id="chart">'+
					
					'</div>';
			 $("#chartdiv").append(tmp);
			 var myChart = echarts.init(document.getElementById('chart'));
    		 myChart.setTheme("macarons");     // 设置echart的主题(改变颜色)
    	     var option = {
   	    		    title : {
   	    		        text: '督学工作量统计'
   	    		    },
   	    		    tooltip : {
   	    		        trigger: 'axis'
   	    		    },
   	    		    legend: {
   	    		        data:['督学听课次数']
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
   	    		            name:'督学听课次数',
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
    	    	  JXDepDataJob(depnos[item.dataIndex].depid,jobtype);
    	      });
			 
		}
		
		function JXDepDataJob(depno,jobtype){
			$.ajax({
				url:"do?invoke=supervisorViewListenJob@getDepData",
				type:'POST',
				dataType:'json',
				data:{
					depno:depno,
					termno:termid,
					type:jobtype
				},
				success:function(rep) {
					console.log(rep);
					if(rep.result==0) {
						$.alert("没有加载到相关的数据");
						return;
					} else {
						JXChart(depno,rep.data,jobtype);						
					}
				}
			});
		}
		
		function JXChart(depno,data,jobtype) {
			var jxjob=[];
			var totals =[];
			for(var u=data.length-1; u>=0; u--) {
				jxjob.push(data[u].job_name);
				totals.push(data[u].total);
			}
			console.log(jxjob,totals);
			$("#chart").remove();
			var tmp=
					'<div id="chart">'+
					
					'</div>';
			 $("#chartdiv").append(tmp);
			 ChartData(jxjob,totals,jobtype,depno);				 
		}
		
		

		function loadXZData(jobtype){
			$.ajax({
				url:"do?invoke=supervisorViewListenJob@getTypeJobXZ",
				type:'POST',
				dataType:'json',
				data:{
					type:jobtype,
					termno:termid
				},
				success:function(rep) {
					console.log(rep);
					if(rep.result == 0) {
						$.alert("没有加载到行政岗位的信息！");
						return;
					}
					XZChart(rep.data,jobtype);
				}
			});
		}
		
		function XZChart(data,jobtype) {
			var xzjob=[];
			var values=[];
			for(var i=data.length-1; i>=0; i--) {
				xzjob.push(data[i].job_name);
				values.push(data[i].total);
			}
			console.log(xzjob,values);
			$("#xzinformation").empty();
			var tmp=
				'<div class="ui segment" id="chart">'+
					'<div id="chart">'+
					
					'</div>'+
			    '</div>';
			 $("#xzinformation").append(tmp);
			 ChartData(xzjob,values,jobtype);
		}
		
		function ChartData(xzjob,values,jobtype,depid) {
			var myChart = echarts.init(document.getElementById('chart'));
		    myChart.setTheme("macarons"); 
   	     	var option = {
	    		    title : {
	    		        text: '督学听课情况图',
	    		    },
	    		    tooltip : {
	    		        trigger: 'axis'
	    		    },
	    		    legend: {
	    		        data:[
	    		            '督学听课情况'
	    		        ]
	    		    },
	    		    toolbox: {
	    		        show : true,
	    		        feature : {
	    		            mark : {show: true},
	    		            dataView : {show: true, readOnly: false},
	    		            magicType : {show: true, type: ['line', 'bar']},
	    		            restore : {show: true},
	    		            saveAsImage : {show: true}
	    		        }
	    		    },
	    		    calculable : true,
	    		    grid: {y: 70, y2:30, x2:20},
	    		    xAxis : [
	    		        {
	    		            type : 'category',
	    		            data : xzjob
	    		        },
	    		        {
	    		            type : 'category',
	    		            axisLine: {show:false},
	    		            axisTick: {show:false},
	    		            axisLabel: {show:false},
	    		            splitArea: {show:false},
	    		            splitLine: {show:false},
	    		            data : xzjob
	    		        }
	    		    ],
	    		    yAxis : [
	    		        {
	    		            type : 'value',
	    		            axisLabel:{formatter:'{value}'}
	    		        }
	    		    ],
	    		    series : [ 	    		       
	    		        {
	    		            name:'督学听课情况',
	    		            type:'bar',
	    		            xAxisIndex:1,
	    		            itemStyle: {normal: {color:'rgba(181,195,52,0.5)', label:{show:true}}},       	    		            
	    		            data:values
	    		        }
	    		       
	    		    ]
	    		};  
		     myChart.setOption(option); 
		     myChart.on(echarts.config.EVENT.CLICK,function(item){
  	    	  	console.log(item);	
  	    	  	if(jobtype =="xz") {
	  	    	  	DataXZName(item.name); 	    	  		
  	    	  	} else {
  	    	  		DataJXName(item.name,depid,xzjob,values,jobtype); 	
  	    	  	}
		     });
		}
		
		function DataJXName(jxjobname,depid,xzjob,values,jobtype) {
			$.ajax({
				url:"do?invoke=supervisorViewListenJob@getDetailDataJX",
				type:'POST',
				dataType:'json',
				data:{
					termno:termid,
					jobname:jxjobname,
					depno:depid
				},
				success:function(rep) {
					console.log(rep);
					if(rep.result==0) {
						$.alert("没有加载到相关数据~");
						return;
					}
					JXjobChart(rep.data,depid,xzjob,values,jobtype);
				}
			});
		}
		
		
		function DataXZName(xzjobname){
			$.ajax({
				url:"do?invoke=supervisorViewListenJob@getDetailDataXZ",
				type:'POST',
				dataType:'json',
				data:{
					termno:termid,
					jobname:xzjobname
				},
				success:function(rep) {
					console.log(rep);
					if(rep.result==0) {
						$.alert("没有加载到相关数据~");
						return;
					} 
					XZjobChart(rep.data);
				}
			});
		}
		
		function JXjobChart(jobdata,depid,xzjob,values,jobtype) {
			var listencount=[];
			var teaname=[];
			for(var j=jobdata.length-1; j>=0; j--) {
				listencount.push(jobdata[j].listentotal);
				teaname.push({
					value:jobdata[j].teacher_name,
					teaid:jobdata[j].teacher_no
				});
			}
			$("#chart").remove(); 
			$("#back").remove();
			var tmp=
					'<i class="angle large double left icon" id="back" style="color:blue;" data-content="点击可返回~"></i>'+
					'<div id="chart">'+
					
					'</div>';
			 $("#chartdiv").append(tmp);
			 ChartGRData(teaname,listencount);
			 $('.angle').popup();
			 $("#back").click(function(){
				 ChartData(xzjob,values,jobtype,depid);
				 $("#back").remove();
			 });
		}
		
		function XZjobChart(jobdata){
			var listencount=[];
			var teaname=[];
			for(var j=jobdata.length-1; j>=0; j--) {
				listencount.push(jobdata[j].listentotal);
				teaname.push({
					value:jobdata[j].teacher_name,
					teaid:jobdata[j].teacher_no
				});
			}
			$("#xzinformation").empty();
			var tmp=
				'<div class="ui segment" id="chart">'+
					'<div id="chart">'+
					
					'</div>'+
			    '</div>';
			 $("#xzinformation").append(tmp); 
			 ChartGRData(teaname,listencount);
		}
		
		function ChartGRData(teaname,listencount) {			
			var myChart = echarts.init(document.getElementById('chart'));
		     myChart.setTheme("macarons"); 
		     var option = {
	   	    		    title : {
	   	    		        text: '督学工作量统计'
	   	    		    },
	   	    		    tooltip : {
	   	    		        trigger: 'axis'
	   	    		    },
	   	    		    legend: {
	   	    		        data:['督学听课次数']
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
	   	    		            data : teaname,
	   	    		        }
	   	    		    ],
	   	    		    series : [
	   	    		        {
	   	    		            name:'督学听课次数',
	   	    		            type:'bar',
	   	    		            data:listencount,
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
	   	        	console.log(teaname[item.dataIndex].teaid);	
	   	    	  	XZjobGR(teaname[item.dataIndex].teaid);
		     });
		}
		
		function XZjobGR(teano){
			$('#modJob').modal({
				transition:'slide down',
				observeChanges:true,
				closable:false
			}).modal('show');
			$.ajax({
				url:"do?invoke=supervisorViewListenJob@GetJobXZGr",
				type:'POST',
				dataType:'json',
				data:{
					teano:teano,
					termno:termid
				},
				success:function(rep){
					console.log(rep);
					if(rep.result==0){
						$.alert("没有加载到相关数据~");
						return;
					} else {
						var jobgr = rep.data;
						$("#tablemodelgr .ui.card").remove();
						for(var k=0; k<jobgr.length; k++) {
							var dom=
								'<div class="ui card">'+
								  '<div class="content">'+
								    '<div class="header">'+ jobgr[k].teacher_name +'</div>'+
								    '<div class="meta">'+ jobgr[k].listen_time +'</div>'+
								    '<div class="description">'+
								      '<p>《'+ jobgr[k].course_name +'》</p>'+
								      '<p>教学建议：'+ jobgr[k].jxjy +'</p>'+
								      '<p>上课评价：'+ jobgr[k].skpj +'</p>'+
								    '</div>'+
								  '</div>'+
								  '<div class="extra content">评分：'+ jobgr[k].total +'</div>'+
								'</div>';
							$("#tablemodelgr").append($(dom));
						}
					}
				}
			});
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
						JXDepData(dqdepno,jobtype);
					});
				}
	    	});
	    }
    });
</script>           
		
<!--这里引用其他JS-->
</html>