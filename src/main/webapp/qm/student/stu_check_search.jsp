<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head> 
<%@ include file="/commonjsp/meta.jsp"%>
<script src="script/common/datepicker/jquery.datetimepicker.js" type="text/javascript"></script>
<link rel="stylesheet" href="script/common/datepicker/jquery.datetimepicker.css" />
<title>校内教学质量监控运行平台</title>
<style> 
.teaDetailBtn{
		cursor:pointer; 
	} 
.teaDetailBtn:hover{
		color:#35bdb2; 
	} 
#btnsubmit {
	width: 20px;
}

#img {
	margin-left: -12px;
}
#warningBtn{
	position:absolute;
	top:115px;
	right:1%; 
}
#exportBtn{
position:absolute;
	top:115px;
	right:15%; 
}
#uiForm .itemField{
	float:left;
	margin-right:5px;
}
#uiForm .itemField input{
	min-width:auto !important;
	width:100%;
}
#uiForm .ui.dropdown{
min-width:0 !important;
width:100%;
}
#exportDetailBtn{
	margin-left:25px;
}
</style>     
</head>  
<body>
<%@ include file="/commonjsp/header.jsp"%> 
	<div id="container" >
		<h3 class="ui header">
			<i class="list layout icon"></i>
         	 <div class="content"> 考勤查询 </div>
         </h3>
         <!-- 出勤预警按钮 -->
         <button class="ui small blue button" id="exportBtn"><i class="download icon"></i>导出</button>
         <button class="ui small blue button" id="warningBtn"><i class="alarm icon"></i>考勤预警</button>
        		<div class="ui raised">
						<div class="ui form" id="uiForm">   
								<div class="itemField" style="width:26%">
 
									<select class="ui term dropdown" id="menu_term">
									</select> 
 
								</div>  
								<div class="itemField" style="width:23%"> 
   
									<select class="ui dep dropdown" id="menu_dep"> 
									</select>

								</div>
								<div class="itemField"style="width:15%;">

									<input id="date_timepicker_start" type="text" placeholder="开始时间" >

								</div>
								<div class="itemField"style="width:15%;">

									<input id="date_timepicker_end" type="text" placeholder="截止时间" >

								</div>
								<div class="itemField" style="width:12%;"> 

									<input id="stu_name" type="text" placeholder="学生姓名" >

								</div>
								<div class="itemField">
									<button data-content = "查询" class="ui small basic button" id="btnsubmit"><i class=" large search icon" id="img"></i></button>

								</div> 
								<div style="clear:both;"></div>
						</div>
				</div>
					
					<div id="tableDiv" style="margin-top:10px;">
						<table class="ui compact striped blue table" id="studentCheckTable">
							<thead>
								<tr >
									<td>编号</td> 
									<td>学号</td> 
									<td>姓名</td>
									<td>班级</td>
									<td>旷课</td>
									<td>迟到</td>
									<td>早退</td>
									<td>累计缺勤</td>
									<td>查看详情</td>
								</tr>
							</thead>
							<tbody>
	
							</tbody>
						</table>
						
						<center>
							<div id="spanbutton">
				
								<div class="ui  horizontal divided list">
									<div class="item">
										<a href="javascript:void(0);" id="spanFirst" page="1">第一页</a>
									</div>
									<div class="item">
										<a href="javascript:void(0);" id="spanPre" page="1">上一页</a>
									</div>
									<div class="item">
										<a href="javascript:void(0);" id="spanNext" page="2">下一页</a>
									</div>
									<div class="item">
										<a href="javascript:void(0);" id="spanLast">最后一页</a>
									</div>
									<div class="item">
										第<span id="spanPageNum"></span>页 /共<span id="spanTotalPage"></span>页
									</div>
				
								</div>
							</div>
						</center>
					</div>
					<div id="blockDiv" style= "display:none;margin-top:10px;">
						<div class="ui positive  large message" id="messageinf" >
						<i class="announcement large inverted yellow up circular icon"></i>
							暂无缺勤记录     
						</div> 
					</div>
					
					<div class="ui large modal" id="warningModule">
					  
					  <div class="header">
						  学生出勤预警
					   <i class="close icon" style="float:right;cursor:pointer;"></i>
					  </div>
					  <div class="content"> 
					   	 <iframe src="qm/student/school_checking.jsp" style="width:100%;min-height:500px" > 
						</iframe> 
					  </div>
					</div>
					
					<div class="ui large modal" id="checkDetail">
					  
					  <div class="header">
						  缺勤详情
						  <button class="ui small blue button" id="exportDetailBtn"><i class="download icon"></i>导出</button>
					   <i class="close icon" style="float:right;cursor:pointer;"></i>
					  </div>
					  <div class="content"> 
					   	
						<table class="ui compact striped table" id="studentCheckDetailTable">
							<thead>
								<tr>
									<td>编号</td> 
									<td>课程名称</td>
									<td>课程类型</td>
									<td>授课教师</td>
									<td>周次</td>
									<td>节次</td>
									<td>缺勤状态</td>
								</tr>
							</thead>
							<tbody>
	
							</tbody>
						</table>
					  </div>
					</div>
					
	</div>
	<!--这里绘制页面-->
