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
<title>部门评价</title>
	<script>
        if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
            window.location = "mobile/teacher/tea_dep_comment.jsp"; //可以换成http地址
        }
	</script>
<style>
	table tr{
		height:60px;
	}
	table input[type=range]{
		width:75%;
		max-width:80%;
	}
	table .red{
		color:#aa0000;
	}
	table .green{
		color:#00aa00;
	}
	table .yellow{
		color:#aaaa00;
	}
</style>
</head>
<body>
<%@ include file="/commonjsp/header.jsp"%>
<script type="text/javascript" src="script/common/angularjs/angular.min.js"></script>
	<!--这里绘制页面-->
	<div id="container" class="" ng-app="depcomment" ng-controller="depcommen_controller">
		<h3 class="ui header" id='grbtkjl'>
			<i class="tasks icon"></i>
			<div class="content">教师对部门评价</div>
		</h3>
		<div class="ui small header">对教学部门评价</div>
		<table class="ui striped table">
			<thead>
				<tr class="mid aligned">
					<th class="two wide center aligned">部门</th>
					<th class="three wide center aligned">工作作风<br/>（25分）</th>
					<th class="three wide center aligned">管理能力<br/>（25分）</th>
					<th class="three wide center aligned">服务意识<br/>（25分）</th>
					<th class="three wide center aligned">工作责任心<br/>（25分）</th>
					<th class="two wide center aligned">总分<br/>（100分）</th>
				</tr>
			</thead>
			<tbody>
			<tr class="mid aligned" ng-repeat="teachdep in teachdeps | filter:{dep_type:'教学'}">
				<td class="collapsing center aligned" >
					<span style="font-size:18px;font-weight:600;">{{teachdep.dep_name}}</span>
				</td>
				<td class="collapsing center aligned">
					<input type="range" defaultValue="0" value="0"  ng-model="teachdep.per11" max="25" min="0"/>
					<a class="ui blue circular label">{{teachdep.per11}}</a>
				</td>
				<td class="collapsing center aligned">
					<input type="range" defaultValue="0" value="0"  ng-model="teachdep.per12" max="25" min="0"/>
					<a class="ui blue circular label">{{teachdep.per12}}</a>
				</td>
				<td class="collapsing center aligned">
					<input type="range" defaultValue="0" value="0"   ng-model="teachdep.per13" max="25" min="0"/>
					<a class="ui blue circular label">{{teachdep.per13}}</a>
				</td>
				<td class="collapsing center aligned">
					<input type="range" defaultValue="0" value="0"  ng-model="teachdep.per14" max="25" min="0"/>
					<a class="ui blue circular label">{{teachdep.per14}}</a>
				</td>
				<td class="collapsing center aligned" ng-class="{red:(teachdep.per11+teachdep.per12+teachdep.per13+teachdep.per14)<60}">
					<span style="font-size:18px;font-weight:600;">{{teachdep.per11+teachdep.per12+teachdep.per13+teachdep.per14}}</span>
				</td>
			</tr>
			</tbody>
		</table>
		<button class="ui primary button" ng-click="dopost()">
			提交对教学部门评价
		</button>
		<div class="ui divider"></div>
		<div class="ui small header">对行政部门评价</div>
		<table class="ui striped table">
			<thead>
			<tr class="mid aligned">
				<th class="two wide center aligned">部门</th>
				<th class="three wide center aligned">工作作风<br/>（25分）</th>
				<th class="three wide center aligned">管理能力<br/>（25分）</th>
				<th class="three wide center aligned">服务意识<br/>（25分）</th>
				<th class="three wide center aligned">工作责任心<br/>（25分）</th>
				<th class="two wide center aligned">总分<br/>（100分）</th>
			</tr>
			</thead>
			<tbody>
			<tr class="mid aligned" ng-repeat="teachdep in teachdeps | filter:{dep_type:'行政'}">
				<td class="collapsing center aligned" >
					<span style="font-size:18px;font-weight:600;">{{teachdep.dep_name}}</span>
				</td>
				<td class="collapsing center aligned">
					<input type="range" defaultValue="0" value="0"  ng-model="teachdep.per11" max="25" min="0"/>
					<a class="ui blue circular label">{{teachdep.per11}}</a>
				</td>
				<td class="collapsing center aligned">
					<input type="range" defaultValue="0" value="0"  ng-model="teachdep.per12" max="25" min="0"/>
					<a class="ui blue circular label">{{teachdep.per12}}</a>
				</td>
				<td class="collapsing center aligned">
					<input type="range" defaultValue="0" value="0"   ng-model="teachdep.per13" max="25" min="0"/>
					<a class="ui blue circular label">{{teachdep.per13}}</a>
				</td>
				<td class="collapsing center aligned">
					<input type="range" defaultValue="0" value="0"  ng-model="teachdep.per14" max="25" min="0"/>
					<a class="ui blue circular label">{{teachdep.per14}}</a>
				</td>
				<td class="collapsing center aligned" ng-class="{red:(teachdep.per11+teachdep.per12+teachdep.per13+teachdep.per14)<60}">
					<span style="font-size:18px;font-weight:600;">{{teachdep.per11+teachdep.per12+teachdep.per13+teachdep.per14}}</span>
				</td>
			</tr>
			</tbody>
		</table>
		<button class="ui primary button" ng-click="dopost()">
			提交对行政部门评价
		</button>
	</div>
