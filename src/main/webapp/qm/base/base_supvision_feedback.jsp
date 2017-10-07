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
#depdiv .label {
	margin-bottom: 10px;
}

.ui.fluid.selection.dropdown {
	width: 30%;
	margin-left: 70%;
}

.listenxxInf {
	display: none;
}

#grbtkjl {
	float: left;
}

.ui.blue.striped.table {
	width: 100%;
}

#tkjs {
	width: 13%;
}
#fkhf{
width:60%;
height:300px;
margin-left:19%;
}
.tx_{
width:100%;
height:60px;
}
#btnsubmit{
float:right;
}
#downloadBtn{
margin-left:80.5%;
}


</style>
</head>
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<div id="container">
				<h3  class="ui header "> 
		  			<i class="unordered list icon"></i>
		  				信息员反馈管理
			</h3>
<!-- 		<div id="depdiv"> -->
<!-- 			<a class="ui blue label" id="all">全&nbsp;&nbsp;&nbsp;&nbsp;部</a> <a -->
<!-- 				class="dep ui gray label" id="2241">能源与电气工程学院</a> -->
<!-- 		</div> -->
		<div class="ui small violet  button addAward" id="downloadBtn">
			<i class="file word outline icon"></i> 下载信息员汇总表
		</div>
		<!-- 		<div class="ui selection dropdown"> -->
		<!-- 			<i class="dropdown icon"></i> <span class="default text">请先选择学年学期</span> -->
		<!-- 			<div class="menu infro"></div> -->
		<!-- 		</div> -->
		<div class="ui one modal" id="tcc">
  <i class="close icon"></i>
  <div class="header">信息员回复</div>
  <div class="image content">
<div class="ui card" id="fkhf">
  <div class="content" id="fknr">
  </div>
  <div class="extra content">
   <div class="ui action input tx_">
  <input type="text" placeholder="请输入回复内容" id="ddfh">
  <button class="ui button" id="tj">提交</button>
</div>
  </div>
</div>
	</div>
          </div>
		<table class="ui celled center very compact blue striped table"
			id="feedback_table">
			<thead>
				<tr class="center aligned">
					<th>反馈日期</th>
					<th>反馈标题</th>
					<th>反馈类型</th>
					<th>回复人员</th>
					<th>回复日期</th>
					<th>查看详情</th>
					<th>管理操作</th>
				</tr>
			</thead>
			<tbody id="tablepane" class="center aligned">
			</tbody>
		</table>
		<div class="ui green large message" id="no_function">
			<i class="frown large inverted yellow circular icon"></i>
			抱歉！您不是信息员哦，暂不能使用此功能！
		</div>
		<div class="ui green large message" id="no_function2">
			<i class="announcement large inverted yellow up circular icon"></i>
			本学期还未进行反馈哦!
		</div>
	</div>
	<!--这里绘制页面-->
