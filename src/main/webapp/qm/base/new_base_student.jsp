<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>
<%@ include file="/commonjsp/jgxgridtable.jsp"%>
<script src="script/common/datepicker/jquery.datetimepicker.js"
	type="text/javascript"></script>
<link rel="stylesheet"
	href="script/common/datepicker/jquery.datetimepicker.css" />
	<script src="script/common/uploadify/swfobject.js"
	type="text/javascript"></script>

<script src="script/common/uploadify/jquery.uploadify.min.js"
	type="text/javascript"></script>
<script src="qm/js/baseClasses.js" type="text/javascript"></script>
<script src="qm/js/frontPage.js" type="text/javascript"></script>
<!--这里引用其他样式-->
<title>校内教学质量监控运行平台</title>
<style>
	#accordion{
	max-width:20%!important;
	min-width:10%;
	float:left;
	}
	.mkid{
	max-width:90%;
	}
	.addordelete{
	text-align:center;
	}
	.fontclass{
	font-size:13.4px!important;
	}
	.negative{
	font-size:14px;
	}
	.addordelete{
	padding-bottom: 10px!important;
	padding-left: 15px!important;
	padding-right: 15px!important;
	padding-top: 10px!important;
	}
	.display{
	 color:black;
	 pointer-events:none;
	color:#afafaf;
	cursor:default
	}
	#leftDiv{
	width:70%;
	float:left;
	}
	.selectButton{
	margin-top:4px!important;
	}
	.file {
    position: relative;
    display: inline-block;
    background: #1B1C1D;
    border-radius: 4px; 
    overflow: hidden;
    color: white;
    text-decoration: none;
    text-indent: 0;
    font-size: .92857143rem;
    font-weight:700;
    width:50%;
    text-align:center;
    height:15%;
    padding: 0.3em;
    margin-top:5px;
	}
	.file input {
	    position: absolute;
	    font-size: 100px;
	    right: 0;
	    top: 0;
	    opacity: 0;
	    color: white;
	}
	.file:hover {
	    background: #27292A;
	    /* border-color: #27292A; */
	     color: white;
	    text-decoration: none;
	}
	.one.field{
		margin-left:5%!important;
	}
	.second.field{
		margin-left:-5%!important;
	}
	.dropdownImport{
		max-width:80%!important;
	}
	#leftDiv{
	width:79%;
	float:right;
	}
	 #tablehead{
	display:none;
	} 
	#message{
	margin-top:8%!important;
	}
	#tablehead table{
	margin-top:8%!important;
	}
	#tablehead table td{
	padding:0px!important
	overflow: hidden;
	 text-overflow: ellipsis;
	 white-space: nowrap;
	    text-align: center;
	}
	.ui[class*="very compact"].table td {
    padding: 3px!important;
	}
	#tablehead{
	margin-top:5%;
	}
	.get_termyear_select{
	min-width:auto!important;
	}
	#search_like_data{
	max-width:90%!important;
	margin-left:10%;
	}
	.termaccordion{
	margin-top:0px!important;
	}
	.ui.mini.addmajor.selection.dropdown{
	min-width:100%!important;
	}
	 @media only screen and (max-width: 1200px) {
		 #message,#tablehead{
		 margin-top:18%!important;
		 }

		}
	.copySpan{
	    color:rgba(255,0,0,1);
	    cursor: pointer;
	}
	.copySpan:hover{
	 	color:rgba(255,0,0,0.7);
	}
