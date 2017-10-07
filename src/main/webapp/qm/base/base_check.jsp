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
	#container{
	  padding-top:115px !important; 
	}
	.detailBtn,.teaDetailBtn , .teaExport{
		cursor:pointer;
	}
	.detailBtn:hover{
		color:#35bdb2;
	}
	.teaDetailBtn:hover{
		color:#35bdb2; 
	} 
	.teaExport:hover{
		color:#db2828; 
	} 
	td{
		padding:4px !important;   
	}
</style>     
</head>  
<body>
<%@ include file="/commonjsp/header.jsp"%>
	<div id="container">
		<h3 class="ui header" id="ktkq"> 
			<i class="student icon"></i>   
			<div class="content">考勤查询</div>      
		</h3> 
		<div style="margin-bottom:10px;" id="selectBox">
			<select class="ui term dropdown " id="menu_term"></select>
			<select class="ui selection dropdown " id="menu_week"></select>
		</div>
		<button id="mainExport" class="ui blue small button" style="position:absolute;right:0;top:160px;"><i class="upload icon"></i>导出 </button>
		<button id="depExport" class="ui blue small button" style="position:absolute;right:0;top:160px;"><i class="upload icon"></i>导出 </button>
		 
		<button id="backBtn" style="position:absolute;top:160px; right:110px;" class="ui small blue button"><i class="arrow left icon"></i> 返回 </button>
		<div id="allInfo">
			<!--  --> 
				<table class="ui blue compact striped  celled table"> 
				  <thead class="center aligned "> 
				    <tr>
				      <th>部门</th>  
				      <th>应考勤教师人数</th>
				      <th>实际考勤教师数</th>
				      <th>考勤总次数</th>
				      <th>详情</th>
				    </tr> 
				  </thead>  
				  <tbody class="center aligned"> 
				   
				  </tbody>
				</table>
			<!--  -->
		</div>
		<div id="depInfo">
			<!--  -->
				<table class="ui blue compact striped  celled table"> 
				  <thead class="center aligned "> 
				    <tr>
				      <th>教工号</th>  
				      <th>教师姓名</th>
				      <th>考勤总次数</th>
				      <th>讲授课考勤次数</th>
				      <th>实训课考勤次数</th>
				      <th>操作</th>
				    </tr> 
				  </thead>  
				  <tbody class="center aligned"> 
				   
				  </tbody>
				</table>
			<!--  -->
		</div>
		
		

		<!--  -->
		<div id="teaDetail" class="ui long modal">
		 
		  <div class="header">
			  教师考勤信息
		     <i class="close icon" style="float:right;cursor:pointer;"></i>
		  </div>
		  <div class=" content" style = "min-height:200px;">
		  	<div id = "courseRecordSelect" class="ui fluid small selection dropdown" > 
					<i class="dropdown icon"></i> <span class="default text">请先选择课程</span>
					<div class="menu"></div> 
			</div>  
			
			<!--  -->
				<table class="ui compact striped  celled table"> 
				  <thead class="center aligned "> 
				    <tr>
				      <th>周次</th>  
				      <th class="sxTD">节次</th>
				      <th>旷课</th>
				      <th>早退</th>
				      <th>迟到</th>
				      <th>请假</th>
				      <th>出勤率</th>
				    </tr> 
				  </thead>  
				  <tbody class="center aligned"> 
				   
				  </tbody>
				</table>
			<!--  -->
		  </div>
		  
		</div>

	</div> 
	<!--这里绘制页面-->
