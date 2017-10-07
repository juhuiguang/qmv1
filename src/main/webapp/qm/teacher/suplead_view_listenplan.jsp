<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>
<script src="script/common/datepicker/jquery.datetimepicker.js"
	type="text/javascript"></script>
<link rel="stylesheet"
	href="script/common/datepicker/jquery.datetimepicker.css" />
<title>校内教学质量监控运行平台</title>
<style>
	#chart{
		width:100%;
		height:450px;
		margin-top: 10px;
	}
	.supname.label {
		background-color:#60C0DD;
		color:white;
		margin-top: 10px;
	}
	#viewlistenplan {
		margin-top: 10px;
	}
	#messageinf {
		margin-left: 20px;
	}

</style>
<script src="script/common/echarts/echarts-all.js"></script>   
</head>   
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<div id="container">
			<h3 class="ui header" id='grbtkjl'>
				<i class="tasks icon"></i>
				<div class="content">督学组长查看听课计划</div>
			</h3>
		
		<div id="depdiv">
			<a class="ui blue label" id="viewplan">列表概述</a>
			<a class="dep ui gray label" id="markplan">图表展示</a>
		</div>
		
		<div id="tableinformation">

		</div>
		
		<div id="chartinformation">
		
		</div>


	</div>
	<!--这里绘制页面-->
