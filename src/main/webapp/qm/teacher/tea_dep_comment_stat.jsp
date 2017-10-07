<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp" %>
<%
	String rootpath = new PropertyConfig("sysConfig.properties").getValue("rootpath");
%>
<html>
<head>
<%@include file="/commonjsp/meta.jsp" %>
<!--这里引用其他样式-->
<title>部门评价统计</title>
<style>

</style>
</head>
<body>
<%@ include file="/commonjsp/header.jsp"%>
<script type="text/javascript" src="script/common/angularjs/angular.min.js"></script>
	<!--这里绘制页面-->
	<div id="container" class="" ng-app="depcommentstat" ng-controller="depcommonstat_controller">
		<h3 class="ui header" id='grbtkjl'>
			<i class="tasks icon"></i>
			<div class="content">部门评价汇总</div>
		</h3>
		<h4 class="ui header">教学部门评价统计</h4>
		<div class="ui centered grid">
			<div class="seven wide column">
				<table class="ui striped table">
					<thead>
					<tr><th>部门</th>
						<th>应参评人数</th>
						<th>参评人数</th>
						<th>平均得分</th>
					</tr></thead>
					<tbody>
					<tr ng-repeat="teachdep in teachdeps|filter:{dep_type:'教学'}">
						<td ng-if="$index==0">
							<div class="ui red ribbon label">{{teachdep.dep_name}}</div>
						</td>
						<td ng-if="$index>0">
							{{teachdep.dep_name}}
						</td>
						<td>{{teachdep.teacher_count}}</td>
						<td>{{teachdep.comment_count}}</td>
						<td>{{teachdep.score}}</td>
					</tr>
					</tbody>
				</table>
			</div>
			<div class="nine wide column" id="chartpanel"  style="min-height:300px;">
				<ng-echarts  ec-config="chartConfig1" theme="theme" ec-option="dataOption1"></ng-echarts>
			</div>
		</div>

		<div class="ui divider"></div>

		<h4 class="ui header">行政部门评价统计</h4>
		<div class="ui centered grid">
			<div class="seven wide column">
				<table class="ui striped table">
					<thead>
					<tr><th>部门</th>
						<%--<th>应参评人数</th>--%>
						<th>参评人数</th>
						<th>平均得分</th>
					</tr></thead>
					<tbody>
					<tr ng-repeat="teachdep in teachdeps|filter:{dep_type:'行政'}">
						<td ng-if="$index==0">
							<div class="ui red ribbon label">{{teachdep.dep_name}}</div>
						</td>
						<td ng-if="$index>0">
							{{teachdep.dep_name}}
						</td>
						<%--<td>{{teachdep.teacher_count}}</td>--%>
						<td>{{teachdep.comment_count}}</td>
						<td>{{teachdep.score}}</td>
					</tr>
					</tbody>
				</table>
			</div>
			<div class="nine wide column"  style="min-height:300px;">
				<ng-echarts  ec-config="chartConfig2" theme="theme" ec-option="dataOption2"></ng-echarts>
			</div>
		</div>
	</div>