</body> 
<script>  
	$(function() { 
		var totalPage; //总页数
		var pageIndex = 1;//当前页
		var pageLength = 15; //每页数量
		var now = new Date();
		var yesterDay = new Date(now.getTime()- 86400000);
		var date = now.getFullYear() + "-" + ((yesterDay.getMonth() + 1) < 10 ? "0" : "") + (yesterDay.getMonth() + 1) + "-" + (yesterDay.getDate() < 10 ? "0" : "") + yesterDay.getDate();
		var SYSOBJCET=<%=SYSOBJCET%>;  
		var USEROBJECT=<%=USEROBJECT%>;  
		var termno = SYSOBJCET.term_no;
		var tea_no=USEROBJECT.loginname;      
		var depno=USEROBJECT.userinfo.dep_no;
		//导出
		$('#exportBtn').unbind('click').click(function(){
			var params = [];		
			params.push(termno_temp);
			params.push(time_star_temp); 
			params.push(time_end_temp);
			var student_name_export = student_name_temp;
			if(student_name_export == null){
				student_name_export = "";
			}
			var student_name_export_ = "%" + student_name_export + "%";
			params.push(student_name_export_);
			var type = "excel"; 
			if(dep_no_temp == '0'){ 
				open(BASE_PATH+"/qm/base/export.jsp?export_id=17&params="+encodeURIComponent(params)+"&type="+type+"&more=1");
			}else{
				params.push(dep_no_temp);   
				open(BASE_PATH+"/qm/base/export.jsp?export_id=18&params="+encodeURIComponent(params)+"&type="+type+"&more=1");
			}
		}) 
		$('#btnsubmit').popup();
		//加载学年学期
		loadterm();
		function loadterm() {
			$.ajax({
				url: "do?invoke=student_checking_inquire@get_checking_term",
				type: 'POST',
				dataType: 'json',
				async: false,
				success: function(rep) {
					if (rep.result == 0) {
						$.alert("", rep.message);
					} else {
						var term_table = rep.data;
						for (var i = term_table.length - 1; i >= 0; i--) {
							if (i == term_table.length - 1) {
								var dom_term = '<option   selecter="selected" value="' + term_table[i].term_no + '" start="' + term_table[i].term_startdate.substring(0, 4) + '-' + term_table[i].term_startdate.substring(4, 6) + '-' + term_table[i].term_startdate.substring(6, 8) + '" end="' + date + '">' + term_table[i].term_name + '</option>';
								$('#menu_term').append($(dom_term));
							} else {
								var dom_term = '<option value="' + term_table[i].term_no + '" start="' + term_table[i].term_startdate.substring(0, 4) + '-' + term_table[i].term_startdate.substring(4, 6) + '-' + term_table[i].term_startdate.substring(6, 8) + '" end="' + term_table[i + 1].term_startdate.substring(0, 4) + '-' + term_table[i + 1].term_startdate.substring(4, 6) + '-' + term_table[i + 1].term_startdate.substring(6, 8) + '" >' + term_table[i].term_name + '</option>';
								$('#menu_term').append($(dom_term));
							}
						}
						//给时间选择器赋值 ，默认前一天
						$('#date_timepicker_start').attr("value", $('#menu_term>option:selected').attr("end"));
						$('#date_timepicker_end').attr("value", $('#menu_term>option:selected').attr("end"));
						
						$("#menu_term").dropdown({
							onChange: function(value, text) {
								termno = value;
								$('#date_timepicker_start').val($('#menu_term>option:selected').attr("start"));
								$('#date_timepicker_end').val($('#menu_term>option:selected').attr("end"));
							}
						});
					}
				}
			});
		}
		//加载部门
		loadcollege();
		function loadcollege() { 
			if(USEROBJECT.userpurview=='ALL'){
				var dom='<option value="0" selected="selected">所有的院系</option>';
				$('#menu_dep').append($(dom));
				for (var i = 0; i < (SYSOBJCET.departments).length; i++) { //将学生记录以表格的形式展现出来
					if (SYSOBJCET.departments[i].dep_type!="行政") {
					var dom_college = '<option value="' + SYSOBJCET.departments[i].dep_no + '">' + SYSOBJCET.departments[i].dep_name + '</option>';
					$('#menu_dep').append($(dom_college));
					}
				}
				$("#menu_dep").dropdown();
			}else{
				var dom='<option value="'+USEROBJECT.userpurview+'" selected="selected">'+SYSOBJCET.departments.find(function(d){return (d.dep_no===USEROBJECT.userpurview)}).dep_name+'</option>';
				$('#menu_dep').append($(dom));
				$("#menu_dep").dropdown();
			}
		}
		jQuery(function() {
			jQuery('#date_timepicker_start').datetimepicker({
				format: 'Y-m-d',
				lang: 'zh',
				onShow: function(ct) {
					this.setOptions({})
				},
				timepicker: false
			});
			jQuery('#date_timepicker_end').datetimepicker({
				format: 'Y-m-d', 
				lang: 'zh',
				onShow: function(ct) {
					this.setOptions({})
				},
				timepicker: false
			});
		});
		//初始化加载
		loadCheckTable();
		function loadCheckTable(){
			 dep_no_temp = $('#menu_dep >option:selected').val();
			 time_star_temp = $('#date_timepicker_start').val();
			 time_end_temp = $('#date_timepicker_end').val();
			 student_name_temp = $('#stu_name').val(); 
			 termno_temp = termno;
			 loadPageTable('0');
		} 
		/* 点击查询 */
		$('#btnsubmit').unbind('click').click(function() {
			//查询数据（分页）
			loadCheckTable();
		});  
		/* 点击考勤预警 */
		$('#warningBtn').unbind('click').click(function() {
			//iframe放在弹出层中
			$('#warningModule').modal('show');
		});
		
		function drawnTable(info ,message, index){
			if(info != null){
				
				//清空表格
				$('#studentCheckTable tbody').empty();
				//绘制表格
				console.log(info)
				var dom = "";
				for(var i = 0 ; i < info.length ; i++){
					dom+='<tr >'+
							'<td>'+
								((parseInt(pageIndex) - 1)*parseInt(pageLength)+i+1)+
							'</td>'+
							'<td>'+
								info[i].stu_no+
							'</td>'+
							'<td>'+
								info[i].stu_name+
							'</td>'+
							'<td>'+
								info[i].class_name+
							'</td>'+
							'<td>'+
								info[i].kkamount+
							'</td>'+
							'<td>'+
								info[i].cdamount+
							'</td>'+
							'<td>'+
								info[i].ztamount+
							'</td>'+
							'<td>'+
								info[i].allamount+
							'</td>'+ 
							'<td >'+
							'<i data-variation="mini" stu_no = "'+info[i].stu_no+'" class="teaDetailBtn circular list layout  icon"></i>'+
							'</td>'+
						'</tr>';
				}
				$('#studentCheckTable tbody').append($(dom));
				$('.teaDetailBtn').unbind('click').click(function(){
					//查看缺勤详情
					
					//请求数据
					getCheckDetail($(this).attr('stu_no'));
					
				})
				//改变底部页码栏
				 	//改变当前页
				 	$('#spanPageNum').text(pageIndex);
				if(index == '0'){
					//改变总页
					totalPage = Math.ceil(parseInt(message) / parseInt(pageLength)); 
					$('#spanTotalPage').text(totalPage);
				}
			}
		}
		 var weekArray = {
					'1':'星期一',
					'2':'星期二',
					'3':'星期三', 
					'4':'星期四',
					'5':'星期五',
					'6':'星期六',
					'7':'星期日'
			}
			var setArray = {
					'1':'一二节',
					'2':'三四节',
					'3':'五六节', 
					'4':'七八节',
					'5':'晚自习'
			}
        var setArray2 = {
            '1':'一节',
            '2':'二节',
            '3':'三节',
            '4':'四节',
            '5':'五节',
            '6':'六节',
            '7':'七节',
            '8':'八节',
            '9':'九节'

        }
		function getCheckDetail(stu_no_temp){
			$.ajax({
				url: "do?invoke=student_checking_inquire@getCheckDetailInfo",
				type: 'POST',
				dataType: 'json',
				data:{
					dep_no : dep_no_temp , 
					time_star : time_star_temp,
					time_end:time_end_temp,
					term_no:termno_temp, 
					stu_no:stu_no_temp
				},
				success: function(rep) { 
					$('#studentCheckDetailTable tbody').empty();
					var checkInfo = rep.data;
					var dom = "";
					for(var i = 0 ; i < checkInfo.length ; i++){
						var check_week_temp;
						if(checkInfo[i].sche_set == ""|| checkInfo[i].sche_set == "K99"){
							check_week_temp = checkInfo[i].check_sx;
						}else{
							check_week_temp = checkInfo[i].sche_set;
						}
						dom+='<tr>'+
							'<td>'+
							(i+1)+
							'</td>'+
							'<td>'+
							checkInfo[i].course_name+
							'</td>'+ 
							'<td>'+
							checkInfo[i].course_type+
							'</td>'+
							'<td>'+
							checkInfo[i].teacher_name+
							'</td>'+
							'<td>'+ 
							checkInfo[i].check_week+
							'</td>'+
							'<td>'+
							((!SINGLESCHE)?
							(weekArray[check_week_temp.substring(1,2)]+'/'+setArray[check_week_temp.substring(2,3)])
							:
							(weekArray[check_week_temp.substring(1,2)]+'/'+setArray2[check_week_temp.substring(2,3)]))+
							'</td>'+ 
							'<td>'+ 
							checkInfo[i].check_status+
							'</td></tr>';
					}
					$('#studentCheckDetailTable tbody').append($(dom)) ; 
					$('#checkDetail').modal('show');
					$('#exportDetailBtn').unbind('click').click(function(){
						
						var params = [];		
						params.push(termno_temp);
						params.push(time_star_temp);
						params.push(time_end_temp);
						params.push(stu_no_temp);
						var type = "excel"; 
						
						open(BASE_PATH+"/qm/base/export.jsp?export_id=19&params="+params+"&type="+type+"&more=1");
						
					})
				}
			});
		}
		function loadPageTable(index){
			var flag = "";
			if(index == '0'){
				pageIndex = '1';
				flag = "first";
			}
			$.ajax({
				url: "do?invoke=student_checking_inquire@getCheckInfo",
				type: 'POST',
				dataType: 'json',
				data:{
					dep_no : dep_no_temp , 
					time_star : time_star_temp,
					time_end:time_end_temp,
					term_no:termno_temp,
					student_name:student_name_temp,
					pageIndex : pageIndex,
					pageLength : pageLength,
					flag:flag
				},
				success: function(rep) {
					if (rep.result == 0) {
						//无记录
						$('#blockDiv').show();
						$('#tableDiv').hide();
					} else {
						$('#blockDiv').hide();
						$('#tableDiv').show();
						//绘制表格
						drawnTable(rep.data ,rep.message, index);
					}
				}
			});
		}
		$("#spanFirst").bind("click", function() {
			loadPageTable('0');
		});
		$("#spanLast").bind("click", function() {
			pageIndex = totalPage;
			loadPageTable();
		});
		$("#spanNext").bind("click", function() { 
			if(parseInt(pageIndex) < parseInt(totalPage)){
				pageIndex =parseInt(pageIndex) + 1;
				loadPageTable();
			}
		});
		$("#spanPre").bind("click", function() {
			if(parseInt(pageIndex) > 1 ){
				pageIndex =parseInt(pageIndex) -1 ;
				loadPageTable() ; 
			}
		}); 
	});

</script>
<!--这里引用其他JS-->
</html>