</style>
</head>
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	<%
		//接收参数
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String dep_no = "";
		String class_year = "";
		String  class_Tno = "";
		String term_noacceptance = "";
		if(request.getParameter("term_no")!=null){
			term_noacceptance = request.getParameter("term_no");
		}
		if (request.getParameter("class_Tno") != null ) {
			class_Tno = (String) request.getParameter("class_Tno");
		} 
		if (request.getParameter("term_no") != null ) {
			class_year = (String) request.getParameter("term_no");
		} 
		if (request.getParameter("dep_no") != null ) {
			dep_no = (String) request.getParameter("dep_no");
		} 
	%>
	<!--这里绘制页面-->
	<div id="container">
	<h3  class="ui header "> 
	  	<i class="tasks icon"></i>
	  	学生管理 
	</h3>
	<div class="ui styled accordion" id="accordion">
	</div>
	<div class="fields" id="leftDiv">
	<div class="field"   style="float: left;">
							<select class="ui mini get_termyear_select" 
								id="get_termyear_select">
							</select>
						</div> 
	       <div class="field search_like_data" style="float: left">
				<div class="ui small input circulari  basic icon search_like_data "
					data-content="输入学生姓名、学号">
					<input id="search_like_data" type="text" placeholder="搜索学生">
				</div>
			</div>
			<div class="field"  style="float: left;"> 
				<div class="ui  circulari olive icon button" id="searchbutton">
					<i class="search icon"></i>搜索
				</div>
			</div>
			<div class="field" style="float: left!important">
				<div class="ui input circulari  basic icon "
					data-content="新增学生" >
					<div class="ui small teal  button addAward" id="addNewStudent">
						<i class="add user icon"></i> 新增
					</div>
				</div>
			</div>
			<div class="field" style="float: left!important">
				<div class="ui input circulari  basic icon "
					data-content="导入当年学年学期的学生" >
					<div class="ui small teal  button addAward" id="importBtn">
						<i class="paw icon"></i> 导入
					</div>
				</div>
			</div>
			
			<div class="field" style="float: left!important">
				<div class="ui input circulari  basic icon "
					data-content="导出当前班级学生" >
					<div class="ui small teal  button addAward" id="exportBTN">
						<i class="paw icon"></i> 导出
					</div>
				</div>
			</div>
			<div class="ui green large message" id="message">
					<i class="pointing left large inverted yellow circular icon"></i> 点击对应班级，显示相关信息
			</div>
		  <div class="ui  large  loader" id="loading">
		  <div class="ui indeterminate text loader">数据传输中。。。</div>
		</div>
		<div id="tablehead">
			<table class="ui celled center very compact blue striped table">
			<thead>
				<tr class="center aligned">
					<th>学号</th>
					<th>姓名</th>
					<th>手机号</th>
					<th>专业</th>
					<th>年级</th>
					<th>班级</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody id="tablepane">
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
		</div>
		 <div class="ui modal" id="importExcelModal">
			<i class="close icon"></i>
			<div class="header" id="statusExcelTitle">导入学生数据</div>
			<div class="content">
				<form class="ui form addBaseTeamForm" id="addBaseTeamForm">
					<div class="three fields">
						<div id="divTermNo" class="field">
							<label class="ui pointing">学年学期编号</label> <select
								class="ui mini dropdownImport" id="dropdownImport">
							</select>
						</div>
						<div class="one field">
							<label>导入新生数据</label>
							 <a href="javascript:;" class="file"><!-- 选择文件 -->
								<input  type="file" name="stuuploadify" id="stuuploadify" />
							</a> 

						</div>
						<div class="second field">
							<label>模板下载</label> 
							<a class="selectButton ui red small labeled icon add button"href="template/student.xls"><i class="download icon"></i>导入学生模板</a>
						</div>

					</div>
					
				</form>
			</div>
			<div class="actions">
				<div class="ui black deny button" id="termCancelModal">取消</div>
				<div class="ui red right labeled icon button"
					id="excelImportSaveModal">
					导入 <i class="checkmark icon"></i>
				</div>
			</div>
		</div> 
		<div class="ui modal" id="newBaseTermModal">
			<i class="close icon"></i>
			<div class="header" id="statustitle">新增学生</div>
			<div class="content">
				<form class="ui form addBaseStuForm" id="addBaseStuForm">
					<div class="four fields">
					<div id="divAddStuClass" class="field required">
								<label class=" ui pointing  ">班级</label> 
							<input id="addClass"   placeholder="班级名称" name="add_stuclass"
								type="text"  />
						</div>
						<div id="divAddStuNo" class="field required">
							<label>学号</label> <input placeholder="请输入学号" name="add_stuno"
								type="text" id="addstuno" />
						</div>
						<div id="divAddStuName" class="field required">
							<label>姓名</label> <input placeholder="请输入姓名" name="add_stuname"
								type="text" id="addstuname" />
						</div>
						<div id="divAddStuBir" class="field">
							<label>生日</label> <input placeholder="请输入生日" name="add_stubir"
								type="text" id="addstubir" />
						</div>
					</div>
					<div class="four fields">
						<div id="divAddStuPhone" class="field ">
							<label>手机号码</label> <input placeholder="请输入手机号码"
								name="add_stuphone" type="text" id="addstuphone" />
						</div>
						<div id="divAddStuMajor" class="field required ">
							<label class="ui pointing  ">所属专业</label>
							<input placeholder="所属专业" name="add_stuyear"  type="text" id="addmajor" />
						</div>

						<div class="field required" id="divAddStuYear">
							<label>入学年份</label>
                            <select class="ui mini  myselect" id="addstuyear">
                            </select>
                            <%--<input placeholder="入学年份" name="add_stuyear"  type="text" id="addstuyear" />--%>
						</div>
						<div id="divAddStuUse" class="field required">
								<label class="ui pointing  ">是否启用</label> <select
								class="myselect ui mini ifuse" id="ifUse">
								 <option value="1">正常</option>
 								 <option value="0">停用</option>
							</select>
						</div>
					</div>
					<div id="newusererror" class="ui error message">
						<div class="header">错误提示</div>
						<p></p>
					</div>
				</form>
			</div>
			<div class="actions">
				<div class="ui black deny button" id="termCancelModal">取消</div>
				<div class="ui red right labeled icon button" id="stuSaveModal">
					保存 <i class="checkmark icon"></i>
				</div>
			</div>
		</div>
		<div class="ui modal" id="newBaseTermModal1">
			<i class="close icon"></i>
			<div class="header" >编辑学生</div>
			<div class="content">
				<form class="ui form addBaseStuForm" id="addBaseStuForm1">
					<div class="three fields">
						<div id="divAddStuNo1" class="field required">
							<label>学号</label> <input placeholder="请输入学号" name="add_stuno"
								type="text" id="addstuno1" />
						</div>
						<div id="divAddStuName1" class="field required">
							<label>姓名</label> <input placeholder="请输入姓名" name="add_stuname"
								type="text" id="addstuname1" />
						</div>
						<div id="divAddStuBir1" class="field ">
							<label>生日</label> <input placeholder="请输入生日" name="add_stubir"
								type="text" id="addstubir1" />
						</div>
					</div>
					<div class="three fields">
						<div id="divAddStuPhone1" class="field ">
							<label>手机号码</label> <input placeholder="请输入手机号码"
								name="add_stuphone" type="text" id="addstuphone1" />
						</div>
						<div id="divAddStuMajor1" class="field required ">
							<label class="ui pointing  ">所属班级</label>
							<div class="deleteitem"> <select
								class="ui mini addmajor"  id="addmajor1">
							</select>
							</div>
						</div>

						<div class="field required" id="divAddStuYear1">
							<label>入学年份</label> <input placeholder="入学年份"
								name="add_stuyear" type="text" id="addstuyear1" />
						</div>
					</div>
					<div id="newusererror" class="ui error message">
						<div class="header">错误提示</div>
						<p></p>
					</div>
				</form>
			</div>
			<div class="actions">
				<div class="ui black deny button" id="termCancelModal1">取消</div>
				<div class="ui red right labeled icon button" id="stuSaveModal1">
					保存 <i class="checkmark icon"></i>
				</div>
			</div>
		</div>
	</div> 