</body>
<script>
	$(function() {
		tableSup();
		var sourse = [];
		var count = [];
		$("#depdiv .label").unbind("click").click(function(){
			$("#depdiv .blue").removeClass("blue");
			$(this).addClass("blue");
			var chooseid = this.id;
			if(chooseid == "viewplan"){
				$("#tableinformation").empty();
				$("#chartinformation").empty();				
			    tableSup();
			} else {
				supPlanCount(); 
				$("#tableinformation").empty();
				$("#chartinformation").empty();
				console.log(sourse);
				console.log(count);    
				renderChart(sourse,count);
			}
		});
		
		function tableSup() {
			var tep = 
				'<div id="supdiv">'+
			   		'<a class="supname ui large green circular label" id="all">全  部</a>'+
				'</div>';
				$("#tableinformation").append($(tep));	
			$.ajax({
				url:"do?invoke=supervisorleadViewListenPlan@getSupDep",
				type:'POST',
				dataType:'json',
				data:{
					supno:USEROBJECT.loginname
				},
				success:function(rep) {
					if(rep.result==0) {
						$.alert("没有加载到本院系的督学！");
						return;
					} else {
						var sups = rep.data;
						for(var i=0; i<sups.length; i++) {
							var supdiv = $('<a class="supname ui large circular label" id="'+sups[i].teacher_no+'">'+sups[i].teacher_name+'</a>');
						    $("#supdiv").append(supdiv);
						    sourse[i] = sups[i].teacher_name;
						}
						
						supbj = "all";
						var weekbj = "0"; 
						showSupLisPlan(supbj,weekbj);
						$('.supname').unbind("click").click(function(){
							$("#supdiv .green").removeClass("green");
							$("#supdiv .black").removeClass("black"); 
							$(this).addClass("green");
							supbj=$(this).attr("id");
							showSupLisPlan(supbj,weekbj);
						});
						//写周数的标签
						var dom2 = '<div class="ui small circular labels" style="margin-left:180px;margin-top:10px;">第  ';
						for(var j=1; j<=18; j++) {
							dom2 +=						
								  '<a class="week ui label" id="'+j+'">'+j+'</a>';								
						}
						dom2 += '  周</div>';
						$("#supdiv").append($(dom2));
							$('.week').unbind("click").click(function(){
								$("#supdiv .black").removeClass("black");
								$(this).addClass("black");
								var weekbj=$(this).attr("id");
								showSupLisPlan(supbj,weekbj);
							});							
						
					}
				}
			});
		}
		
		function showSupLisPlan(supbj,weekbj) {
			if(USEROBJECT.userpurview=="ALL"){
				depno = USEROBJECT.userinfo.dep_no;
			} else {
				depno = USEROBJECT.userpurview;
			}
			$("#viewlistenplan").remove();
			var card = 
				'<div class="ui three cards" id="viewlistenplan">'+

				'</div>';
				$("#tableinformation").append($(card));
				$.ajax({
					url:"do?invoke=supervisorleadViewListenPlan@getAllDepPlan",
					type:'POST',
					dataType:'json',
					data:{
						supbj:supbj,
						depno:depno,
						weekbj:weekbj,
						termno:SYSOBJECT.term_no
					},
					success:function(rep) {
						console.log(rep);
						if(rep.result == 0) {
							$.alert("您制定的听课计划列表获取失败！");
						} else if(rep.data.length ==0) {
							var dom1=
								'<div class="ui green large message" id="messageinf">'+
									'<i class="announcement large inverted yellow up circular icon"></i>'+
									' 该督学还没有听课计划可以显示！'+   
								'</div>';
							$("#viewlistenplan").append($(dom1));
						} else {
							var table = rep.data;							
							for(var i=0; i<table.length; i++) {
								 var dom3 =								
									'<div class="ui card">'+
									  '<div class="content">'+
									    '<div class="header">'+ table[i].teacher_name +'</div>'+
									    '<div class="meta"></div>'+
									    '<div class="description">'+
									      '<p>课程名：《'+ table[i].course_name +'》</p>'+
									      '<p>班&nbsp;&nbsp;&nbsp;级： &nbsp;&nbsp; '+ table[i].class_name +'</p>'+
									      '<p>计划时间：'+ table[i].plan_time +'【第'+ table[i].plan_week +'周】</p>'+
									      '<br>'+
									      '<p style="margin-left:169px;">'+ table[i].set_time +'</p>'+
									    '</div>'+
									  '</div>';
									  if(table[i].day_gap < 0) {
										  dom3 += 
											  '<div class="editarea extra content" style="color:red;">'+										  
									             '该计划时间已过期！'+
										      '</div>';
									  } else {
										  dom3 +=
										  '<div class="editarea extra content" >'+										  
									           '距离该计划还有 '+ table[i].day_gap +' 天！'+
									      '</div>';
									  }
									  dom3 += '</div>';
					          $("#viewlistenplan").append($(dom3));
							}	
						}
					}
				});
		}
			
		function supPlanCount() {
			if(USEROBJECT.userpurview=="ALL"){
				depno = USEROBJECT.userinfo.dep_no;
			} else {
				depno = USEROBJECT.userpurview;
			} 
			$.ajax({
				url:"do?invoke=supervisorleadViewListenPlan@getSupPlanCount",
				type:'POST',
				async: false, 
				dataType:'json',
				data:{
					depno:depno,
					termno:SYSOBJECT.term_no
				},
				success:function(rep) {
					console.log("vvvvvvvvv");
					console.log(rep);   
					if(rep.result == 0) {
						$.alert("督学听课计划获取失败！");
					} else {
						var table = rep.data;
				        for(var i=0; i<table.length; i++) {				        	
				        	 count[i] = table[i].plantotal;
				        }
					}
				}
			});
		}
		
    	//绘制echarts图形
    	function renderChart(){
    		if(sourse.length != 0) {
    			$("#chart").remove();
        		var tpp = 
        			'<div class="ui segment" id="chart">'+
        				'<div id="chart">'+
        				
        				'</div>'+
    			    '</div>';
        		$("#chartinformation").append(tpp);
        		 var myChart = echarts.init(document.getElementById('chart'));
        		 myChart.setTheme("macarons");     // 设置echart的主题(改变颜色)
        	     var option = {
        	    		    title : {
        	    		        text: '督学制定听课计划情况表',
        	    		    },
        	    		    tooltip : {
        	    		        trigger: 'axis'
        	    		    },
        	    		    legend: {
        	    		        data:[
        	    		            '督学听课计划数'
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
        	    		            data : sourse
        	    		        },
        	    		        {
        	    		            type : 'category',
        	    		            axisLine: {show:false},
        	    		            axisTick: {show:false},
        	    		            axisLabel: {show:false},
        	    		            splitArea: {show:false},
        	    		            splitLine: {show:false},
        	    		            data : sourse
        	    		        }
        	    		    ],
        	    		    yAxis : [
        	    		        {
        	    		            type : 'value',
        	    		            axisLabel:{formatter:'{value} 个'}
        	    		        }
        	    		    ],
        	    		    series : [ 	    		       
        	    		        {
        	    		            name:'督学听课计划数',
        	    		            type:'bar',
        	    		            xAxisIndex:1,
        	    		            itemStyle: {normal: {color:'rgba(181,195,52,0.5)', label:{show:true}}},       	    		            
        	    		            data:count
        	    		        }
        	    		       
        	    		    ]
        	    		};  		                    
        	      myChart.setOption(option);
        	   
    		} else {
    			var dom =
    				'<div class="ui green large message" id="messageinf">'+
						'<i class="announcement large inverted yellow up circular icon"></i>'+
						' 没有该学院的督学听课计划数据！'+   
					'</div>';
					$('#chartinformation').append(dom);
    		}
    	}

	});

</script>
<!--这里引用其他JS-->
</html>