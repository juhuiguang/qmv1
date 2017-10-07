<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
	<%@page import="com.service.system.SystemStart"%>
	<%@page import="com.jhg.common.TypeUtils"%>
	<%
		String PATH = request.getContextPath();
		String BASE_URL  = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
		String BASE_PATH = BASE_URL + PATH +"/";
		request.setAttribute("BASE_PATH", BASE_PATH);

		//获取登录名称
		Object curloginname = session.getAttribute("loginname");

		String curuser = "";
		if (curloginname != null) {
			curuser = curloginname.toString();
		}
		com.alibaba.fastjson.JSONObject USEROBJECT = SystemStart
				.getUser(curuser);
		com.alibaba.fastjson.JSONObject SYSOBJCET = SystemStart.getSys();

	%>
	<base href="<%=BASE_PATH%>">
	<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
	<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<meta content="yes" name="apple-mobile-web-app-capable"/>
	<meta content="black" name="apple-mobile-web-app-status-bar-style" />
	<meta name="format-detection" content="telephone=no">
	<meta http-equiv="x-rim-auto-match" content="none">
	<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible"/>
	<meta name="description" content="he" />
	<meta name="author" content="AlienLab" />
	<link rel="icon" href="favicon.ico">

	<link href="<%=BASE_PATH %>/mobile/common/normalize.css?v=201500912" type="text/css" rel="stylesheet">

	<link href="<%=BASE_PATH %>/script/common/alert/jquery.alert.css?v=20150912" type="text/css" rel="stylesheet">
	<link href="<%=BASE_PATH %>/script/common/animate/animate.min.css?v=20150912" type="text/css" rel="stylesheet">
	<style id="J_style"></style>
	<script type="text/javascript">
        !function(){
            function b(){
                var e,b=document.getElementById("J_style"),
                    c=document.documentElement.clientWidth||document.body.clientWidth,
                    d=1;d=c/640,
                    e=parseInt(100*d),
                    b.innerHTML="html{font-size:"+e+"px;}body{font-size:0.24rem;}",
                    a=d;
                window.BASE_SIZE = d;
            }
            var a=0;b(),window.addEventListener("resize",b);
        }();
        var BASE_URL  = '<%=BASE_URL %>';
        var BASE_PATH = '<%=BASE_PATH %>';
        var SYSOBJECT=SYSOBJCET=<%=SYSOBJCET%>;
        var USEROBJECT=<%=USEROBJECT%>;
	</script>
	<style type="text/css">
		html,body{height:100%;color:#2c4041;}
		body{
			font-size:16px;
		}
		.ibMask{width:100%;min-height:100%;height:100%;background:rgba(0,0,0,0.5);position:absolute;top:0;z-index:200;}
		.ibLoader{width:40px;height:40px;position:relative;top:50%;width:50%;text-align:center;margin:0 auto;margin-top:-20px;}
		.sk-spinner-wave.sk-spinner { margin: 0 auto;width: 50px;height: 30px;text-align: center;font-size: 10px;}
		.sk-spinner-wave div {
			margin-left:2px;background-color: #fff;height: 100%;width: 6px;display: inline-block;
			-webkit-animation: sk-waveStretchDelay 1.2s infinite ease-in-out;animation: sk-waveStretchDelay 1.2s infinite ease-in-out;
		}
		.sk-spinner-wave .sk-rect2 { -webkit-animation-delay: -1.1s;animation-delay: -1.1s; }
		.sk-spinner-wave .sk-rect3 { -webkit-animation-delay: -1s;animation-delay: -1s; }
		.sk-spinner-wave .sk-rect4 { -webkit-animation-delay: -0.9s;animation-delay: -0.9s; }
		.sk-spinner-wave .sk-rect5 { -webkit-animation-delay: -0.8s;animation-delay: -0.8s; }
		@-webkit-keyframes sk-waveStretchDelay {
			0%, 40%, 100% { -webkit-transform: scaleY(0.4);transform: scaleY(0.4); }
			20% {	-webkit-transform: scaleY(1); transform: scaleY(1); }
		}
		@keyframes sk-waveStretchDelay {
			0%, 40%, 100% { -webkit-transform: scaleY(0.4);transform: scaleY(0.4); }
			20% { -webkit-transform: scaleY(1); transform: scaleY(1); }
		}
	</style>
	<script type="text/javascript">
        document.write('<div class="ibMask" id="ibMask">'+
            '<div class="sk-spinner sk-spinner-wave ibLoader">'+
            '<div class="sk-rect1"></div>'+
            '<div class="sk-rect2"></div>'+
            '<div class="sk-rect3"></div>'+
            '<div class="sk-rect4"></div>'+
            '<div class="sk-rect5"></div>'+
            '</div>'+
            '</div>');
	</script>
	<script type="text/javascript" charset="utf-8" src="<%=BASE_PATH %>script/common/jquery/jquery-2.0.0.min.js?v=20150912"></script>
	<script type="text/javascript" charset="utf-8" src="<%=BASE_PATH %>mobile/common/fastclick/fastclick.min.js?v=20150912"></script>
	<script type="text/javascript" charset="utf-8" src="<%=BASE_PATH %>script/common/alert/jquery.alert.js?v=20150912"></script>
	<script type="text/javascript" charset="utf-8" src="<%=BASE_PATH %>mobile/common/dragloader/dragloader.min.js?v=20150912"></script>
	<script type="text/javascript">
        $(document).ready(function(){ $("#ibMask") && $("#ibMask").is(":visible") && $("#ibMask").fadeOut(1000); });
	</script>
<link href="<%=BASE_PATH %>/script/common/semantic/semantic.css?v=201500912" type="text/css" rel="stylesheet">
<!--这里引用其他样式-->
<title>部门评价</title>
<style>
	input[type=range]{
		width:95% !important;
	}
	input[type=range] {
		-webkit-appearance: none;
		width: 50%;
	}
	input[type=range]:focus {
		outline: none;
	}
	input[type=range]::-webkit-slider-runnable-track {
		width: 100%;
		height: 11.4px;
		cursor: pointer;
		box-shadow: 1px 1px 1px #000000, 0px 0px 1px #0d0d0d;
		background: rgba(48, 113, 169, 0.78);
		border-radius: 1.3px;
		border: 0.2px solid #010101;
	}
	input[type=range]::-webkit-slider-thumb {
		box-shadow: 0.9px 0.9px 1px #000031, 0px 0px 0.9px #00004b;
		border: 1.8px solid #00001e;
		height: 26px;
		width: 26px;
		border-radius: 15px;
		background: #fffffd;
		cursor: pointer;
		-webkit-appearance: none;
		margin-top: -7.5px;
	}
	input[type=range]:focus::-webkit-slider-runnable-track {
		background: rgba(54, 126, 189, 0.78);
	}
	input[type=range]::-moz-range-track {
		width: 100%;
		height: 11.4px;
		cursor: pointer;
		box-shadow: 1px 1px 1px #000000, 0px 0px 1px #0d0d0d;
		background: rgba(48, 113, 169, 0.78);
		border-radius: 1.3px;
		border: 0.2px solid #010101;
	}
	input[type=range]::-moz-range-thumb {
		box-shadow: 0.9px 0.9px 1px #000031, 0px 0px 0.9px #00004b;
		border: 1.8px solid #00001e;
		height: 26px;
		width: 26px;
		border-radius: 15px;
		background: #fffffd;
		cursor: pointer;
	}
	input[type=range]::-ms-track {
		width: 100%;
		height: 11.4px;
		cursor: pointer;
		background: transparent;
		border-color: transparent;
		color: transparent;
	}
	input[type=range]::-ms-fill-lower {
		background: rgba(42, 255, 149, 0.78);
		border: 0.2px solid #010101;
		border-radius: 2.6px;
		box-shadow: 1px 1px 1px #000000, 0px 0px 1px #0d0d0d;
	}
	input[type=range]::-ms-fill-upper {
		background: rgba(48, 113, 169, 0.78);
		border: 0.2px solid #010101;
		border-radius: 2.6px;
		box-shadow: 1px 1px 1px #000000, 0px 0px 1px #0d0d0d;
	}
	input[type=range]::-ms-thumb {
		box-shadow: 0.9px 0.9px 1px #000031, 0px 0px 0.9px #00004b;
		border: 1.8px solid #00001e;
		height: 26px;
		width: 26px;
		border-radius: 15px;
		background: #fffffd;
		cursor: pointer;
		height: 11.4px;
	}
	input[type=range]:focus::-ms-fill-lower {
		background: rgba(48, 255, 169, 0.78);
	}
	input[type=range]:focus::-ms-fill-upper {
		background: rgba(54, 126, 189, 0.78);
	}
	.red{
		color:#aa0000;
	}
	.green{
		color:#00aa00;
	}
	.yellow{
		color:#aaaa00;
	}
	.fields label{
		font-size:16px !important;
		margin-bottom:10px !important;
	}

	.ui.bulleted.list .item{
		margin:7px auto;
	}
</style>
</head>
<body>
<script type="text/javascript" src="script/common/angularjs/angular.min.js"></script>
	<!--这里绘制页面-->
	<div id="container" class="ui grid container" ng-app="depcomment" ng-controller="depcommen_controller">
		<h1 class="ui sixteen wide column header" style="margin-top: 20px !important;padding: 0 !important;">
			<i class="tasks icon"></i>
			<div class="content">教师对部门评价</div>
		</h1>
		<div class="ui sixteen wide column header">对教学部门评价</div>
		<div class="ui sixteen wide column card" ng-repeat="teachdep in teachdeps | filter:{dep_type:'教学'}">
			<div class="content">
				<div class="header">{{teachdep.dep_name}}</div>
			</div>
			<div class="content">
				<div class="ui bulleted list">
					<div class="item">
						<div class="ui form">
							<div class="inline fields">
								<label>工作作风</label>
								<div class="field">
									<input type="range" defaultValue="0" value="0"  ng-model="teachdep.per11" max="25" min="0"/>
								</div>
								<div class="field">
									<a class="ui blue circular label">{{teachdep.per11}}</a>
								</div>
							</div>
						</div>
					</div>
					<div class="item">
						<div class="ui form">
							<div class="inline fields">
								<label>管理能力</label>
								<div class="field">
									<input type="range" defaultValue="0" value="0"  ng-model="teachdep.per12" max="25" min="0"/>
								</div>
								<div class="field">
									<a class="ui blue circular label">{{teachdep.per12}}</a>
								</div>
							</div>
						</div>
					</div>
					<div class="item">
						<div class="ui form">
							<div class="inline fields">
								<label>服务意识</label>
								<div class="field">
									<input type="range" defaultValue="0" value="0"  ng-model="teachdep.per13" max="25" min="0"/>
								</div>
								<div class="field">
									<a class="ui blue circular label">{{teachdep.per13}}</a>
								</div>
							</div>
						</div>
					</div>
					<div class="item">
						<div class="ui form">
							<div class="inline fields">
								<label>工作责任心</label>
								<div class="field">
									<input type="range" defaultValue="0" value="0"  ng-model="teachdep.per14" max="25" min="0"/>
								</div>
								<div class="field">
									<a class="ui blue circular label">{{teachdep.per14}}</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="extra content">
				<div class="right floated" ng-class="{red:(teachdep.per11+teachdep.per12+teachdep.per13+teachdep.per14)<60,green:(teachdep.per11+teachdep.per12+teachdep.per13+teachdep.per14)>=80,yellow:(teachdep.per11+teachdep.per12+teachdep.per13+teachdep.per14)>=60&&(teachdep.per11+teachdep.per12+teachdep.per13+teachdep.per14)<80}">
					当前打分：<span style="font-size:18px !important;font-weight:600 !important;">{{teachdep.per11+teachdep.per12+teachdep.per13+teachdep.per14}}</span>
				</div>
			</div>
		</div>
		<div class="ui sixteen wide column header">对行政部门评价</div>
		<div class="ui sixteen wide column card" ng-repeat="teachdep in teachdeps | filter:{dep_type:'行政'}">
			<div class="content">
				<div class="header">{{teachdep.dep_name}}</div>
			</div>
			<div class="content">
				<div class="ui bulleted list">
					<div class="item">
						<div class="ui form">
							<div class="inline fields">
								<label>工作作风</label>
								<div class="field">
									<input type="range" defaultValue="0" value="0"  ng-model="teachdep.per11" max="25" min="0"/>
								</div>
								<div class="field">
									<a class="ui blue circular label">{{teachdep.per11}}</a>
								</div>
							</div>
						</div>
					</div>
					<div class="item">
						<div class="ui form">
							<div class="inline fields">
								<label>管理能力</label>
								<div class="field">
									<input type="range" defaultValue="0" value="0"  ng-model="teachdep.per12" max="25" min="0"/>
								</div>
								<div class="field">
									<a class="ui blue circular label">{{teachdep.per12}}</a>
								</div>
							</div>
						</div>
					</div>
					<div class="item">
						<div class="ui form">
							<div class="inline fields">
								<label>服务意识</label>
								<div class="field">
									<input type="range" defaultValue="0" value="0"  ng-model="teachdep.per13" max="25" min="0"/>
								</div>
								<div class="field">
									<a class="ui blue circular label">{{teachdep.per13}}</a>
								</div>
							</div>
						</div>
					</div>
					<div class="item">
						<div class="ui form">
							<div class="inline fields">
								<label>工作责任心</label>
								<div class="field">
									<input type="range" defaultValue="0" value="0"  ng-model="teachdep.per14" max="25" min="0"/>
								</div>
								<div class="field">
									<a class="ui blue circular label">{{teachdep.per14}}</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="extra content">
				<div class="right floated" ng-class="{red:(teachdep.per11+teachdep.per12+teachdep.per13+teachdep.per14)<60,green:(teachdep.per11+teachdep.per12+teachdep.per13+teachdep.per14)>=80,yellow:(teachdep.per11+teachdep.per12+teachdep.per13+teachdep.per14)>=60&&(teachdep.per11+teachdep.per12+teachdep.per13+teachdep.per14)<80}">
					当前打分：<span style="font-size:18px;font-weight:600;">{{teachdep.per11+teachdep.per12+teachdep.per13+teachdep.per14}}</span>
				</div>
			</div>
		</div>
		<button style="position: fixed;top:10px;right:10px;background-color:rgba(0,0,180,0.5)" class="ui primary huge button" ng-click="dopost()">
			提交<br/>评价
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
				        teacher_no:jgh
					},
					url:'do?invoke=teacherDepComment@getCommentList'
				}).then(function(response){
                    callback(response.data);
				},function(){

				});
			}
			this.postResult=function(jgh,data,callback){
                $http({
                    method:'POST',
                    data:{
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