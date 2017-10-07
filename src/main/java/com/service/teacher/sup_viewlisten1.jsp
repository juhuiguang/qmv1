<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>

<!--这里引用其他样式-->
<title></title>
<style>
	.ui.header {
		margin-top:30px;
	}
	.item.active {
		margin-top:20px;
		font-size:16px;
	}
	#main{
		margin-top:60px;
	}

</style>
</head>
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<div id="container">
		<h2  class="ui header "> 
	  			<i class="unordered list icon"></i>
	  			<div class="content">查看督学听课</div>
		</h2>
		<div class="ui secondary menu">
			<a class="item active" id="all">全部</a>
			<a class="item active" id="2241">能源与电气工程学院</a>
			<a class="item active" id="2242">计算机与软件学院</a>
			<a class="item active" id="2243">经济管理学院</a>
			<a class="item active" id="2244">艺术设计学院</a>
			<a class="item active" id="2245">人文与数理系</a>
			</div>
		<div class="ui secondary menu">
		    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a class="item active" id="2246">社会科学部</a>
			<a class="item active" id="2247">体育部</a>
			<a class="item active" id="2249">国际教育学院</a>
			<a class="item active" id="2250">外语系</a>	
			<a class="item active" id="2251">文理学院</a>
		</div>
	
	<div id="main" style="height:400px"></div>
    <script src="http://echarts.baidu.com/build/dist/echarts-all.js"></script>
    <script type="text/javascript">
    $(function(){
    	var myChart = echarts.init(document.getElementById('main'));
		function loadtable() {
		var arr=new Array();
		var brr = new Array();  
    	$(".item.active").click(function(){
        	var a=$(this).attr("id");
        	console.log(a);
        	/* depno:a */
        	if(a=="all") {
    			$.ajax({
    				url:"do?invoke=supervisorViewListen@getSupViewListen",
    				type:'POST',
    				dataType:'json',
    				data:{
    					supno:<%= USEROBJECT.getString("loginname")%>,
    					depno:a
    				},
    				success:function(rep) {
    					console.log(rep);
    					if(rep.result == 0) {
    						$.alert("",rep.message);
    					} else {
    						var table = rep.data;	
    						for(var i = table.length-1; i >= 0; i--) {
    							console.log(table[i].teacher_name);
            	            	arr.push(table[i].teacher_name);
    							brr.push(table[i].listentotal);
            	            }
    						myChart.setOption({
    							title : {
    			         	        text: '督学听课情况概览 '
    			         	    },
    			         	    tooltip : {
    			         	        trigger: 'axis',
    			         	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
    			     		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
    			     		        }
    			         	    },
    			         	    legend: {
    			         	        data:['听课次数 ']
    			         	    },
    			         	    /* calculable : true,  */
    			         	    xAxis : [
    			         	        {
    			         	            type : 'value',
    			         	            boundaryGap : [0, 0.01] 
    			         	        }
    			         	    ],
    			         	    yAxis : [
    			         	        {
    			         	            type : 'category',
    			         	            data : arr
    			         	        }
    			         	    ],
    			         	    series : [
    			         	        {
    			         	            name:'听课次数 ',
    			         	            type:'bar',
    			         	            itemStyle: {
    			 							normal: {
    			 								color: '#87CEFA',
    			 							}
    			 						},	
    			         	            data:brr
    			         	        }
    			         	    ]
    			         	    
    						});

    					}
    				}
    			});
        	} else if(a != "all"){
        		$.ajax({
    				url:"do?invoke=supervisorViewListen@getSupViewListenYX",
    				type:'POST',
    				dataType:'json',
    				data:{
    					supno:<%= USEROBJECT.getString("loginname")%>,
    					depno:a
    				},
    				success:function(rep) {
    					console.log(rep);
    					if(rep.result == 0) {
    						$.alert("",rep.message);
    					} else {
    						var table = rep.data;	
    						for(var i = table.length-1; i >= 0; i--) {
    							console.log(table[i].teacher_name);
            	            	arr.push(table[i].teacher_name);
    							brr.push(table[i].listentotal);
            	            }
    						myChart.setOption({
    							title : {
    			         	        text: '督学听课情况概览 '
    			         	    },
    			         	    tooltip : {
    			         	        trigger: 'axis',
    			         	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
    			     		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
    			     		        }
    			         	    },
    			         	    legend: {
    			         	        data:['听课次数 ']
    			         	    },
    			         	    /* calculable : true,  */
    			         	    xAxis : [
    			         	        {
    			         	            type : 'value',
    			         	            boundaryGap : [0, 0.01] 
    			         	        }
    			         	    ],
    			         	    yAxis : [
    			         	        {
    			         	            type : 'category',
    			         	            data : arr
    			         	        }
    			         	    ],
    			         	    series : [
    			         	        {
    			         	            name:'听课次数 ',
    			         	            type:'bar',
    			         	            itemStyle: {
    			 							normal: {
    			 								color: '#87CEFA',
    			 							}
    			 						},	
    			         	            data:brr
    			         	        }
    			         	    ]
    			         	    
    						});

    					}
    				}
    			});
        	}
        	
        });
			

		}
		loadtable();
	});

	
        </script>           
		
		
	</div>
	<!--这里绘制页面-->
</body>
<!--这里引用其他JS-->
</html>