</body>
<link rel="stylesheet"  href="script/common/datepicker/jquery.datetimepicker.css"></link>
<script src="script/common/datepicker/jquery.datetimepicker.js"></script>
<script src="script/common/echarts/30/echarts.min.js"></script>
<script src="script/common/echarts/30/shine.js"></script>
<script>
	(function(){
	    'use strict';
		var app=angular.module("depcommentstat",[]);
		app.controller("depcommonstat_controller",["$scope","depcommenstatService","$filter",function($scope,depcommenstatService,$filter){
            depcommenstatService.getCommentStat(function(data){
				$scope.teachdeps=data.data;
				var deps1=[],deps2=[];
				var wcprs1=[],wcprs2=[];
				var pjf1=[],pjf2=[];
				var ycprs1=[],ycprs2=[];
				for(var i=0;i<$scope.teachdeps.length;i++){
					if($scope.teachdeps[i].dep_type=='教学'){
                        deps1.push($scope.teachdeps[i].dep_name);
                        wcprs1.push(($scope.teachdeps[i].teacher_count-$scope.teachdeps[i].comment_count)>=0?($scope.teachdeps[i].teacher_count-$scope.teachdeps[i].comment_count):0);
                        ycprs1.push($scope.teachdeps[i].comment_count);
                        pjf1.push($scope.teachdeps[i].score);
					}else{
                        deps2.push($scope.teachdeps[i].dep_name);
                        wcprs2.push(($scope.teachdeps[i].teacher_count-$scope.teachdeps[i].comment_count)>=0?($scope.teachdeps[i].teacher_count-$scope.teachdeps[i].comment_count):0);
                        ycprs2.push($scope.teachdeps[i].comment_count);
                        pjf2.push($scope.teachdeps[i].score);
					}
				}
                $scope.chartConfig1 = {
                    theme:'shine',
                    //event: [{click:onClick}],
                    dataLoaded:true
                };
                $scope.chartConfig2 = {
                    theme:'shine',
                    //event: [{click:onClick}],
                    dataLoaded:true
                };
                $scope.dataOption1={
                    tooltip : {
                        trigger: 'axis',
                        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                        }
                    },
                    legend: {
                        data:['平均得分','未参评人数','参评人数']
                    },
                    grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                    },
                    xAxis : [
                        {
                            type : 'category',
                            data : deps1
                        }
                    ],
                    yAxis : [
                        {
                            name: '平均得分',
                            type : 'value',
                            axisLabel: {
                                formatter: '{value}'
                            }
                        },{
                            name: '人数',
                            type:'value',
                            axisLabel: {
                                formatter: '{value}'
                            }
                        }
                    ],
                    series : [
                        {
                            name:'平均得分',
                            type:'bar',
                            data:pjf1,
                            markLine : {
                                lineStyle: {
                                    normal: {
                                        type: 'dashed',
                                        color:'yellow'
                                    }
                                },
                                data : [
                                    [{type : 'min'}, {type : 'max'}]
                                ]
                            }
                        },
                        {
                            name:'参评人数',
                            type:'bar',
                            //barWidth : 5,
                            yAxisIndex: 1,
                            stack: '人数',
                            data:ycprs1
                        },
                        {
                            name:'未参评人数',
                            type:'bar',
                            //barWidth : 5,
                            yAxisIndex: 1,
                            stack: '人数',
                            data:wcprs1
                        }
                    ]
				}
                $scope.dataOption2={
                    tooltip : {
                        trigger: 'axis',
                        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                        }
                    },
                    legend: {
                        data:['平均得分']
                    },
                    grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '15%',
                        containLabel: true
                    },
                    xAxis : [
                        {
                            type : 'category',
                            data : deps2,
                            boundaryGap:true,
                            axisLabel:{
                                interval:0,
                                rotate:45
                            }
                        }
                    ],
                    yAxis : [
                        {
                            name: '平均得分',
                            type : 'value',
                            axisLabel: {
                                formatter: '{value}'
                            }
                        }
                    ],
                    series : [
                        {
                            name:'平均得分',
                            type:'bar',
                            data:pjf2,
                            barWidth : 25,
							itemStyle:{
								normal:{
								    color:'#9dc6b3'
								}
							},
                            markLine : {
                                lineStyle: {
                                    normal: {
                                        type: 'dashed',
										color:'#c25055'
                                    }
                                },
                                data : [
                                    [{type : 'min'}, {type : 'max'}]
                                ]
                            }
                        }
                    ]
				}
			});

		}]);
        app.filter('num', function() {
            return function(input) {
                return parseInt(input, 10);
            };
        });
		app.service("depcommenstatService",["$http",function($http){
		    this.getCommentStat=function(callback){
				$http({
                    method:'POST',
					data:{
                        term_no:SYSOBJCET.term_no
					},
					url:'do?invoke=teacherDepComment@getCommentStat'
				}).then(function(response){
				    console.log(response);
                    callback(response.data);
				},function(){

				});
			}
		}]);
        app.directive('ngEcharts',[function(){
            return {
                link: function(scope,element,attrs,ctrl){
                    //console.log(element[0].parentNode);
                    element.css("width",element[0].parentNode.clientWidth);
                    element.css("height",element[0].parentNode.clientHeight);
                    angular.element(window).on('resize', function(){
                        element.css("width",element[0].parentNode.clientWidth);
                        element.css("height",element[0].parentNode.clientHeight);
                        refreshChart();
                    });
                    function refreshChart(){
                        var theme = (scope.config && scope.config.theme)
                            ? scope.config.theme : 'default';
                        var chart = echarts.init(element[0],theme);
                        if(scope.config && scope.config.dataLoaded === false){
                            chart.showLoading();
                        }

                        if(scope.config && scope.config.dataLoaded){
                            chart.setOption(scope.option);
                            chart.resize();
                            chart.hideLoading();
                        }

                        if(scope.config && scope.config.event){
                            if(angular.isArray(scope.config.event)){
                                angular.forEach(scope.config.event,function(value,key){
                                    for(var e in value){
                                        chart.on(e,value[e]);
                                    }
                                });
                            }
                        }
                    };

                    //自定义参数 - config
                    // event 定义事件
                    // theme 主题名称
                    // dataLoaded 数据是否加载

                    scope.$watch(
                        function () { return scope.config; },
                        function (value) {if (value) {refreshChart();}},
                        true
                    );

                    //图表原生option
                    scope.$watch(
                        function () { return scope.option; },
                        function (value) {if (value) {refreshChart();}},
                        true
                    );
                },
                scope:{
                    option:'=ecOption',
                    config:'=ecConfig'
                },
                restrict:'EA'
            }
        }]);
	})();
</script>
<!--这里引用其他JS-->
</html>