<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/commonjsp/doctype.jsp"%>
		<html>

		<head>
			<%@ include file="/commonjsp/meta.jsp"%>
				<script src="script/common/echarts/echarts-all.js"></script>
				<!--这里引用其他样式-->
				<title>校内教学质量监控运行平台</title>
<style>
	.ui.form .field>.selection.dropdown {
	    width: 80%;
}
</style>
</head>

		<body>
			<%@ include file="/commonjsp/header.jsp"%>
				<div id="container">
				<h3 class="ui header">
								<i class="list layout icon"></i>
                               <div class="content">全校出勤率查询 </div>
                               </h3>
					<div class="ui raised">
						<div class="ui form">
							<div class="fields">
								<div class="field">

									<select class="ui three dropdown" id="menu_term">
									</select>

								</div>
								<div class="  five wide field">

									<select class="ui three dropdown" id="menu_college">
									</select>
								</div>
								<div class="  field" style="margin-left: -50px;">
									<select class="ui two dropdown" id="menu_condition">
										<option value="0">所有记录</option>
										<option value="1" selected="selected"> 图表分析</option>
									</select>

								</div>

								<div class="field">
									<button class="ui basic button" id="btnsubmit"><i class="search icon"></i><b>查&nbsp;询</b></button>

								</div>
								<button class="ui basic button" style="position:absolute;left:87%;"  id="export_dc" data-content="点击导出" data-variation="small"><i class="upload icon"></i> 导 出 </button>			
							</div>        
						</div>

					</div>

					<table class="ui compact blue table" id="form_table">
						<thead>
							<tr>
								<th>编号</th>
								<th>部门</th>
								<th>平均出勤率</th>
								<th>参与总人次</th>

							</tr>
						</thead>
						<tbody>

						</tbody>
					</table>
						<div class="ui raised segment" id="main_">
                           <div id="main" style="height:400px"></div>
                        </div>	
					
				</div>
		</body>
		<script>
			$(function() {
				var SYSOBJCET = <%= SYSOBJCET %> ;
				var USEROBJECT = <%= USEROBJECT %> ;
				console.log(SYSOBJCET);
				console.log(USEROBJECT);
				var userpurview = USEROBJECT.userpurview;//取到这个的全限
				var college_no;
				var dep_name;
				var termno = SYSOBJCET.term_no;
				loadterm();
				$('#form_table').hide();
				$("#menu_condition").dropdown();
				$("#btnsubmit").click(function() {
					if ($(this).hasClass("loading")) return;
					$("#btnsubmit").addClass("loading");
					run();
				});

				function run() {
					if($("#menu_condition > option:selected").val()==0)
						{
						if (college_no == 0) {
							load_school_checking();
						} else {
							load_college_checking(dep_name);
						}
						}
					else{
						
						if (college_no == 0) {
							load_school_checking_photo();
						} else {
							load_college_checking_photo(college_no);
						}
						
					}
					
				}

				function loadterm() {
					$.ajax({
						url: "do?invoke=student_checking_inquire@get_checking_term",
						type: 'POST',
						dataType: 'json',
						success: function(rep) {
							if (rep.result == 0) {
								$.alert("学期获取错误");
							} else {
								var term_table = rep.data;
								for (var i = term_table.length - 1; i >= 0; i--) {
									if (i == term_table.length - 1) {
										var dom_term = '<option  selected="selected" value="' + term_table[i].term_no + '">' + term_table[i].term_name + '</option>';
										$('#menu_term').append($(dom_term));
									} else {
										var dom_term = '<option value="' + term_table[i].term_no + '">' + term_table[i].term_name + '</option>';
										$('#menu_term').append($(dom_term));
									}
								}
								$("#menu_term").dropdown({
									onChange: function(value, text) {
										termno = value;
									}
								});
								loadcollege();
							}
						}
					});
				}

				function loadcollege() {
					if(userpurview == 'ALL'){
						var dom='<option value="0" selected="selected">所有的院系</option>';
						$('#menu_college').append($(dom));
						for (var i = 0; i < (SYSOBJCET.departments).length; i++) {
							if (SYSOBJCET.departments[i].dep_type!="行政") {
								var dom_college = '<option value="' + SYSOBJCET.departments[i].dep_no + '">' + SYSOBJCET.departments[i].dep_name + '</option>';
								$('#menu_college').append($(dom_college));
							}
						}
						college_no = $("#menu_college > option:selected").val();
						$("#menu_college").dropdown({
							onChange: function(value, text) {
								dep_name = text;
								college_no=value;
							}
						});
						load_school_checking_photo();
					}else{
						console.log("123")
						var dom='<option value="'+USEROBJECT.userinfo.dep_no+'" selected="selected">'+USEROBJECT.userinfo.dep_name+'</option>';
						$('#menu_college').append($(dom));
						$("#menu_college").dropdown();
						dep_name = $("#menu_college > option:selected").text();
						college_no = $("#menu_college > option:selected").val();
						load_college_checking_photo();
					}
				}
                 
				//导出功能
		    	$("#export_dc").unbind('click').click(function(){
					var params = [];			
					params.push(termno);   
					var type = "excel";   
					open(BASE_PATH+"/qm/base/export.jsp?export_id=11&params="+params+"&type="+type+"&more=1");			    
		    	});
				
				function load_college_checking(dep_name) {//获取院系详细数据
					$.ajax({
						url: "do?invoke=TeacherCenter@get_college_attendancerate",
						type: 'POST',
						dataType: 'json',
						data: {
							term_no: termno,
							dep_name: dep_name
						},
						success: function(rep) {
							if (rep.result == 0) {
								$("#btnsubmit").removeClass("loading");
								$('#form_table tr:gt(0)').remove();
								$.alert("抱歉！暂无记录")
								$('#main_').hide();
								$('#form_table').show();
								
							} else {
								$('#form_table').show();
								$('#main_').hide();
								$('#form_table tr:gt(0)').remove();
								$("#btnsubmit").removeClass("loading");
								tablecollege = rep.data;
								for (var i = 0; i < tablecollege.length; i++) {
									var avg = parseFloat(tablecollege[i].ratio);
									var dom_stu = '<tr>' +
										'<td>' + (i + 1) + '</td>' +
										'<td>' + tablecollege[i].class_name + '</td>' +
										'<td>' + avg.toFixed(2) + '%'+ '</td>' +
										'<td>' + parseInt(tablecollege[i].numble)+ '</td>' +
										'</tr>';
									$('#form_table').append($(dom_stu));
								}
							}
						}
					});
				}
				
				
				function load_school_checking() {
					$.ajax({
						url: "do?invoke=TeacherCenter@get_school_attendancerate",
						type: 'POST',
						dataType: 'json',
						data: {
							term_no: termno,
						},
						success: function(rep) {
							if (rep.result == 0) {
								$.alert("暂无任何记录")
								$('#main_').hide();
								$('#form_table').show();
							} else {
								$('#form_table').show();
								$("#btnsubmit").removeClass("loading");
								$('#form_table tr:gt(0)').remove();
								$('#main_').hide();
								tableschool = rep.data;
								var xq=0;
								var xqnumble=0;
								var i ;
								for ( i = 0; i < tableschool.length; i++) {
									var radio = parseFloat(tableschool[i].radio);
									var dom = '<tr>' +
										'<td>' + (i + 1) + '</td>' +
										'<td>' + tableschool[i].dep_name + '</td>' +
										'<td>' + radio.toFixed(2) + '%' + '</td>' +
										'<td>' + parseInt(tableschool[i].numble) + '</td>' +
										'</tr>';
									$('#form_table').append($(dom));
									xq=parseFloat(xq)+parseFloat(tableschool[i].radio);
									xqnumble=parseInt(xqnumble)+parseInt(tableschool[i].numble);
								}
								var dom_ = '<tr>' +
								'<td>' + (i+1) + '</td>' +
								'<td>' + '全校' + '</td>' +
								'<td>' + (xq/tableschool.length).toFixed(2) + '%' + '</td>' +
								'<td>' + xqnumble + '</td>' +
								'</tr>';
							$('#form_table').append($(dom_));
							}
						}
					});
				}
				
				function load_college_checking_photo() {
					$.ajax({
						url: "do?invoke=TeacherCenter@get_class_attendancerate",
						type: 'POST',
						dataType: 'json',
						data: {
							term_no: termno,
							dep_no:college_no
						},
						success: function(rep) {
							if (rep.result == 0) {
								$("#btnsubmit").removeClass("loading");
								$.alert("抱歉！暂无记录")
								$('#form_table').hide();
								$('#main_').hide();
							} else {
								$('#main_').show();
								$('#form_table').hide();
								$("#btnsubmit").removeClass("loading");
								tablecollege = rep.data;
								var names=[];
					    		var avg=[];
					    		var max=[];
					    		var min=[];
					    		var avg_=[];
					    		var max_=[];
					    		var min_=[];for (var i = 0; i < tablecollege.length; i++) {
								     names.push(tablecollege[i].dep_name);
								     avg.push((Math.round(tablecollege[i].pj*100))/100);
								     max.push((Math.round(tablecollege[i].zd*100))/100);
								     min.push((Math.round(tablecollege[i].zx*100))/100);
								     avg_.push(100-(Math.round(tablecollege[i].pj*100))/100);
								     max_.push(100-(Math.round(tablecollege[i].zd*100))/100);
								     min_.push(100-(Math.round(tablecollege[i].zx*100))/100);
								}
					    		$("#btnsubmit").removeClass("loading");
								var myChart = echarts.init(document.getElementById('main')); 
								 myChart.setTheme("macarons");
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
										            formatter: '{c}%'
										        }
										    }
										};
										option = {
										    title: {
										        text: '院校出勤率分析',
										    },
										    tooltip : {
										        trigger: 'axis',
										        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
										            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
										        },
										        formatter : '{b}<br/>{a0}:{c0}%<br/>{a2}:{c2}%<br/>{a4}:{c4}%'
										    },
										    legend: {
										        y: 55,
										        itemGap : document.getElementById('main').offsetWidth / 8,
										        data:['最高出勤率', '最低出勤率', '平均出勤率']
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
										            data : names
										        }
										    ],
										    series : [
										        {
										            name:'最高出勤率',
										            type:'bar',
										            stack: '总量',
										            itemStyle : dataStyle,
										            data:max
										        },

										        {
										            name:'最低出勤率',
										            type:'bar',
										            stack: '总量',
										            itemStyle : dataStyle,
										            data:min
										        },

										        {
										            name:'平均出勤率',
										            type:'bar',
										            stack: '总量',
										            itemStyle : dataStyle,
										            data:avg
										        }

										    ]
										};
										     myChart.setOption(option); 
							}
						}
					});
				}

				function load_school_checking_photo() {
					$.ajax({
						url: "do?invoke=TeacherCenter@get_school_attendancerate",
						type: 'POST',
						dataType: 'json',
						data: {
							term_no: termno
						},
						success: function(rep) {
							if (rep.result == 0) {
								$.alert("暂无任何记录")
								$('#form_table').hide();
							} else {
								$('#form_table').hide();
								$("#btnsubmit").removeClass("loading");
								$('#form_table tr:gt(0)').remove();
								$('#main_').show();
								tableschool = rep.data;
								var names=[];
					    		var radios=[];
								for (var i = 0; i < tableschool.length; i++) {
									var radio = parseFloat(tableschool[i].radio).toFixed(2);
						    		names.push(tableschool[i].dep_name);
						    		radios.push(radio);
								}
								$("#btnsubmit").removeClass("loading");
								var myChart = echarts.init(document.getElementById('main')); 
								myChart.setTheme("macarons");     // 设置echart的主题(改变颜色)
						        var option = {
						    title: {
						        x: 'center',
						        text: '全校出勤率统计图',
						        subtext: '点击查看详情哦！',
						    },
						    tooltip: {
						        trigger: 'item',
						    },
						    toolbox: {
						        show: true,
						        feature: {
						            dataView: {show: true, readOnly: false},
						            restore: {show: true},
						            saveAsImage: {show: true}
						        }
						    },
						    grid: {
						        borderWidth: 0,
						        y: 80,
						        y2: 60
						    },
						    xAxis: [
						        {
						            type: 'category',
						            show: false,
						            data: names
						        }
						    ],
						    yAxis: [
						        {
						            type: 'value',
						            show: false
						        }
						    ],
						    series: [
						        {
						            name: '全校出勤率统计',
						            type: 'bar',
						            itemStyle: {
						                normal: {
						                    color: function(params) {
						                        // build a color map as your need.
						                        var colorList = [
						                           '#C1232B','#B5C334','#FCCE10','#E87C25','#27727B',
						                           '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD'
						                        ];
						                        return colorList[params.dataIndex]
						                    },
						                    label: {
						                        show: true,
						                        position: 'top',
						                        formatter: '{b}\n{c}%'
						                    }
						                }
						            },
						            data: radios,

						        }
						    ]
						};               
						        myChart.setOption(option);
						        myChart.on(echarts.config.EVENT.CLICK,function(item){
						        	  console.log(item.name);
					    	    	  load_college_checking(item.name)
					    	      });
							}
						}
					});
				}
			});
		</script>
		<!--这里引用其他JS-->

		</html>