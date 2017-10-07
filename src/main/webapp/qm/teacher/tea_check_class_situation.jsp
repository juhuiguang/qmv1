<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>

<!--这里引用其他样式-->
<title>校内教学质量监控运行平台</title>
<style>
	#depdiv .label{
		margin-bottom:10px;
	}
	#chart{
		width:100%;
		height:450px;
	}
	.bq{
		text-size:20px;
	}
	#changebutton{
	float:right
	}
</style>
<script src="script/common/echarts/echarts.min.js"></script>
</head>
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<div id="container">
		<h3  class="ui header ">
	  			<i class="unordered list icon"></i>
	  			<div class="content">查看教师上课质量</div>
		</h3>
		<select class="ui dropdown" id="selectbutton">
		</select>
   		  <button class="ui small blue button" id='changebutton' changeval="1"><i class=" exchange icon"></i>切换至学生评教</button>
		<div class="ui segment" id="chart">
		</div>
	</div>
	  <div class="mymodel ui long modal">
  <i class="close icon"></i>
  <div class="ui header">
  听课详情
  </div>
  <div class="content">
		<table class="ui mini blue table">
		  <thead>
		    <tr>
		      <th>听课教师</th>
		      <th>评教课程</th>
		      <th>任课教师</th>
		      <th>总分</th>
		      <th>教学建议</th>
		      <th>教学评价</th>
		    </tr>
		  </thead>
		  <tbody id="viewteacher">
		  </tbody>
		</table>
  <div class="actions">
    <div class="closebutton ui small blue button">确定</div>
  </div>
</div>
</div>

 <div class="mysecondmodel ui long modal">
  <i class="close icon"></i>
  <div class="ui header">
  听课详情
  </div>
  <div class="content">
		<table class="ui mini blue table">
		  <thead>
		    <tr>
		      <th>教师名称</th>
		      <th>教学课程</th>
		      <th>所带班级</th>
		      <th>班级均分</th>
		    </tr>
		  </thead>
		  <tbody id="secondviewteacher">
		  </tbody>
		</table>
  <div class="actions">
    <div class="closebutton ui small blue button">确定</div>
  </div>
</div>
</div>


	<!--这里绘制页面-->
</body>