</body>
<script type="text/javascript">
	$(function(){
		var class_year = "<%=class_year%>";
		var dep_no="<%=dep_no%>";
		var class_Tno="<%=class_Tno%>";
		var studentFilePath = "";
		var temp_term_no = "";
		var pageindex = 1;
		var pagelength = 10;
		var totaltemp = 1;
		var totalpage =0;
		var stu_name=""; 
		var class_Tname="";
		var term_no=SYSOBJECT.term_no;
		var temppage = 1;
		var term_noacceptance = "";
        var stu_year_no="";
		term_noacceptance = '<%=term_noacceptance%>'
		if((class_year=="" || class_year==null) || (dep_no==null || dep_no=="") || (class_Tno==null || class_Tno=="")){
			
		}else{
			loadtable(class_year,dep_no,stu_name);
		}
		$('.search_like_data').width($('#search_like_data').width())
		$('.ui.input.circulari.basic.icon').popup();
		/* $('.myselect').dropdown(); */
		//点击生日弹出日期选择
		$('#addstubir').datetimepicker({
		lang : 'ch',
		format : 'Y-m-d',
		formatDate : 'Y-m-d',
		 onShow:function( ct ){
			   this.setOptions({
			    maxDate:0,
			   })
		},
		timepicker : false
	});
		$('#exportBTN').unbind('click').click(function(){
			if(class_Tno=="" || class_Tno==null){
				$.alert('请先选择导出班级')
				return;
			}
			var params = [];
			params.push(term_no);
			params.push(class_year);
			params.push(dep_no);
			params.push(class_Tno);
			var type = "excel";
			open(BASE_PATH+"/qm/base/export.jsp?export_id=4&params="+params+"&type="+type+"&more=1");
		})
		loadterm();
		//读取所有的学期信息放入下拉框
	    function loadterm(){
	    	$.ajax({
				url:"do?invoke=ManageTeacher@gettermnoinformation",
				type:'POST',
				dataType:'json',
				success:function(rep){
					if(rep.result==0){
					$.alert("",rep.message);
					return;
					}
					else{
						var temp=rep.data
						for(var i=0;i<temp.length;i++){
							var dom= ' <option value="'+temp[i].term_no+'">'+temp[i].term_name+'</option>';
							$("#get_termyear_select").append(dom)
						}
						$('#get_termyear_select').dropdown();
						term_no=$("#get_termyear_select").val();
						changeitem(term_no)
					}
					$("#get_termyear_select").change(function(){
						term_no=$("#get_termyear_select").val();
						changeitem(term_no)
					});
				}
	    	});
	    }
		//读取所有的学期信息放入下拉框
		function loadImportterm() {
			$.ajax({
				url : "do?invoke=ManageTeacher@gettermnoinformation",
				type : 'POST',
				dataType : 'json',
				success : function(rep) {
					if (rep.result == 0) {
						$.alert("", rep.message);
						return;
					} else {
						var temp = rep.data
						for (var i = 0; i < temp.length; i++) {
							var dom = ' <option value="'+temp[i].term_no+'">'
									+ temp[i].term_name + '</option>';
							$("#dropdownImport").append(dom)
						}

						$('.ui.dropdownImport').dropdown();
					}
					temp_term_no = $("#dropdownImport").val();
					 $("#dropdownImport").change(
							function() {
								var term_no = $("#dropdownImport").val();
								var term_name = $("#dropdownImport").find(
										"option:selected").text();
								temp_term_no = term_no;
							});
				} 
			});
		}
		changedep();
		//读取部门信息
	    function changedep(){
	    	$.ajax({
				url : "do?invoke=baseStudentAction@getdepartmentInfo",
				type : 'POST',
				dataType : 'json',
				success : function(rep) {
					if(rep.reesult==0){
						$.alert(rep.message);
					}else{
						var department=rep.data;
						for(var i =0;i<department.length;i++){
							var dom='<div class="title fontclass deptitle" dep_no = "'+department[i].dep_no+'"><i class="dropdown icon"></i>'+department[i].dep_name+'</div>'+
			      			  '<div class="depcontent content" dep_no = "'+department[i].dep_no+'">'+
			      			    '<div class=" ui  menu navigation" id="menu'+department[i].dep_no+'" >'+
			      		        '</div>'+
			      			   '</div>';
			      			   $('#accordion').append(dom)
						}
						$('.deptitle').unbind('click').click(function(){
							setTimeout(function(){
							getclass();
							},500)
						})
					}
					 if(term_noacceptance==""||term_noacceptance==null){
					    }else{
					    	showmodel();
					    }
				}
	    	});
		}
		//拉取班级信息
		function getclass(){
			var itemdep=$('.depcontent.active').attr('dep_no');
			var item=$('.depcontent.active').children('.navigation').children('.termaccordion').find('.termtitle'); 
			var itemterm=[];
			for(var i=0;i<item.length;i++){
				itemterm.push($(item[i]).attr('term_no'))
			}
			if(itemterm==""||itemterm==null){
				return;
			}else{
				var temp=itemterm.join(',');
				$.ajax({
					url : "do?invoke=baseStudentAction@getclassInfo",
					type : 'POST',
					dataType : 'json',
					data:{
						temp:temp,
						dep_no:itemdep,
					},
					success : function(rep) {
						if(rep.result==0){
							$.alert(rep.message)
							return;
						}else{
							$('.addordelete').remove();
							var tempclass=rep.data;
							for(var k = 0;k<tempclass.length;k++){
								var dom1='<a class="addordelete  ui olive item" class_no="' + tempclass[k].class_no+ '" class_name="' + tempclass[k].class_name+'">'+
			        			'<label class="removeicon ui negative" >' + tempclass[k].class_name+'</label>' +
								'</a>';
							     $($('.depcontent.active').children('.navigation').children('.termaccordion').children('.termcontent[term_no="'+tempclass[k].term_no+'"]').find('.termmkid')).append(dom1)
							}
							 bindClick();
						}
					}
				});
			}
		}
		//读取导航信息
	    function changeitem(){
	    	$.ajax({
				url : "do?invoke=baseStudentAction@loadNavigationInfo",
				type : 'POST',
				dataType : 'json',
				data:{
					term_no:term_no,
				},
				success : function(rep) {
				    $('.navigation').html(''); 
					if (rep.result == 0 ) {
						$.alert(rep.message);
					} else {
						 var class_year = rep.data;
							dom='<div class="ui styled accordion termaccordion" >';
						for(var i = 0;i<class_year.length;i++){
							 dom+='<div class="title fontclass termtitle" term_no = "'+class_year[i].term_no+'"><i class="dropdown icon"></i>'+class_year[i].term_no+'学年</div>'+
			      			  '<div class="termcontent content" term_no = "'+class_year[i].term_no+'">'+
			      			    '<div class="mkid ui vertical menu termmkid"term_no= "'+class_year[i].term_no+'">'+
			      		        '</div>'+
			      			   '</div>';
						}
							dom+='</div>';
							$('.navigation').prepend(dom)
							getclass();
					}
					$('#accordion').accordion({
	        			  exclusive:true,
	        			  onOpening:function(){
	        				  removeclass();
	        			  },
	        			  onClosing:function(){
	        				  removeclass();
	        			  }
	        		 })
				}
	    	});
		}
	    //学年按钮绑定点击事件
	    function bindClick(){
	    	 $('.addordelete').unbind('click').click(function(){
				$('.addordelete').removeClass('active');
				 $('.addordelete').unbind('click'); 
				$(this).addClass('active');
				class_Tno=$(this).attr('class_no');
				class_Tname=$(this).attr('class_name')
				class_year = $(this).parent().parent().attr('term_no');
				dep_no = $(this).parent().parent().parent().parent().parent().attr('dep_no');
				stu_name="";
				pageindex = 1;
				totaltemp = 1;
				$('#search_like_data').val('');
				loadtable(class_year,dep_no,stu_name);
			 	setTimeout(function(){
					bindClick();
				},1000) 
	    	 });
	    }
	    
	    //点击复制数据时事件
	    function copyData(){
	    	$('.copySpan').unbind('click').click(function(){
	    		$('.copySpan').unbind('click');
	    		$.ajax({
					url : "do?invoke=baseStudentAction@copyDataInfo",
					type : 'POST',
					dataType : 'json',
					data:{
						class_year:class_year,
						term_no:term_no,
						dep_no:dep_no,
						class_no:class_Tno,
					},
					success : function(rep) {
						if(rep.result==0){
							$.alert('复制失败')
						}else{
							$.alert('复制成功')
							loadtable(class_year,dep_no)
						}
					}
	    		});
	    		setTimeout(copyData,1000);
	    	})
	    }
	    //根据学年和部门拿到部门班级
	    function loadtable(class_year,dep_no){
	    	$("#spanFirst").attr("temp",'0');
			$("#spanNext").attr("temp",'0');
			$("#spanPre").attr("temp",'0');
			$("#spanLast").attr("temp",'0');
	    	$('#tablehead').hide();
	    	$('#message').hide();
	    	$('#loading').toggleClass('active')
	    	if((class_year==null||class_year=="")||(dep_no==null||dep_no=="")){
	    		/*$.alert("部门或学年错误")
	    		return;*/
				console.log(stu_name)
				$.ajax({
					url : "do?invoke=baseStudentAction@searchBaseStudentListByNameOrNum",
					type : 'POST',
					dataType : 'json',
					data:{
						pageindex:pageindex,
						pagelength :pagelength,
						search_like_data:stu_name,
						temppage:temppage,
					},
					success : function(rep) {
						console.log(rep.rows);
						if(rep.length==0){
							$("#message").html("");
							if(rep.info.message=='数据为空'){
								if(stu_name==""){
									$("#message").html('数据为空，点击<span class="copySpan">复制</span>数据');
								}else{
									$("#message").html('数据为空');
								}
								copyData();
							}else{
								$("#message").text(rep.info.message);
							}
							$('#loading').toggleClass('active')
							$("#message").show();
						}else{
							$('#tablepane').html('');
							$("#message").hide();
							var item = rep.rows;
							for(var i=0;i<item.length;i++){
								var dom = '<tr><td>'+item[i].stu_no+'</td>'+
										'<td>'+item[i].stu_name+'</td>'+
										'<td>'+item[i].stu_phone+'</td>'+
										'<td>'+item[i].major_name+'</td>'+
										'<td>'+item[i].stu_year+'</td>'+
										'<td>'+item[i].class_name+'</td>';
								if(item[i].stu_status==2){
									dom+='<td class="sign" stu_no="'+item[i].stu_no+'">已毕业</td>';
								}else if(item[i].stu_status==1){
									dom+='<td class="sign" stu_no="'+item[i].stu_no+'">正常</td>';
								}else{
									dom+='<td class="sign error" stu_no="'+item[i].stu_no+'">停用</td>';
								}
								dom+='<td><div class="deleteT btnfirst circular ui small blue basic icon button" temp="'+item[i].stu_name+'" stu_no="'+item[i].stu_no+'" stu_birthday="'+item[i].stu_birthday+'" class_no="'+item[i].class_no+'" stu_phone="'+item[i].stu_phone+'" major_no="'+item[i].major_no+'" major_name="'+item[i].major_name+'" stu_year="'+item[i].stu_year+'" stu_status="'+item[i].stu_status+'" data-content="删除该学生,不可恢复"><i class="delete icon"></i></div>';
								dom+='<div class="editT btnfirst circular ui small blue basic icon button" temp="'+item[i].stu_name+'" stu_no="'+item[i].stu_no+'" stu_birthday="'+item[i].stu_birthday+'" class_no="'+item[i].class_no+'" stu_phone="'+item[i].stu_phone+'" major_no="'+item[i].major_no+'" major_name="'+item[i].major_name+'" stu_year="'+item[i].stu_year+'" stu_status="'+item[i].stu_status+'" data-content="编辑该学生"><i class="edit icon"></i></div>';
								if(item[i].stu_status==1){
									dom+='<div style="margin-left:5px; margin-top:5px;" class="remove btnfirst circular ui small blue basic icon button" stu_no="'+item[i].stu_no+'" stu_name="'+item[i].stu_name+'" stu_status="'+item[i].stu_status+'" data-content="点击停用此学生"><i class="lock icon"></i></div></td>';
								}else{
									dom+='<div style="margin-left:5px; margin-top:5px;" class="remove btnfirst circular ui small blue basic icon button" stu_no="'+item[i].stu_no+'" stu_name="'+item[i].stu_name+'" stu_status="'+item[i].stu_status+'" data-content="点击启用此学生"><i class="unlock alternate icon"></i></div></td>';
								}
								dom+='</tr>';
								$('#tablepane').append(dom)
							}
							$('.editT').popup();
							$('.deleteT').popup();
							$('.editT').unbind('click').click(function(){
								var stu_no = $(this).attr('stu_no');
								var stu_name = $(this).attr('temp');
								var stu_birthday = $(this).attr('stu_birthday');
								var stu_phone = $(this).attr('stu_phone');
								var major_no = $(this).attr('major_no');
								var major_name = $(this).attr('major_name');
								var stu_year = $(this).attr('stu_year');
								var class_no = $(this).attr('class_no');
								var stu_status = $(this).attr('stu_status');
								editStuTableRow(stu_no, stu_name, stu_birthday,
										stu_phone, major_no, major_name, stu_year, stu_status,class_no);
							})
							$('.deleteT').unbind('click').click(function(){
								var stu_no = $(this).attr('stu_no');
								deleteStudent(stu_no);
							})
							if(totaltemp==1){
								var count=0;
								if(((rep.total)%pagelength)!=0)count=1;
								totalpage=parseInt(rep.total/pagelength) +count;
								$("#spanLast").attr("page",totalpage);
								$('#spanPageNum').text(pageindex);
								$("#spanTotalPage").text(totalpage)
								totaltemp++;
							}
							$('#loading').toggleClass('active')
							$('#tablehead').show();
							$('.remove').unbind('click').click(function(){
								var stu_no = $(this).attr("stu_no");
								var item = $('.sign[stu_no='+stu_no+']');
								var stu_name = $(this).attr("stu_name");
								var stu_status = $(this).attr("stu_status");
								var thisItem = $(this)
								var itemI=$(this).find('i')
								removeStuTableRow(item,stu_no,stu_name,stu_status,thisItem,itemI);
							})
						}
						new page().changepage(pageindex,pagelength,totaltemp,totalpage);
						$("#spanFirst").unbind('click').bind("click",function(){
							if(pageindex==1)return;
							if(totalpage>1)
								if($(this).attr('temp')==1)
								{
									pageindex=1;
									searchtable();
								}
								else
								{
									pageindex=1;
									loadtable(class_year,dep_no,stu_name);
								}
						});
						$("#spanLast").unbind('click').bind("click",function(){
							if(pageindex==totalpage)return;
							if(totalpage>1){
								if($(this).attr('temp')==1)
								{
									pageindex=totalpage;
									searchtable();
								}
								else
								{
									pageindex=totalpage;
									loadtable(class_year,dep_no,stu_name);
								}
							}
						});
						$("#spanNext").unbind('click').bind("click",function(){
							if(pageindex==totalpage)return;
							if(totalpage>1){
								if($(this).attr('temp')==1)
								{
									pageindex++;
									searchtable();
								}
								else
								{
									pageindex++;
									loadtable(class_year,dep_no,stu_name);
								}
							}
						});
						$("#spanPre").unbind('click').bind("click",function(){
							if(pageindex==1)return;
							if(totalpage>1){
								if($(this).attr('temp')==1)
								{
									pageindex--;
									searchtable();
								}
								else
								{
									pageindex--;
									loadtable(class_year,dep_no,stu_name);
								}
							}
						});
					}
				});
			}else{
	    		console.log(stu_name)
	    		$.ajax({
					url : "do?invoke=baseStudentAction@getTableInfo",
					type : 'POST',
					dataType : 'json',
					data:{
						class_year:class_year,
						term_no:term_no,
						dep_no:dep_no,
						pageindex:pageindex,
						pagelength :pagelength,
						stu_name:stu_name,
						totaltemp:totaltemp,
						class_no:class_Tno,
					},
					success : function(rep) {
						if(rep.info.result==0){
							$("#message").html("");
							if(rep.info.message=='数据为空'){
								if(stu_name==""){
									$("#message").html('数据为空，点击<span class="copySpan">复制</span>数据');
								}else{
									$("#message").html('数据为空');
								}
								copyData();
							}else{
								$("#message").text(rep.info.message);
							}
							$('#loading').toggleClass('active')
							$("#message").show();
						}else{
							$('#tablepane').html('');
							$("#message").hide();
							var item = rep.info.data;
							for(var i=0;i<item.length;i++){
								var dom = '<tr><td>'+item[i].stu_no+'</td>'+
								'<td>'+item[i].stu_name+'</td>'+
								'<td>'+item[i].stu_phone+'</td>'+
								'<td>'+item[i].major_name+'</td>'+
								'<td>'+item[i].stu_year+'</td>'+
								'<td>'+item[i].class_name+'</td>';
								if(item[i].stu_status==2){
									dom+='<td class="sign" stu_no="'+item[i].stu_no+'">已毕业</td>';
								}else if(item[i].stu_status==1){
									dom+='<td class="sign" stu_no="'+item[i].stu_no+'">正常</td>';
								}else{
									dom+='<td class="sign error" stu_no="'+item[i].stu_no+'">停用</td>';
								}
								dom+='<td><div class="deleteT btnfirst circular ui small blue basic icon button" temp="'+item[i].stu_name+'" stu_no="'+item[i].stu_no+'" stu_birthday="'+item[i].stu_birthday+'" class_no="'+item[i].class_no+'" stu_phone="'+item[i].stu_phone+'" major_no="'+item[i].major_no+'" major_name="'+item[i].major_name+'" stu_year="'+item[i].stu_year+'" stu_status="'+item[i].stu_status+'" data-content="删除该学生,不可恢复"><i class="delete icon"></i></div>';
								dom+='<div class="editT btnfirst circular ui small blue basic icon button" temp="'+item[i].stu_name+'" stu_no="'+item[i].stu_no+'" stu_birthday="'+item[i].stu_birthday+'" class_no="'+item[i].class_no+'" stu_phone="'+item[i].stu_phone+'" major_no="'+item[i].major_no+'" major_name="'+item[i].major_name+'" stu_year="'+item[i].stu_year+'" stu_status="'+item[i].stu_status+'" data-content="点击编辑此学生"><i class="edit icon"></i></div>';
								if(item[i].stu_status==1){
									dom+='<div style="margin-left:5px; margin-top:5px;" class="remove btnfirst circular ui small blue basic icon button" stu_no="'+item[i].stu_no+'" stu_name="'+item[i].stu_name+'" stu_status="'+item[i].stu_status+'" data-content="点击停用此学生"><i class="lock icon"></i></div></td>';
								}else{
									dom+='<div style="margin-left:5px; margin-top:5px;" class="remove btnfirst circular ui small blue basic icon button" stu_no="'+item[i].stu_no+'" stu_name="'+item[i].stu_name+'" stu_status="'+item[i].stu_status+'" data-content="点击启用此学生"><i class="unlock alternate icon"></i></div></td>';
								}
								'</tr>';
								$('#tablepane').append(dom)
							}
							$('.editT').popup();
							$('.deleteT').popup();
							$('.editT').unbind('click').click(function(){
								var stu_no = $(this).attr('stu_no');
								var stu_name = $(this).attr('temp');
								var stu_birthday = $(this).attr('stu_birthday');
								var stu_phone = $(this).attr('stu_phone');
								var major_no = $(this).attr('major_no');
								var major_name = $(this).attr('major_name');
								var stu_year = $(this).attr('stu_year');
								var class_no = $(this).attr('class_no');
								var stu_status = $(this).attr('stu_status');
								editStuTableRow(stu_no, stu_name, stu_birthday,
										stu_phone, major_no, major_name, stu_year, stu_status,class_no);
							})
							$('.deleteT').unbind('click').click(function(){
								var stu_no = $(this).attr('stu_no');
								deleteStudent(stu_no);
							})
							if(totaltemp==1){
								var count=0;
								if(((rep.total)%pagelength)!=0)count=1;
							    totalpage=parseInt(rep.total/pagelength) +count;
								$("#spanLast").attr("page",totalpage);
								$('#spanPageNum').text(pageindex);
								$("#spanTotalPage").text(totalpage)
								totaltemp++;
							}
					    	 $('#loading').toggleClass('active') 
					    	$('#tablehead').show();
							$('.remove').unbind('click').click(function(){
								var stu_no = $(this).attr("stu_no");
								var item = $('.sign[stu_no='+stu_no+']');
								var stu_name = $(this).attr("stu_name");
								var stu_status = $(this).attr("stu_status");
								var thisItem = $(this)
								var itemI=$(this).find('i')
								removeStuTableRow(item,stu_no,stu_name,stu_status,thisItem,itemI);
							})
						}
					new page().changepage(pageindex,pagelength,totaltemp,totalpage);
					$("#spanFirst").unbind('click').bind("click",function(){
						if(pageindex==1)return;
						if(totalpage>1)
						if($(this).attr('temp')==1)
						{
						    pageindex=1;
						    searchtable();
						}
						else
						{
						pageindex=1;
						loadtable(class_year,dep_no,stu_name);
						}
					});
					$("#spanLast").unbind('click').bind("click",function(){
						if(pageindex==totalpage)return;
						if(totalpage>1){
						if($(this).attr('temp')==1)
						{
							pageindex=totalpage;
						    searchtable();
						}
						else
						{
						pageindex=totalpage;
						loadtable(class_year,dep_no,stu_name);
						}
						}
					});
						$("#spanNext").unbind('click').bind("click",function(){
							if(pageindex==totalpage)return;
							if(totalpage>1){
							if($(this).attr('temp')==1)
							{
								pageindex++;
							    searchtable();
							}
							else
							{
								pageindex++;
								loadtable(class_year,dep_no,stu_name);
							}
						}
						});
						$("#spanPre").unbind('click').bind("click",function(){
							if(pageindex==1)return;
							if(totalpage>1){
							if($(this).attr('temp')==1)
							{
								pageindex--;
							    searchtable();
							}
							else
							{
							pageindex--;
							loadtable(class_year,dep_no,stu_name);
							}
							}
						});
					}
	    		});
	    	}
	    }
	  //学生编辑信息
	    function editStuTableRow(stu_no, stu_name, stu_birthday, stu_phone,
	    		major_no, major_name, stu_year, stu_status,class_no) {
	    	$("#addstuno1").prop('disabled', true);
	    	$("#addstuname1").prop('disabled', true);
	    	$("#addstuyear1").prop('disabled', true);
	    	$("#addstuno1").val(stu_no);
	    	$("#addstuname1").val(stu_name);
	    	$("#addstubir1").val(stu_birthday);
	    	$("#addstuphone1").val(stu_phone);
	    	$("#addstuyear1").val(stu_year);
	    	loadingDropDownMajor(major_no,class_no);
	    	
	    }
	    //删除学生
		function deleteStudent(stu_no) {
			$.ajax({
				url : "do?invoke=baseStudentAction@deleteBaseStudent",
				type : 'POST',
				dataType : 'json',
				async: false,
				data:{
					stu_no:stu_no
				},
				success : function(rep) {
					$.alert(rep.message)
					stu_name =$('#search_like_data').val();
					setTimeout(function(){
						bindClick();
					},1000)
					loadtable(null,null,stu_name);
				}
			});
		}
	  //读取下拉框的专业值
	  function loadingDropDownMajor(major_no,class_no){
		  $.ajax({
				url : "do?invoke=baseStudentAction@getAllClass",
				type : 'POST',
				dataType : 'json',
				async: false,
				data:{
					class_year:class_year.substring(0,4),
					dep_no:dep_no
				},
				success : function(rep) {
					$(".deleteitem").html('');
					var dom = '<select class="ui mini addmajor" search  id="addmajor1">'+
					'</select>';
					$(".deleteitem").append(dom);
					
					if (rep.result == 0) {
						$.alert("", rep.message);
					} else {
						$("#addmajor").empty();
						var selectDep = rep.data;	
						for (var i = 0; i < selectDep.length; i++) {
							$("#addmajor1").append(
									'<option value="' + selectDep[i].class_no+ '" major_no="'+selectDep[i].major_no+'">' + selectDep[i].class_name+ '</option>');
						}
			           $("#addmajor1").find("option[value="+class_no+"]").attr("selected",true);
						$('.ui.addmajor').dropdown();
						showEditModal();
					}
				}
			});
	  }
		$("#stuSaveModal1").unbind('clck').click(function() {
			var tempPhone = $("#addstuphone1").val();
			//判断手机号码
			if(tempPhone !=  ''){
				if(!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(tempPhone))){ 
			        alert("不是正确的11位手机号");  
			        return; 
			    } 
			}
			$.ajax({
				url : "do?invoke=baseStudentAction@updateBaseStudent",
				type : 'POST',
				dataType : 'json',
				async: false,
				data : {
					stu_no : $("#addstuno1").val(),
					stu_name : $("#addstuname1").val(),
					stu_birthday : $("#addstubir1").val(),
					stu_phone : $("#addstuphone1").val(),
					major_no : $("#addmajor1  option:selected").attr('major_no'),
					class_no:$("#addmajor1  option:selected").val(),
					stu_year : $("#addstuyear1").val(),
					term_no:class_year,
					temp_term_no:term_no
				},
				success : function(rep) {
					if (rep.result == 0) {
						hideEditModal();
						$.alert("", rep.message);
					} else {
						hideEditModal();
						pageindex = 1;
						temppage = 1;
						loadtable(class_year,dep_no);
						$.alert("", rep.message);
					}
				}
			});
		});

	    //移除action类
	    function removeclass(){
	    	$('.addordelete').removeClass('active');
	    }
	    //点击导入按钮，弹出层，选择文件
	    $("#importBtn").unbind('click').click(function() {
	    	showmodel();
		});
	    
	    function showmodel(){
		$('#importExcelModal').modal("setting", "closable", false)
				.modal("show");
			loadImportterm();
			initFilePath();
	    }
	    
	    //显示学生编辑窗口
		function showEditModal() {
			$('#newBaseTermModal1').modal("setting", "closable", false)
					.modal("show");
		}
		//显示学生隐藏窗口
		function hideEditModal() {
			$('#newBaseTermModal1').modal("setting", "closable", false)
					.modal("hide");
		}

	    //停用或启用学生
	function removeStuTableRow( item,stu_no, stu_name, stu_status,thisItem,itemI) {
	    	console.log(itemI)
		var tempMsg = '';
		var tempBtnMsg = '';
		if (stu_status == 1) {
			tempMsg = '是否确认停用[' + stu_name + ']该学生账号？';
			tempBtnMsg = '停用';
		} else {
			tempMsg = '是否确认启用[' + stu_name + ']该学生账号？';
			tempBtnMsg = '启用';
		}

		$.confirm({
					msg : tempMsg,
					btnSure : tempBtnMsg,
					btnCancel : '取消',
					sureDo : function() {
						$.ajax({
									url : "do?invoke=baseStudentAction@updateBaseStudentStatus",
									type : 'POST',
									dataType : 'json',
									data : {
										stu_no : stu_no,
										stu_status : stu_status
									},
									success : function(rep) {
										if (rep.result == 0) {
											$.alert("", rep.message);
										} else {
											if(stu_status==1){
											    item.text("停用");
												item.addClass("error")
												thisItem.attr("stu_status","0");
											}else{
												item.text("启用");
												item.removeClass("error")
												thisItem.attr("stu_status","1");
											}
											itemI.toggleClass('lock');
											itemI.toggleClass('unlock alternate');
										}
									}
								})
					},
					cancelDo : function() {
						return;
					}
				});
		}
	    //文件上传
	    function initFilePath() {
		$("#stuuploadify").uploadify(
				{
					//接受true or false两个值，当为true时选择文件后会自动上传；为false时只会把选择的文件增加进队列但不会上传，这时只能使用upload的方法触发上传。不设置auto时默认为true
					'auto' : true,
					//设置上传按钮的class
					//buttonClass: "some-class", 
					//设置鼠标移到按钮上的开状，接受两个值'hand'和'arrow'(手形和箭头)
					//buttonCursor: 'hand',
					//设置图片按钮的路径（当你的按钮是一张图片时）。如果使用默认的样式，你还可以创建一个鼠标悬停状态，但要把两种状态的图片放在一起，并且默认的放上面，悬停状态的放在下面
					//buttonImage: 'img/browse-btn.png', 
					//设置按钮文字。值会被当作html渲染，所以也可以包含html标签
					'buttonText' : '选择文件',
					//接受一个文件路径。此文件检查正要上传的文件名是否已经存在目标目录中。存在时返回1，不存在时返回0(应该主要是作为后台的判断吧)，默认为false
					//checkExisting: '/uploadify/check-exists.php',
					//开启或关闭debug模式
					// debug: false,
					//设置在后台脚本使用的文件名。举个例子，在php中，如果这个选项设置为'the_files',你可以使用$_FILES['the_files']存取这个已经上传的文件。
					//fileObjName:'filedata',
					//设置上传文件的容量最大值。这个值可以是一个数字或者字符串。如果是字符串，接受一个单位（B,KB,MB,GB）。如果是数字则默认单位为KB。设置为0时表示不限制
					//fileSizeLimit:'100MB',
					//swf的相对路径，必写项
					'swf' : 'script/common/uploadify/uploadify.swf',
					'method' : 'post',
					'uploader' : '../../do?invoke=uploadAction@upload',
					'cancelImg' : 'cancel.png',
					//设置上传队列DOM元素的ID，上传的项目会增加进这个ID的DOM中。设置为false时则会自动生成队列DOM和ID。默认为false
					'queueID' : 'fileQueue',
					//设置是否允许一次选择多个文件，true为允许，false不允许
					'multi' : false,
					//是否缓存swf文件。默认为true，会给swf的url地址设置一个随机数，这样它就不会被缓存。(有些浏览器缓存了swf文件就会触发不了里面的事件--by rainweb)
					'preventCaching' : false,
					//设置文件上传时显示数据，有‘percentage’ or ‘speed’两个参数(百分比和速度)
					'progressData' : 'percentage',
					//设置每一次上传队列中的文件数量。注意并不是限制总的上传文件数量（那是uploadLimit）.如果增加进队列中的文件数量超出这个值，将会触发onSelectError事件。默认值为999
					//	queueSizeLimit: 999,
					//是否移除掉队列中已经完成上传的文件。false为不移除
					//removeCompleted: true,
					//设置上传完成后删除掉文件的延迟时间，默认为3秒。如果removeCompleted为false的话，就没意义了
					//removeTimeout : 3,
					//设置上传过程中因为出错导致上传失败的文件是否重新加入队列中上传
					//requeueErrors : false,
					//设置文件上传后等待服务器响应的秒数，超出这个时间，将会被认为上传成功，默认为30秒
					//successTimeout : 30,
					//可选文件的描述。这个值出现在文件浏览窗口中的文件类型下拉选项中。（chrome下不支持，会显示为'自定义文件',ie and firefox下可显示描述）
					'fileDesc' : '表格文件(*.xls;*.xlsx;)',
					//设置允许上传的文件扩展名（也就是文件类型）。但手动键入文件名可以绕过这种级别的安全检查，所以你应该始终在服务端中检查文件类型。输入多个扩展名时用分号隔开('*.jpg;*.png;*.gif')
					'fileTypeExts' : '*.xls;*.xlsx',

					//通过get或post上传文件时，此对象提供额外的数据。如果想动态设置这些值，必须在onUploadStartg事件中使用settings的方法设置
					// 				 formData: {
					// 	                    timestamp: '<?php echo $timestamp;?>',
					// 	                    token: '<?php echo md5('unique_salt' . $timestamp);?>'
					// 	                },

					onCancel : function(file) {
						//文件被移除出队列时触发,返回file参数
						console.log('将文件  ' + file.name + ' 移除出队列中.')
					},

					onClearQueue : function(queueItemCount) {
						//当调用cancel方法且传入'*'这个参数的时候触发，其实就是移除掉整个队列里的文件时触发，上面有说cancel方法带*时取消整个上传队列
						console.log(queueItemCount
								+ 'file(s) were removed frome the queue')
					},
					onDestroy : function() {
						//调用destroy方法的时候触发
					},
					onDialogClose : function(queueData) {
						//关闭掉浏览文件对话框时触发。返回queueDate参数，有以下属性：
						/*
						    filesSelected 浏览文件对话框中选取的文件数量
						    filesQueued 加入上传队列的文件数
						    filesReplaced 被替换的文件个数
						    filesCancelled 取消掉即将加入队列中的文件个数
						    filesErrored 返回错误的文件个数
						 */
						console.log('\r 浏览文件对话框中选取的文件数量:'
								+ queueData.filesSelected + '\n 加入上传队列的文件数:'
								+ queueData.filesQueued + '\r\n 被替换的文件个数:'
								+ queueData.filesReplaced
								+ '\r\n 取消掉即将加入队列中的文件个数:'
								+ queueData.filesCancelled + '\r\n 返回错误的文件个数:'
								+ queueData.filesErrored)
					},

					onDialogOpen : function() {
						//打开选择文件对话框时触发
					},
					onDisable : function() {
						//禁用uploadify时触发(通过disable方法)
					},
					onEnalbe : function() {
						//启用uploadify时触发(通过disable方法)
					},
					onFallback : function() {
						//在初始化时检测不到浏览器有兼容性的flash版本时实触发
					},

					onInit : function(instance) {
						//每次初始化一个队列时触发，返回uploadify对象的实例
						console.log('The queue ID is '
								+ instance.settings.queueID)
					},

					onQueueComplete : function(queueData) {
						//队列中的文件都上传完后触发，返回queueDate参数，有以下属性：
						/*
						    uploadsSuccessful 成功上传的文件数量
						    uploadsErrored 出现错误的文件数量
						 */
						console.log(queueData.uploadsSuccessful + '\n'
								+ queueData.uploadsErrored)
					},

					onSelect : function(file) {
						//选择每个文件增加进队列时触发，返回file参数
						console.log('增加文件\r' + file.name + '\r到上传队列中')
					},

					onSelectError : function(file, errorCode, errorMsg) {
						console.log(errorCode);
						console.log(this.queueData.errorMsg);
					},

					onSWFReady : function() {
						//swf动画加载完后触发，没有参数
					},
					onUploadComplete : function(file) {
						//在每一个文件上传成功或失败之后触发，返回上传的文件对象或返回一个错误，如果你想知道上传是否成功，最后使用onUploadSuccess或onUploadError事件
					},
					onUploadError : function(file, errorCode, erorMsg,
							errorString) {
					},
					//一个文件完成上传但返回错误时触发，有以下参数
					/*
					    file 完成上传的文件对象
					    errorCode 返回的错误代码
					    erorMsg 返回的错误信息
					    errorString 包含所有错误细节的可读信息
					 */
					onUploadProgress : function(file, bytesUploaded,
							bytesTotal, totalBytesUploaded, totalBytesTotal) {
						//每更新一个文件上传进度的时候触发,返回以下参数
						/*
						    file 正上传文件对象
						    bytesUploaded 文件已经上传的字节数
						    bytesTotal 文件的总字节数
						    totalBytesUploaded 在当前上传的操作中（所有文件）已上传的总字节数
						    totalBytesTotal 所有文件的总上传字节数
						 */
						$('#pregress').html(
								'总共需要上传' + bytesTotal + '字节，' + '已上传'
										+ totalBytesTotal + '字节')
					},

					onUploadStart : function(file) {
					    $('#excelImportSaveModal').addClass('loading')
					    $('#excelImportSaveModal').attr({"disabled":"disabled"});
						//每个文件即将上传前触发
						console.log('start update')
					},

					onUploadSuccess : function(file, data, respone) {
						$('#excelImportSaveModal').removeAttr("disabled");
						  $('#excelImportSaveModal').removeClass('loading')
						studentFilePath = "" + data;
						// 									//每个文件上传成功后触发  
						// 									alert('id: ' + file.id
						// 											+ ' - 索引: '
						// 											+ file.index
						// 											+ ' - 文件名: '
						// 											+ file.name
						// 											+ ' - 文件大小: '
						// 											+ file.size + ' - 类型: '
						// 											+ file.type
						// 											+ ' - 创建日期: '
						// 											+ file.creationdate
						// 											+ ' - 修改日期: '
						// 											+ file.modificationdate
						// 											+ ' - 文件状态: '
						// 											+ file.filestatus
						// 											+ ' - 服务器端消息: ' + data
						// 											+ ' - 是否上传成功: ');
					}

				});

		$('#uploadFile').click(function() {
			$("#stuuploadify").uploadify('upload', '*');
		});
		$('#cancelFile').click(function() {
			$("#stuuploadify")
			//cancel：取消第一个上传的文件，如果后面带参数"*"则是取消掉整个上传队列，如$(el).uploadify('cancel', '*')
			//upload：上传第一个上传的文件，如果后面带参数"*"则上传整个队列，跟cancel一样
			//destroy：移除掉上传组建，按html默认的方法上传
			//disable：有true or false 两个参数，表示是否禁止上传按钮，true表示禁止，false表示允许上传
			//settings：返回或者更新一个实例的方法值，接受一个方法名的参数时是返回那个方法的值，当后面再跟一个参数，则是更新那个方法的值
			//stop：停止正在上传中的文件或队列
			.uploadify('cancel', '*');
		});

	}
	//新增学生信息
	    $('#addNewStudent').unbind('click').click(function(){
            $("#addstuyear").empty();
            var my = new Date();
            var endYear = my.getFullYear();// 获取当前年份
            for (var i = endYear; i >= 2012; i--) {
                $("#addstuyear").append(
                        "<option value=\""+i+"\">"
                        + i+"</option>");
            }
            $('.ui.myselect').dropdown();
            if ($("#addstuyear option").length > 0) {
                console.log("缺省选中项："
                        + $("#addstuyear").get(0).options[0].selected);
                //$("#dep_no_select").get(0).options[0].selected = true;
            }
            //获取当前选择的
                stu_year_no = $("#addstuyear").val();
                temp_dep_name = $("#addstuyear").find("option:selected").text();

                $('#addClass').val('');
	    		$('#addstuno').val('');
	    		$('#addstuname').val('');
	    		$('#addstubir').val('');
	    		$('#addstuphone').val('');
                $('#addmajor').val('');
                $('#addstuyear').val('');
	    		$('#newBaseTermModal').modal("show");

	    })
        //切换所属部门
        $("#addstuyear").change(function() {
            stu_year_no = $("#addstuyear").val();
            temp_dep_name = $("#addstuyear").find("option:selected").text();
        });
	    $('#stuSaveModal').unbind('click').click(function(){
	    	var tempPhone = $("#addstuphone").val();
	    	var class_name= $('#addClass').val();
	    	var stu_no=$('#addstuno').val();
	    	var stu_name = $('#addstuname').val();
	    	var stu_birthday = $('#addstubir').val();
	    	var major_name = $('#addmajor').val();
	    	var stu_status=$('#ifUse').val();
			//判断手机号码
			if(tempPhone !=  ''){
				if(!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(tempPhone))){ 
			        alert("不是正确的11位手机号");  
			        return; 
			    } 
			}
			if(stu_no==""){
				$.alert("请填写学号")
				return;
			}else{
				if(!(/^[A-Za-z0-9]{1,10}$/.test(stu_no))){ 
			        alert("学号应由数字、 字母组成,且不超过10位");  
			        return; 
			       
			    } 
			}
			if(stu_name==""||stu_name==null){
				$.alert("学生姓名不能为空!");
				return;
			}
			$.ajax({
				url : "do?invoke=baseStudentAction@insertNewStudent",
				type : 'POST',
				dataType : 'json',
				data:{
					tempPhone:tempPhone,
                    class_name:class_name,
					stu_no:stu_no,
					stu_name:stu_name,
					stu_birthday:stu_birthday,
                    major_name:major_name,
					stu_year:stu_year_no,
					stu_status:stu_status,
					term_no:term_no,
				},
				success : function(rep) {
					$.alert(rep.message)
					$('#newBaseTermModal').modal("setting", "closable", false)
							.modal("hide");
				}
			});
	    })
	    //搜索按钮点击事件
	    $('#searchbutton').unbind('click').click(function(){
	    		stu_name =$('#search_like_data').val();
	    		pageindex = 1;
				totaltemp = 1;
				loadtable(null,null,stu_name);
			 	setTimeout(function(){
					bindClick();
				},1000)
	    })
	    $("#excelImportSaveModal").unbind('click').click(function() {
	    	temp_term_no = $("#dropdownImport").val();
					$.ajax({
								url : "do?invoke=baseStudentAction@importExcelBaseStudents",
								type : 'POST',
								dataType : 'json',
								data : {
									term_no : temp_term_no,
									student_file_path : studentFilePath,
								},
								success : function(rep) {
									$.alert(rep.message)
								}
							});
					$('#importExcelModal').modal("setting", "closable",
							false).modal("hide");
				});
	    function errorEditModal() {
			$('#exportDetailModal').modal("setting", "closable", false).modal(
					"show");
		}
	});
</script>
<!--这里引用其他JS-->
</html>