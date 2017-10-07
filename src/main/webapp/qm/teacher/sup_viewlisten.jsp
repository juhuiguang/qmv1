<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>

<!--这里引用其他样式-->
<title></title>
<style>
	#depdiv .label{
		margin-bottom:10px;
	}
	#chart{
		width:100%;
		height:450px;
	}
	#chart2{
		width:100%;
		height:480px;
	}

</style>
<script src="script/common/echarts/echarts.min.js"></script>
</head>
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<div id="container">
			<h3  class="ui header "> 
		  			<i class="unordered list icon"></i>
		  			<div class="content">查看督学听课</div>
			</h3>
		
		<div id="depdiv">
			<a class="ui blue label" id="all">全&nbsp;&nbsp;&nbsp;&nbsp;部</a>
			<a class="dep ui gray label" id="2241">能源与电气工程学院</a>
		</div>
		
		<select class="ui mini dropdown" id="dropdown">
		</select>

		<div class="ui segment" id="chart2">

		</div>

		<div class="ui segment" id="chart">
			
		</div>

		
			<div id="moddep" class="ui modal">
			  <div class="header">
			    督学听课概览:   
			  	<i class="close icon" style="float: right;"></i>                
			  </div>
			  <div class="content">
			  	<div class="description">
			  		<table class="ui very basic table" id="tablemodel">
					  <thead>
					    <tr>
					      <th>督学工号</th>
					      <th>督学姓名</th>
					      <th>听课次数</th>
					      <th>详情</th>
					    </tr>
					  </thead>
					  <tbody>
					  </tbody>
					</table>				  
			    </div>
			  </div>
		</div>
		
			<div id="modsup" class="ui modal gr">      
			  <div class="header">
			    督学听课详情:     
			    <i class="close icon" style="float: right;"></i>
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
			var dqdepno="";
	    	$("#depdiv").hide();
	    	var purview=USEROBJECT.userpurview;
			if(purview=="ALL"){
				initDep();
				dqdepno="all";
				loadDepData(dqdepno);
				SchMasterData("Sch");
			}else{
				dqdepno=USEROBJECT.userinfo.dep_no;
    			$("#chart2").remove();
				loadDepData(dqdepno);
			}
	    	
	    	//初始化部门
	    	function initDep(){
	    		//1、从公共变量获得部门数据
	    		var deps=SYSOBJECT.departments;
	    		
	    		//2、绘制到页面中
	    		$("#depdiv .dep").remove();
	    		for(var i=0;i<deps.length;i++){
					if (deps[i].dep_type!="行政"){
	    			var depdiv=$('<a class="dep ui gray label"" id="'+deps[i].dep_no+'">'+deps[i].dep_name+'</a>');
	    			$("#depdiv").append(depdiv);
					}
	    		}
	    		$("#depdiv").fadeIn();
	    		//3.绑定点击事件
	    		$("#depdiv .label").click(function(){
	    			$("#depdiv .blue").removeClass("blue");
	    			$(this).addClass("blue");
	    			var dep_no=this.id;
	    			dqdepno=dep_no;
	    			loadDepData(dqdepno);
	    		});
	    	}
	    	
	    	//获取部门对应数据
	    	function loadDepData(depno){
	    		console.log("正在获取部门："+depno+" 的院系督学听课数据");
	    		$.ajax({
					url:"do?invoke=supervisorViewListen@getSupViewListen",
					type:'POST',
					dataType:'json',
					data:{
						supno:USEROBJECT.loginname,
						depno:depno,
						termno:termid
					},
					success:function(rep) {
						console.log("获取到数据：",rep);
						if(rep.result==0){
							//$.alert("没有加载到本学期院系督学的听课数据，您可以换一个学期试试！");
							return;
						}
						renderChart(depno,rep.data);
						
					}
	    		});
	    	}
	    	
	    	function SchMasterData(dep) {
	    		$.ajax({
					url:"do?invoke=supervisorViewListen@getMasterViewListen",
					type:'POST',
					dataType:'json',
					data:{
						dep:dep,
						termno:termid
					},
					success:function(rep) {
						console.log("获取到数据：",rep);
						if(rep.result==0){
							//$.alert("没有加载到本学期校级督学听课数据，您可以换一个学期试试！ ");
							return;
						}
						renderChartTwo(dep,rep.data);
					}
	    		});
	    	}
	    	
	    	//绘制echarts图形
	    	function renderChart(datatype,data){
	    		var yAxisdata=[];
	    		var values=[];
	    		var depnos=[];
	    		for(var i=data.length-1;i>=0;i--){
	    			yAxisdata.push(data[i].gname);
	    			values.push(data[i].listentotal);
	    			depnos.push(data[i].gid);
	    		}
	    		console.log(yAxisdata,values);
	    		 var myChart = echarts.init(document.getElementById('chart'));
	    		 //myChart.setTheme("macarons");     // 设置echart的主题(改变颜色)
	    	     var option = {
	   	    		    title : {
	   	    		        text: '院系督学工作量统计'
	   	    		    },
	   	    		    tooltip : {
	   	    		        trigger: 'axis'
	   	    		    },  
	   	    		    legend: {
	   	    		        data:['院系督学听课次数']
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
	   	    		            data : yAxisdata
	   	    		        }
	   	    		    ],

	   	    		    series : [
	   	    		        {
	   	    		            name:'院系督学听课次数',
	   	    		            type:'bar',
	   	    		            data:values,
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
	    	   //console.log(echarts.config.EVENT.CLICK);
	    	      myChart.on("click",function(item){
	    	    	  console.log(item);	    	  
	    	    	  getdetailData(datatype,item.name);
	    	    	  console.log(datatype);
	    	      });
	    	}
	    	
	    	
	    	
	    	
	    	
	    	
	    	
	    	
	    	//绘制第2个 echarts图形
	    	function renderChartTwo(dep,data){
	    		var yName=[];
	    		var totals=[];
	    		for(var i=data.length-1;i>=0;i--){
	    			yName.push({
	    				value:data[i].gname,
	    				teano:data[i].gid
	    			});
	    			totals.push(data[i].listentotal);
	    		}
	    		
	    		 var myChart2 = echarts.init(document.getElementById('chart2'));
	    		// myChart2.setTheme("macarons");     // 设置echart的主题(改变颜色)
	    	     var option2 = {
	   	    		    title : {
	   	    		        text: '校级督学工作量统计'
	   	    		    },
	   	    		    tooltip : {
	   	    		        trigger: 'axis'
	   	    		    },
	   	    		    legend: {
	   	    		        data:['校级督学听课次数']
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
	   	    		            //boundaryGap : [0, 0.01]
	   	    		        }
	   	    		    ],
	   	    		    yAxis : [
	   	    		        {
	   	    		            type : 'category',
	   	    		            data : yName,
                                axisLabel:{
                                    interval: 0
                                }
                            }
	   	    		    ],
                     dataZoom: [
                         {
                             id: 'dataZoomY',
                             type: 'slider',
							 start:100,
							 end:70,
                             yAxisIndex: [0],
                             filterMode: 'empty'
                         }
                     ],
	   	    		    series : [
	   	    		        {
	   	    		            name:'校级督学听课次数',
	   	    		            type:'bar',
	   	    		            data:totals,
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
	    	      myChart2.setOption(option2);
	    	   //console.log(echarts.config.EVENT.CLICK);
	    	      myChart2.on("click",function(item){
	    	    	  console.log(item);	    	  
	    	    	  getdetailData(dep,yName[item.dataIndex].teano);
	    	      });
	    	}
	    	
	    	
	    	
	    	
	    	
	    	
	    	
	    	
	    	
	    	
	    	
	    	
	    	
	    	
	    	
	    	function getdetailData(detailtype,name){
	    		console.log(detailtype);
	    		console.log(name);
	    		
	    		if(detailtype=="all"){
	    			$('#moddep')
	    			.modal({
	    				transition:'slide down',
	    				observeChanges:true,
	    				closable:false
	    			})	    
	    			.modal('show');
	    			$.ajax({
	    				url:"do?invoke=supervisorViewListen@getDepSupViewListenXQ",
	    				type:'POST',
	    				dataType:'json',
	    				data:{
	    					depname:name,
	    					termno:termid
	    				},
	    				success:function(rep) {
							console.log("获取到数据：",rep);
							if(rep.result==0){
								$.alert("没有加载到督学听课数据");
								return;
							} else {
								var cont = rep.data;	
								$("#tablemodel .datarow").remove();
								for(var j=0;j<cont.length;j++) {
									var dom2=
											  '<tr class="datarow">'+
											  	  '<td>'+cont[j].teacher_no + '</td>'+
											      '<td>'+cont[j].teacher_name +'</td>'+										      
											      '<td>'+cont[j].suptotal +'</td>'+
											      '<td>'+
													'<div class="btnfirst circular ui blue basic icon button" id="'+cont[j].teacher_no+'" data-content="点击我，可以查看该督学的听课详情！">'+
								                     	'<i class="file text icon"></i>'+
									                 '</div>'+ 	                
								                 '</td>'+
										   	  '</tr>';
									$("#tablemodel").append($(dom2));
									$('.btnfirst').popup();
								}		
								$('.btnfirst').click(function(){						
									$('#modsup')
									.modal({
					    				transition:'slide down',
					    				observeChanges:true,
					    				closable:false
					    			})	    
									.modal('show');							
									var supno=$(this).attr("id");
									$.ajax({
										url:"do?invoke=supervisorViewListen@getDepSupViewListenGR",
										type:'POST',
					    				dataType:'json',
					    				data:{
					    					supno:supno,
					    					termno:termid
					    				},
					    				success:function(rep) {
											console.log("获取到数据：",rep);
											if(rep.result==0){
												$.alert("没有加载到督学听课数据");
												return;
											} else {
												var contgr = rep.data;	
												$("#tablemodelgr .ui.card").remove();
												for(var k=0;k<contgr.length;k++) {
													var dom3=												
														'<div class="ui card">'+
														  '<div class="content">'+
														    '<div class="header">'+ contgr[k].teaname +'</div>'+
														    '<div class="meta">'+ contgr[k].listen_time +'</div>'+
														    '<div class="description">'+
														      '<p>《'+ contgr[k].course_name +'》</p>'+
														      '<p>教学建议：'+ contgr[k].jxjy +'</p>'+
														      '<p>上课评价：'+ contgr[k].skpj +'</p>'+
														    '</div>'+
														  '</div>'+
														  '<div class="extra content">评分：'+ contgr[k].total +'</div>'+
														'</div>';
													$("#tablemodelgr").append($(dom3));
												}		
											}
					    				}
									});
								});
							}
	    				}
	    			});
	    		} /* else if(detailtype=="Sch") {
	    			
	    		}  */else{
	    			$('#modsup')
	    			.modal({
	    				transition:'slide down',
	    				observeChanges:true,
	    				closable:false
	    			})	    			
	    			.modal('show');
	    			$.ajax({
	    				url:"do?invoke=supervisorViewListen@getSupViewListenGR",
	    				type:'POST',
	    				dataType:'json',
	    				data:{
	    					depno:detailtype,
	    					teaname:name,
	    					termno:termid
	    				},
	    				success:function(rep) {
							console.log("获取到数据：",rep);
							if(rep.result==0){
								$.alert("没有加载到督学听课数据");
								return;
							} else {
								var contgr = rep.data;	
								$("#tablemodelgr .ui.card").remove();
								for(var k=0;k<contgr.length;k++) {
									var dom4=
										'<div class="ui card">'+
										  '<div class="content">'+
										    '<div class="header">'+ contgr[k].teacher_name +'</div>'+
										    '<div class="meta">'+ contgr[k].listen_time +'</div>'+
										    '<div class="description">'+
										      '<p>《'+ contgr[k].course_name +'》</p>'+
										      '<p>教学建议：'+ contgr[k].jxjy +'</p>'+
										      '<p>上课评价：'+ contgr[k].skpj +'</p>'+
										    '</div>'+
										  '</div>'+
										  '<div class="extra content">评分：'+ contgr[k].total +'</div>'+
										'</div>';
									$("#tablemodelgr").append($(dom4));
								}
							}
	    				}
	    			});
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
							console.log(termid);
							loadDepData(dqdepno);
							SchMasterData("Sch");
						});
					}
		    	});
		    }
		
    });
</script>           
		
<!--这里引用其他JS-->
</html>