</body> 
<script>  
	$(function(){

		var schoolFlag = VERSIONTYPE;  
		var SYSOBJCET=<%=SYSOBJCET%>;  
		var USEROBJECT=<%=USEROBJECT%>;  
		var term_no=SYSOBJCET.term_no; 
		var tea_no=USEROBJECT.loginname;      
		var userpurview =USEROBJECT.userpurview;
		var depNo = null;
		var currentweek = SYSOBJCET.currentweek;
		var choosedweek=currentweek;
		loadterm();
		loadweek();
		function loadweek() {
			var currentIntWeek = parseInt(currentweek);
			var dom = "";
			for (var i = currentIntWeek ; i >= 1 ; i-- ) {
					var dom_term = '</option>'+'<option class="item"  selecter="selected" value="' + i + '">' +"第"+ i+"周"+ '</option>';
					$('#menu_week').append($(dom_term));
			}
		}
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
								var dom_term = '<option   selecter="selected" value="' + term_table[i].term_no + '">' + term_table[i].term_name + '</option>';
								$('#menu_term').append($(dom_term));
							} else {
								var dom_term = '<option value="' + term_table[i].term_no + '" >' + term_table[i].term_name + '</option>';
								$('#menu_term').append($(dom_term));
							}
						}
						/*$("#menu_term").dropdown({
							onChange: function(value, text) {
								term_no = value;
								if(userpurview != 'ALL'){
									$('#backBtn').remove();
									getDepDetail(userpurview);
								}else{
									getALLInfo(); 
								}
							}
						});*/
					}
				}
			});
		}

		$("#menu_term").dropdown({
			onChange: function(value, text) {
				term_no = value;
                if(term_no!=SYSOBJCET.term_no){
                    $('#menu_week').empty();
                    var dom = "";
                    for (var i = 1 ; i <= 22 ; i++ ) {
                        var dom_term = '<option   selecter="selected" value="' + i + '">' +"第"+ i+"周"+ '</option>';
                        $('#menu_week').append($(dom_term));
                    }
                }else {
                    $('#menu_week').empty();
                    loadweek();
                    $('#menu_week').val("1")
                }
				if(userpurview != 'ALL'){
					$('#backBtn').remove();
					getDepDetail(userpurview);
				}else{
					getALLInfo();
				}
			}
		});
		$("#menu_week").dropdown({
			onChange: function(value, text) {
				choosedweek = value;
				if(userpurview != 'ALL'){
					$('#backBtn').remove();
					getDepDetail(userpurview);
				}else{
					getALLInfo();
				}
			}
		});
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
		if(userpurview != 'ALL'){
			$('#backBtn').remove(); 
			getDepDetail(userpurview);
		}else{
			getALLInfo();
		}
		function getALLInfo(){
			//清空
			$('#mainExport').show();
			$('#depExport').hide();
			$('#allInfo tbody').empty();
			$('#allInfo').show(); 
			$('#depInfo').hide();
			$('#backBtn').hide();
			$.ajax({
				url : "do?invoke=BaseCheckRequest@getAllInfo", 
				type : 'POST', 
				dataType : 'json',
				data : {
					term_no:term_no,
					choosedweek:choosedweek,
					schoolFlag:schoolFlag
				}, 
				success : function(rep) {
					drawnAllInfo(rep.data);
				}
			});
		}
		function drawnAllInfo(info){
			if(info == null){
				return;
			}
			var dom = "";
			for(var i = 0 ; i < info.length ; i++){
				dom+='<tr>'+
					'<td>'+info[i].dep_name+'</td>'+
					'<td>'+(info[i].allamount == "" ? '0': info[i].allamount) +'</td>'+
					'<td>'+(info[i].amount == "" ? '0': info[i].amount)+'</td>'+  
					'<td>'+(info[i].checkamount == "" ? '0': info[i].checkamount) +'</td>'+ 
					'<td dep_no = "'+info[i].dep_no+'"><i class="detailBtn circular list layout  icon"></i></td>'+
					'</tr>';
			}
			$('#allInfo tbody').append($(dom));
			 detailClick(); 
		}
		function detailClick(){
			$('.detailBtn').unbind('click').click(function(){
				getDepDetail($(this).parent().attr('dep_no'));
			})   
		} 
		/* ------------------------------------------------------ */
		$('#mainExport').unbind('click').click(function(){
			var params = [];		
			
			params.push(term_no);
			params.push(choosedweek);
			console.log(params);
			var type = "excel";    
			if(schoolFlag == '1'){
				open(BASE_PATH+"/qm/base/export.jsp?export_id=23&params="+params+"&type="+type+"&more=1");	
			}else{
				open(BASE_PATH+"/qm/base/export.jsp?export_id=12&params="+params+"&type="+type+"&more=1");	
			}
				
		})
		function depExportClick(){
			$('#depExport').unbind('click').click(function(){ 
				var params = [];		
			
				params.push(term_no);
				params.push(depNo);
				params.push(choosedweek);
				params.push(","+term_no);
				params.push(choosedweek);
				var type = "excel";    
				if(schoolFlag == '1'){
					open(BASE_PATH+"/qm/base/export.jsp?export_id=24&params="+params+"&type="+type+"&more=2");	
				}else{
					open(BASE_PATH+"/qm/base/export.jsp?export_id=13&params="+params+"&type="+type+"&more=2");	
				}
					
			})
		}
	
		function teaExportClick(){
			$('.teaExport').unbind('click').click(function(){
				var teacherNo = $(this).parents('tr').find('td').eq(0).text();
				console.log(teacherNo)
				var params = [];		
				params.push(term_no); 
				params.push(teacherNo);
				params.push(choosedweek);
				var type = "excel";    
				open(BASE_PATH+"/qm/base/export.jsp?export_id=14&params="+params+"&type="+type+"&more=1");		
			})
		}
		/*-------------------------------  */
		function getDepDetail(dep_no){
			depNo = dep_no;
			//清空
			$('#mainExport').hide();
			$('#depExport').show();
			$('#depInfo tbody').empty(); 
			$('#allInfo').hide();  
			$('#depInfo').show();
			$('#backBtn').show();
			$.ajax({
				url : "do?invoke=BaseCheckRequest@getDepDetail", 
				type : 'POST',
				dataType : 'json',
				data : {
					term_no:term_no,
					choosedweek:choosedweek,
					dep_no:dep_no,
					schoolFlag:schoolFlag
				}, 
				success : function(rep) {
					console.log(rep)
					drawnDepDetail(rep.data );
				}
			});
			depExportClick();
		}
		function drawnDepDetail(info ){ 
			if(info == null){
				return; 
			}
			if(info.length ==0){
				var dom='<tr class="negative">'+
				'<td colspan="6">暂无考勤数据</td>'+
				'</tr>';
				$('#depInfo tbody').append($(dom));  
				return;
			} 
			var dom = "";
			for(var i = 0 ; i < info.length ; i++){
				dom+='<tr>'+ 
					'<td>'+info[i].teacher_no+'</td>'+
					'<td>'+info[i].teacher_name +'</td>'+
					'<td>'+(info[i].totalamount == "" ? '0': info[i].totalamount)+'</td>'+  
					'<td>'+(info[i].jsamount == "" ? '0': info[i].jsamount) +'</td>'+  
					'<td>'+(info[i].sxamount == "" ? '0': info[i].sxamount) +'</td>'+ 
					'<td teacher_no = "'+info[i].teacher_no+'"><i data-content="详情" data-variation="mini" class="teaDetailBtn circular list layout  icon"></i><i data-content="导出" data-variation="mini" class="teaExport circular upload  icon"></i></td>'+
					'</tr>';
			}  
			$('#depInfo tbody').append($(dom));  
			$('.teaDetailBtn , .teaExport').popup({
				  position : 'bottom center',
			}); 
			teaDetailClick();  
			teaExportClick();
		}
		function teaDetailClick(){
			$('.teaDetailBtn').unbind('click').click(function(){
				getTeaDetail($(this).parent().attr('teacher_no'));
			})   
		} 
		function getTeaDetail(teacher_no){
			//请空menu
			$('#courseRecordSelect .menu').empty();
			$('#teaDetail').modal('show');    
			$('#teaDetail').modal('refresh'); 
			$.ajax({
				url : "do?invoke=BaseCheckRequest@getTeaDetail", 
				type : 'POST',
				dataType : 'json',
				data : {
					term_no:term_no,
					teacher_no:teacher_no
				}, 
				success : function(rep) {
					console.log(rep)
					drawnTeaDetail(rep.data);
				}
			});
		}
		function drawnTeaDetail(courseInfo){
			if(courseInfo == null){
				return; 
			}
			var dom = '';
			for(var i = 0 ; i < courseInfo.length ; i ++){
				if(courseInfo[i].course_type == '实训课'){
					dom+='<div sche_no = "'+courseInfo[i].sche_no+'" class="item classinf">'+(i+1)+'、'+courseInfo[i].course_name + '——'+courseInfo[i].course_type+'——'+courseInfo[i].class_name +'</div>';
				}else{
				    if(!SINGLESCHE){
						dom+='<div sche_no = "'+courseInfo[i].sche_no+'"  class="item classinf">'+(i+1)+'、'+courseInfo[i].course_name + '——'+courseInfo[i].course_type+'——'+courseInfo[i].class_name +'——'+weekArray[courseInfo[i].sche_set.substring(1,2)]+'/'+setArray[courseInfo[i].sche_set.substring(2,3)]+'</div>';
                    }else{
                        dom+='<div sche_no = "'+courseInfo[i].sche_no+'"  class="item classinf">'+(i+1)+'、'+courseInfo[i].course_name + '——'+courseInfo[i].course_type+'——'+courseInfo[i].class_name +'——'+weekArray[courseInfo[i].sche_set.substring(1,2)]+'/'+setArray2[courseInfo[i].sche_set.substring(2,3)]+'</div>';
					}
				}
			}  
			$('#courseRecordSelect .menu').append($(dom)); 
			checkRecordClick();
			$('#courseRecordSelect').dropdown();
			$('.classinf').eq(0).trigger('click'); 
			
		}  
		function checkRecordClick(){
			$('.classinf').unbind('click').click(function(){
				var sche_no = $(this).attr('sche_no');
				//清空biaoge
				$('#teaDetail tbody').empty();
				$.ajax({
					url : "do?invoke=BaseCheckRequest@getTeaDetailInfo", 
					type : 'POST',
					dataType : 'json',
					data : { 
						sche_no:sche_no,
					}, 
					success : function(rep) {
						console.log(rep)
						drawnTeaDetailInfo(rep.data); 
						    
					}
				});
			})
		}
		function drawnTeaDetailInfo(info){
			$('.sxTD').show();
			if(info == null){
				return;
			}
			if(info.length == 0){
				//空数据
				var dom='<tr class="negative">'+
				'<td colspan="7">暂无考勤数据</td>'+ 
				'</tr>';
				$('#teaDetail tbody').append($(dom));  
				return;
				
			}
			var dom = '';
			for(var i = 0 ; i < info.length ; i++){
				dom+='<tr>'+
				'<td>'+info[i].check_week+'</td>'+

				'<td class="sxTD">'+((!SINGLESCHE)?(weekArray[info[i].check_sx.substring(1,2)]+'/'+setArray[info[i].check_sx.substring(2,3)])
                            :(weekArray[info[i].check_sx.substring(1,2)]+'/'+setArray2[info[i].check_sx.substring(2,3)])
                    ) +'</td>'+
				'<td>'+(info[i].check_kk == "" ? '0': info[i].check_kk)+'</td>'+  
				'<td>'+(info[i].check_zt == "" ? '0': info[i].check_zt) +'</td>'+  
				'<td>'+(info[i].check_cd == "" ? '0': info[i].check_cd) +'</td>'+ 
				'<td>'+(info[i].check_qj == "" ? '0': info[i].check_qj) +'</td>'+ 
				'<td >'+parseInt(info[i].check_ratio == "" ? '0': info[i].check_ratio)+'</td>'+
				'</tr>'; 
			} 
			$('#teaDetail tbody').append($(dom));
			if(info[0].check_sx == "" || info[0].check_sx == null){
				$('.sxTD').hide();
			}
			$('#teaDetail').modal('refresh'); 
		}
		/*  */
		$('#backBtn').unbind('click').click(function(){
			getALLInfo(); 
		})
	});//JQ
	//--------------------------

</script>
<!--这里引用其他JS-->
</html>