</body>
<link rel="stylesheet"  href="script/common/datepicker/jquery.datetimepicker.css"></link>
<script src="script/common/datepicker/jquery.datetimepicker.js"></script>
<script>
	(function(){
	    'use strict';
		var app=angular.module("depcomment",[]);
		app.controller("depcommen_controller",["$scope","depcommenService","$filter",function($scope,depcommenService,$filter){
		    depcommenService.getCommentList(USEROBJECT.userinfo.teacher_no,function(data){
                for(var i=0;i<data.data.length;i++){
					data.data[i].per11=parseInt(data.data[i].per11);
                    data.data[i].per12=parseInt(data.data[i].per12);
                    data.data[i].per13=parseInt(data.data[i].per13);
                    data.data[i].per14=parseInt(data.data[i].per14);
				}
                $scope.teachdeps=data.data;
			});

            $scope.dopost=function(){
                $.confirm("操作提示","您的打分结果将被提交，确认提交吗？",function(){
                    for(var i=0;i<$scope.teachdeps.length;i++){
                        $scope.teachdeps[i].total=$scope.teachdeps[i].per11+$scope.teachdeps[i].per12+$scope.teachdeps[i].per13+$scope.teachdeps[i].per14
					}
                    depcommenService.postResult(USEROBJECT.userinfo.teacher_no,$scope.teachdeps,function(rep){
						if(rep.result>0){
						    $.alert("打分提交成功。如需修改打分，可直接修改重新提交。");
						}else{
                            $.alert("打分提交失败。"+rep.errorMsg);
						}
					});
                });
			}
		}]);
        app.filter('num', function() {
            return function(input) {
                return parseInt(input, 10);
            };
        });
		app.service("depcommenService",["$http",function($http){
		    this.getCommentList=function(jgh,callback){
				$http({
                    method:'POST',
					data:{
                        term_no:SYSOBJCET.term_no,
				        teacher_no:jgh
					},
					url:'do?invoke=teacherDepComment@getCommentList'
				}).then(function(response){
                    callback(response.data);
				},function(){

				});
			}
			this.postResult=function(jgh,data,callback){
		        var termno=SYSOBJCET.term_no;
		        if(termno==null||termno=="null"){
		            termno='20160'
				}
                $http({
                    method:'POST',
                    data:{
                        term_no:termno,
                        teacher_no:jgh,
						content:data
                    },
                    url:'do?invoke=teacherDepComment@postComment'
                }).then(function(response){
                    callback(response.data);
                },function(){

                });
			}
		}]);
	})();
</script>
<!--这里引用其他JS-->
</html>