<script type="text/javascript">

	    $(function(){
	    	var buttonval=1;
	    	$('#changebutton').unbind('click').click(function(){
	    		 $(this).attr("disabled","disabled");
	    		$(this).addClass('loading')
	    		if(buttonval==1){
	    			 buttonval=0;
	    			 renderChart();
	    			$(this).html('<i class=" exchange icon"></i>切换至督学评教')
	    		}else{
	    			buttonval=1;
	    			renderChart();
	    			 $(this).html('<i class= "exchange icon"></i>切换至学生评教')
	    		}
	    	});
    		    $(".closebutton").click(function(){
    					$('.ui.long.modal')
    					.modal({
    					    transition:'fly down',
    				     })
    					.modal('hide');
    				});
    		    load();
    		    function load(){
    		    $.ajax({
    				url:"do?invoke=checkteacherlisten@getTermno",
    				type:'POST',
    				dataType:'json',
    				data:{
      					term_no:SYSOBJCET.term_no
      				},
    				success:function(inf) {
    					term=inf.data;
    					for( var i=0;i<term.length;i++){
    					var dom='<option value="'+term[i].term_no+'">'+term[i].term_name+'</option>';
    					$("#selectbutton").append(dom)
    					}
    					$('#selectbutton').dropdown();
    				}
    				});
    		    };
    			$('#selectbutton').change(function(){
    			   SYSOBJCET.term_no=$('#selectbutton').val();
    			   renderChart();
    			   return;
    		    });
	    	//绘制echarts图形
	    	function renderChart(){
    			var temp;
    			if(buttonval==1){
	    		$.ajax({
    				url:"do?invoke=checkteacherlisten@getDepartmentListenmark",
    				type:'POST',
    				dataType:'json',
    				data:{
    					term_no:SYSOBJCET.term_no
    				},
    				success:function(rep) {
    					temp=rep.data;
    					createechart(temp);
    				}
    				});
    			}else{
    				$.ajax({
        				url:"do?invoke=checkteacherlisten@getDepartmentteassru_pj",
        				type:'POST',
        				dataType:'json',
        				data:{
        					term_no:SYSOBJCET.term_no
        				},
        				success:function(rep) {
        					temp=rep.data;
        					createechart(temp);
        				}
        				});
    			}
	    	      }
	    	function createechart(temp){
	    		var avg=[];
	    		var max=[];
	    		var min=[];
	    		var tempavg=[];
	    		var tempmin=[];
	    		var tempmax=[];
	    		var depname=[];
	    		var depno=[];
	    		if(temp.result==0)
	    		{
	    		    $.alert("",temp.result)
	    		}
	    		for(var i=temp.length-1;i>=0;i--){
	    			avg.push(temp[i].avgmark1);
	    			max.push(temp[i].maxmark);
	    			min.push(temp[i].minmark);
	    			depname.push(temp[i].dep_name);
	    			depno.push(temp[i].dep_no);
	    		}
	    		for(var i=0;i<temp.length;i++){
	    			var tempa=100-avg[i];
	    			var tempmi=100-min[i];
	    		    var  tempma=100-max[i];
	    		    tempavg.push(tempa);
	    		    tempmin.push(tempmi);
	    		    tempmax.push(tempma);
	    		}
	    	    /*  $("#chart").remove();
	    		 $("#container").append($("<div id='chart'></div>")); */
	    		 var myChart = echarts.init(document.getElementById('chart'));
	    		 //myChart.setTheme("macarons");     // 设置echart的主题(改变颜色)
	    		 var placeHoledStyle = {
	    				    normal:{
	    				        barBorderColor:'rgba(0,0,0,0)',
	    				        color:'rgba(0,0,0,0)'
	    				    },
	    				    emphasis:{
	    				        barBorderColor:'rgba(0,0,0,0)',
	    				        color:'rgba(0,0,0,0)'
	    				    }
	    				};
	    				var dataStyle = {
	    				    normal: {
	    				        label : {
	    				            show: true,
	    				            position: 'insideLeft',
	    				        }
	    				    }
	    				};
	    				option = {
	    				    title: {
	    				        text: '各部门上课质量统计图',
	    				        subtext: '点击图形查看明细',
	    				    },
	    				    tooltip : {
	    				        trigger: 'axis',
	    				        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
	    				            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	    				        },
	    				        formatter : function (params,ticket,callback) {
	    				            var res = params[0].name;
	    				            for (var i = 0, l = params.length; i < l; i++) {
	    				            	if(i%2==0){
	    				                res += '<br/>' + params[i].seriesName + ' : ' + params[i].value;
	    				                }
	    				            }
	    				            setTimeout(function (){
	    				                // 仅为了模拟异步回调
	    				                callback(ticket, res);
	    				            }, 10)
	    				            return 'loading';
	    				        }
	    				    },
	    				    legend: {
	    				        y: 55,
	    				        itemGap : document.getElementById('chart').offsetWidth / 8,
	    				        data:['部门最低分', '部门平均分','部门最高分'],
	    				    selected: {
	    			            '部门平均分' : false,
	    			            '部门最高分' : false
	    			        },
	    				    },
	    				    toolbox: {
	    				        show : true,
	    				        feature : {
	    				            mark : {show: true},
	    				            dataView : {show: true, readOnly: false},
	    				            restore : {show: true},
	    				            saveAsImage : {show: true}
	    				        }
	    				    },
	    				    grid: {
	    				        y: 80,
	    				        y2: 30
	    				    },
	    				    xAxis : [
	    				        {
	    				            type : 'value',
	    				            position: 'top',
	    				            splitLine: {show: false},
	    				            axisLabel: {show: false}
	    				        }
	    				    ],
	    				    yAxis : [
	    				        {
	    				            type : 'category',
	    				            splitLine: {show: false},
	    				            data : depname
	    				        }
	    				    ],
	    				    series : [
	    				        {
	    				            name:'部门最低分',
	    				            type:'bar',
	    				            stack: '总量',
	    				            itemStyle : dataStyle,
	    				            data:min
	    				        },
	    				        {
	    				            name:'部门最低分',
	    				            type:'bar',
	    				            stack: '总量',
	    				            itemStyle: placeHoledStyle,
	    				            data:tempmin
	    				        },
	    				        {
	    				            name:'部门平均分',
	    				            type:'bar',
	    				            stack: '总量',
	    				            itemStyle : dataStyle,
	    				            data:avg
	    				        },
	    				        {
	    				            name:'部门平均分',
	    				            type:'bar',
	    				            stack: '总量',
	    				            itemStyle: placeHoledStyle,
	    				            data:tempavg
	    				        },
	    				        {
	    				            name:'部门最高分',
	    				            type:'bar',
	    				            stack: '总量',
	    				            itemStyle : dataStyle,
	    				            data:max
	    				        }
	    				    ]
	    				};
	    	      myChart.setOption(option);
	    	      myChart.on("click",function(item){
	    	    	  if(buttonval==1){
	    	    	  if(item.seriesIndex==2){
	    	    		  var temp1=SYSOBJCET.term_no;
	    	    		  var temp2=item.name;
	    	    			open(BASE_PATH+"/qm/teacher/sup_viewclass.jsp?dep_name="+encodeURIComponent(temp2)+"&term_no="+SYSOBJCET.term_no+"&module=11&menu=33")
	    	    		  return;
	    	    	  }
	    	    	  if(item.seriesIndex==0||item.seriesIndex==4)
	    	        {
	    	    	   $.ajax({
	      				url:"do?invoke=checkteacherlisten@getTeacherlistendetails",
	      				type:'POST',
	      				dataType:'json',
	      				data:{
	      					dep_name:item.name,
	      					mark:item.data,
	      					term_no:SYSOBJCET.term_no
	      				},
	      				success:function(mes) {
	      			 		var addinformation=mes.data;
	    	    	  if($('#viewteacher').text()!="")
	    	    		  $('#viewteacher').html("");
	    	    	  for(var i=0;i<addinformation.length;i++)
	  			    {
	    	    		  if(addinformation[i].jxjy=='')
	    	    			  addinformation[i].jxjy="无听课评价";
	    	    		  if(addinformation[i].skpj=='')
	    	    			  addinformation[i].skpj="无上课评价";
	  			    	var dom=
	  						'<tr>'+
	  							 '<td ><div>'+addinformation[i].tkjs+'</div></td>'+
	  							'<td>'+addinformation[i].course_name+'</td>'+
	  							'<td>'+addinformation[i].rkjs+'</td>'+
	  							'<td>'+addinformation[i].total+'</td>'+
	  		                   '<td>'+
	  		                  '<div >'+
	  			                 '<div class="btnfirst circular ui blue basic icon button"   data-content="'+addinformation[i].jxjy+'">'+
	  			                     '<i class="plus icon"></i>'+
	  			                 '</div>'+
	  			                 '</div>'+
	  		                   '</td>';
	  		                 dom += '<td>'+
	  		                  '<div >'+
	  			                 '<div class="btnfirst circular ui blue basic icon button"   data-content="'+addinformation[i].skpj+'">'+
	  			                     '<i class="plus icon"></i>'+
	  			                 '</div>'+
	  			                 '</div>'+
	  		                   '</td>';
	  		                   $("#viewteacher").append(dom);
	  			    }
	    	    	  $('.circular.ui.blue.basic.icon.button').popup();
	    	    	  $('.mymodel')
	    	    		.modal({
	    	    			transition:'slide down',
	    	    			observeChanges:true,
	    	    			closable: false
	    	    		})
	    	    		  .modal('show')
	    	    		;
	      				}
	      				});
	    	      }

	    	    	  }
	    	    	  else{
	    	    	  if(item.seriesIndex==2){
	    	    		  var temp1=SYSOBJCET.term_no;
	    	    		  var temp2=item.name;
	    	    		open(BASE_PATH+"/qm/Master/master_view_stu_pj.jsp?dep_name="+temp2+"&term_no="+SYSOBJCET.term_no+"&module=11&menu=66")
	    	    		  return;
	    	    	  }
	    	    	  if(item.seriesIndex==0||item.seriesIndex==4)
	    	        {
	    	    	   $.ajax({
	      				url:"do?invoke=checkteacherlisten@getStudentpxdetails",
	      				type:'POST',
	      				dataType:'json',
	      				data:{
	      					dep_name:item.name,
	      					mark:item.data,
	      					term_no:SYSOBJCET.term_no
	      				},
	      				success:function(mes) {
	      			 	 var addinformation=mes.data;
	    	    	  if($('#secondviewteacher').text()!="")
	    	    		  $('#secondviewteacher').html("");
	    	    	  for(var i=0;i<addinformation.length;i++)
	  			    {
	  			    	var dom=
	  						'<tr >'+
	  							 '<td ><div>'+addinformation[i].teacher_name+'</div></td>'+
	  							'<td>'+addinformation[i].course_name+'</td>'+
	  							'<td>'+addinformation[i].class_name+'</td>'+
	  							'<td>'+addinformation[i].avgmark1+'</td>';
	  		                   $("#secondviewteacher").append(dom);
	  			    }
	    	    	  $('.circular.ui.blue.basic.icon.button').popup();
	    	    	  $('.mysecondmodel')
	    	    		.modal({
	    	    			transition:'slide down',
	    	    			observeChanges:true,
	    	    			closable: false
	    	    		})
	    	    		  .modal('show')
	    	    		;
	      				}
	      				});

	    	        }
	    	      }

          });
	    	      $('#changebutton').removeAttr("disabled");
	    	      $('#changebutton').removeClass('loading');
	    	}
 });
</script>

<!--这里引用其他JS-->
</html>