</body>
<script>
$(function() {
	$('#no_function').hide();
	$('#no_function2').hide();
	var feedback_no = "";
	var SYSOBJCET =
<%=SYSOBJCET%>
	;
	var USEROBJECT =
<%=USEROBJECT%>
	;
	var dep_no = USEROBJECT.userinfo.dep_no;
	initDep();
	function initDep() {
		$("#depdiv").hide();
		var deps = SYSOBJECT.departments;
		$("#depdiv .dep").remove();
		for (var i = 0; i < deps.length; i++) {
			var depdiv = $('<a class="dep ui gray label"" id="'+deps[i].dep_no+'">'
					+ deps[i].dep_name + '</a>');
			$("#depdiv").append(depdiv);
		}
		$("#depdiv").fadeIn();
		$("#depdiv .label").click(function() {
			$("#depdiv .blue").removeClass("blue");
			$(this).addClass("blue");
			//temp_dep_no = this.id;
			pageindex = 1;
			temppage = 1;
			pagelength = 8;
			loadingTable();
		});
	}
	function saveTable() {  
		var nr=$('#nr_three').text();
	    var resp_content=$('#ddfh').val();
	    if(feedback_no == "") {
	    	$.alert("该反馈的ID号获取失败！");
	    	return;
	    }
		$.ajax({
					url : "do?invoke=baseFeedBackAction@savetable",
					type : 'POST',
					dataType : 'json',
					data : {
						feedback_content:nr,
						account_no:USEROBJECT.loginname,
						resp_content:resp_content,
						feedback_no:feedback_no
						
					},
					success : function(rep) {
						$.alert("", rep.message);
						$('#tcc').modal({
		    				transition:'vertical flip',
		    				observeChanges:true,
		    				closable:false
		    			})	    
						.modal('hide');
						
						loadingTable();
					}
				});
	}
	
	loadingTable();
	function loadingTable() { //点击学期刷新表单学期  
		$('#tablepane').html("");
		$.ajax({
					url : "do?invoke=baseFeedBackAction@getStudentFeedBacksByDepNoLists",
					type : 'POST',
					dataType : 'json',
					data : {
						dep_no : dep_no,
						term_no:SYSOBJCET.term_no   
					},
					success : function(rep) {
						if (rep.result == 0) {
							$('#no_function2').show();
							$('#feedback_table').remove();
						} else {
							console.log(rep);
							//判断反馈列表是否为空
							$('#no_function').hide();
							$('#no_function2').hide();
							initTable(rep);
							
						}

					}
				});
	}
	$('#tj').click(function(){
		saveTable();
	});
	function initTable(rep) {
		var temp = rep.data;
		console.log(temp);
		for (var i = 0; i < temp.length; i++) {
			var dom = '<tr class="listenInf">';
			dom += '<td>' + temp[i].feedback_time.substring(0,10) + '</td>';
			if(temp[i].feedback_title == "教师教学情况") {
				dom += '<td>' + temp[i].feedback_title + ' 《'+temp[i].course_name+'》 </td>';
			} else {
				dom += '<td>' + temp[i].feedback_title + '</td>';
			}
			dom += '<td>' + temp[i].feedback_type + '</td>';
			if (temp[i].task_id == 0) {
				temp[i].task_id = "";
			}
			//dom += '<td>' + temp[i].task_id + '</td>';
			dom += '<td>' + temp[i].teacher_name + '</td>';
			dom += '<td>' + temp[i].resp_time.substring(0,10) + '</td>';
			dom += '<td ><div class="btnfirst circular ui small blue basic icon button"  data-content="点击可查看详情哦！" ><i class="file blue text icon"></i></div></td>';
			dom += '<td ><div class="btnhf circular ui small green basic icon button"  id="'+temp[i].feedback_no+'" data-content="点击可进行回复哦！"'+'nr='+'"'+temp[i].feedback_content+'"' +'lx='+'"'+temp[i].feedback_type+'"'+' ><i class=" green write icon"></i></div></td>';
			dom += '</tr>';
			dom += '<tr class="listenxxInf" >'
					+ '<td colspan=1 class="positive">反馈内容</td>'
					+ '<td colspan=5 class="positive" id="'+temp[i].feedback_content+'">'
					+ temp[i].feedback_content + ' </td>' + '</tr>'
					+ '<tr class="listenxxInf">'
					+ '<td colspan=1 class="positive" >回复内容 </td>'
					+ '<td colspan=5 class="positive">' + temp[i].resp_content
					+ ' </td>' + '</tr>';
			$("#tablepane").append(dom);
		}
		$('.btnfirst').popup();
		$('.btnhf').popup();
		$('.btnhf').click(function(){
			var nr=$(this).attr("nr");
			var lx=$(this).attr("lx");
			feedback_no = $(this).attr("id");
			$('#fknr').text("");
			$('#ddfh').val("");
			var dom_three= '<div class="header">' +'反馈内容'+ '</div>';
			$('#fknr').append($(dom_three));
			var dom_two= '<div class="meta">' + lx+ '</div>';
			$('#fknr').append($(dom_two));
			var dom_one = '<div class="description" id="nr_three">' +nr + '</div>';
			$('#fknr').append($(dom_one));
			
			$('#tcc').modal({
    				transition:'vertical flip',
    				observeChanges:true,
    				closable:false
    			})	    
				.modal('show');
		});
		$('.btnfirst').click(
				function() { //点击查看详情        
					$(this).parents(".listenInf").next().fadeToggle(500).next()
							.fadeToggle(500);
				});

	}
});
</script>
<!--这里引用其他JS-->
</html>