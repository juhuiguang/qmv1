/**
 * 班级维护
 */
// 获取当前所有的部门
function getCurrentDep(data) {
	var deps = data;
	$("#depdiv").hide(); 
	if( temp_dep_no.trim() != "all"){ 
		pageindex = 1; 
		temppage = 1; 
		pagelength = 15;
		
	}else{   
		$("#depdiv .dep").remove();
		console.log(deps)
		for (var i = 0; i < deps.length; i++) {
			if (deps[i].dep_name == "外语系") {

			} else {
				var depdiv = $('<a class="dep ui gray label"" id="'
						+ deps[i].dep_no + '">' + deps[i].dep_name + '</a>');
				$("#depdiv").append(depdiv);
			}
		}
		$("#depdiv").fadeIn();
		$("#depdiv .label").click(function() {
			$("#depdiv .blue").removeClass("blue");
			$(this).addClass("blue");
			temp_dep_no = this.id;
			pageindex = 1;
			temppage = 1;
			pagelength = 15;
			loadingTable();
		});
	}
	
}
// 获取当前所有的学年(2015/2014)
function getCurrentTermYear() {
	$("#get_termyear_select").empty();
	$.ajax({
		url : "do?invoke=baseStudentAction@getTermYear",
		type : 'POST',
		dataType : 'json',
		success : function(rep) {
			if (rep.result == 0) {
				$.alert("", rep.message);
				return;
			} else {
				var temp = rep.data
				for (var i = 0; i < temp.length; i++) {
					var dom = ' <option value="' + temp[i].year_no + '">'
							+ temp[i].year_no + '年</option>';
					$("#get_termyear_select").append(dom)
				}
				$('.ui.get_termyear_select').dropdown();
			}

			$("#get_termyear_select").change(function() {
				// 判断当前的学年学期是否存在
				temp_termno = $("#get_termyear_select").val();
				pageindex = 1;
				temppage = 1;
				loadingTable();

			});
		}
	});
}
// 获取表格数据
function loadingTable() {
	$('#tablepane').html("");
	$("#spanFirst").attr("temp", '0');
	$("#spanNext").attr("temp", '0');
	$("#spanPre").attr("temp", '0');
	$("#spanLast").attr("temp", '0');
	$
			.ajax({
				url : "do?invoke=baseClassAction@queryBaseClassList",
				type : 'POST',
				dataType : 'json',
				data : {
					term_no : temp_termno,
					dep_no : temp_dep_no,
					serach_class_name : temp_serach_class_name,
					pageindex : pageindex,
					pageLength : pagelength,
					temppage : temppage
				},
				success : function(rep) {
					console.log(rep)
					if (rep.total == 0) {
						$("#spanbutton").hide();
						$('#tablehead').hide();
						$('#message').remove();
						var dom = '<div class="ui green large message" id="message">'
								+ '<i class="frown large inverted yellow circular icon"></i> 暂无相关班级数据！'
								+ '</div>';
						$('#container').append(dom);
						return;
					} else {
						$("#spanbutton").show();
						$('#tablehead').show();
						$('#message').remove();
						if (temppage == 1) {
							var count = 0;
							if (rep.total % pagelength != 0)
								count = 1;
							totalpage = parseInt(rep.total / pagelength)
									+ count;
							$("#spanLast").attr("page", totalpage);
							$("#spanTotalPage").text(totalpage);
						}
						temppage++;
						initTableBody(rep.rows);

					}

				}

			});
}

function initTableBody(tabledata) {
	var temp = tabledata;
	for (var i = 0; i < temp.length; i++) {
		var dom = '<tr id="tr' + i + '">';
		dom += '<td id="class_name' + i + '">' + temp[i].class_name + '</td>';
		dom += '<td id="class_stu_amount' + i + '">' + temp[i].class_stu_amount 
				+ '</td>';
		dom += '<td id="teacher_name' + i + '">' + temp[i].teacher_name
				+ '</td>';
		dom += '<td id="stu_name' + i + '">' + temp[i].stu_name + '</td>';
		if (temp[i].class_isover == 1) {
			dom += '<td id="class_isover' + i + '">' + '是' + '</td>';
		} else {
			dom += '<td id="class_isover' + i + '">' + '否' + '</td>';
		}
		dom += '<td id="major_name' + i + '">' + temp[i].major_name + '</td>';
		dom += '<td id="dep_name' + i + '">' + temp[i].dep_name + '</td>';
		dom += '<td>'
				+ '<div class="editT btnfirst circular ui small blue basic icon button" classno="'
				+ temp[i].class_no
				+ '" classname="'
				+ temp[i].class_name
				+ '" classstuamount="'
				+ temp[i].class_stu_amount 
				+ '" majorno="'
				+ temp[i].major_no
				+ '" majorname="'
				+ temp[i].major_name
				+ '" teacherno="'
				+ temp[i].teacher_no
				+ '" teachername="'
				+ temp[i].teacher_name
				+ '" stuno="'
				+ temp[i].stu_no
				+ '" stuname="'
				+ temp[i].stu_name
				+ '" depno="'
				+ temp[i].dep_no
				+ '" depname="'
				+ temp[i].dep_name
				+ '" classisover="'
				+ temp[i].class_isover
				+ '" data-content="点击编辑此班级">'
				+ '<i class="edit icon"></i>'
				+ '</div>' + '</td>';

		$("#tablepane").append(dom);
	}
	$('.btnfirst.circular.ui.blue.basic.icon.button').popup();
	$('.editT').bind(
			"click",
			function() {
				var tempclass = $(this).closest("tr");
				var class_no = $(this).attr("classno");
				var class_name = $(this).attr("classname");
				var class_stu_amount = $(this).attr("classstuamount");
				var major_no = $(this).attr("majorno");
				var major_name = $(this).attr("majorname");
				var teacher_no = $(this).attr("teacherno");
				var teacher_name = $(this).attr("teachername");
				var stu_no = $(this).attr("stuno");
				var stu_name = $(this).attr("stuname");
				var dep_no = $(this).attr("depno");
				var dep_name = $(this).attr("depname");
				var class_isover = $(this).attr("classisover");
				editClassesTableRow(tempclass, class_no, class_name,
						class_stu_amount, major_no, major_name, teacher_no,
						teacher_name, stu_no, stu_name, dep_no, dep_name,
						class_isover);
			});

	if (totalpage == 0)
		$("#spanPageNum").text(0);
	else
		$("#spanPageNum").text(pageindex);
	// 判断按钮是否禁用 
	if (pageindex == 1 || totalpage == 0) {
		$("#spanPre").removeAttr("href");
		$("#spanPre").addClass("display")
	}
	if (totalpage > 1) {
		if (pageindex == 2 || pageindex == totalpage) {
			if (typeof ($("#spanPre").attr("href")) == "undefined") {
				$("#spanPre").attr("href", "javascript:void(0);");
				$("#spanPre").removeClass("display")
			}
		}
	}
	if (pageindex == 1 || totalpage == 0) {
		$("#spanFirst").removeAttr("href");
		$("#spanFirst").addClass("display")
	}
	if (totalpage > 1) {
		if (pageindex == 2 || pageindex == totalpage) {
			if (typeof ($("#spanFirst").attr("href")) == "undefined") {
				$("#spanFirst").attr("href", "javascript:void(0);");
				$("#spanFirst").removeClass("display")
			}
		}
	}
	if (pageindex == totalpage) {
		$("#spanNext").removeAttr("href");
		$("#spanNext").addClass("display")
	}
	if (totalpage > 1) {
		if (pageindex == totalpage - 1 || pageindex == 1) {
			if (typeof ($("#spanNext").attr("href")) == "undefined") {
				$("#spanNext").attr("href", "javascript:void(0);");
				$("#spanNext").removeClass("display")
			}
		}
	}
	if (pageindex == totalpage) {
		$("#spanLast").removeAttr("href");
		$("#spanLast").addClass("display")
	}
	if (totalpage > 1) {
		if (pageindex == totalpage - 1 || pageindex == 1) {
			if (typeof ($("#spanLastt").attr("href")) == "undefined") {
				$("#spanLast").attr("href", "javascript:void(0);");
				$("#spanLast").removeClass("display")
			}
		}
	}

}


//班级编辑信息
function editClassesTableRow(tempclass, class_no, class_name, class_stu_amount,
		major_no, major_name, teacher_no, teacher_name, stu_no, stu_name,
		dep_no, dep_name, class_isover) {
	
	bjteano = teacher_no;
	bjstuno = stu_no;
	//
	temp_save_class_no = class_no;
	getAllTeaStu();
	//
	 
	$("#addclassname").val(class_name);  
	$("#addclassstuamount").val(class_stu_amount);
/* 		$("#addTeacherNo").val();
	$("#addTeacherName").val();
	$("#addStuNo").val(); 
	$("#addStuName").val(); */
	$("#tea").val(teacher_name);
	$("#stu").val(stu_name);
	temp_edit_major_no = major_no; 
	temp_edit_major_name = major_name;
	temp_edit_is_over = class_isover;  
	temp_edit_dep_no = dep_no;
	temp_edit_dep_name = dep_name;
	teaid = teacher_no;  
	stuid=stu_no;
	

	
	
	if(temp_edit_is_over !='1'){   
		$('#is_over_select input').val('否'); 
	}else{  
		$('#is_over_select input').val('是');  
	}  
	   
	$("#addmajor input").val(temp_edit_major_name);  
	$("#dep_no_select input").val(temp_edit_dep_name); 
	//切换是否毕业班
	$("#is_over_select .item").click(function() { 
		temp_edit_is_over = $(this).attr('name');  
		console.log("选中毕业状态：" + temp_edit_is_over);
	});
	//切换所属部门
	$("#dep_no_select .item").click(
			function() {
				temp_edit_dep_no = $(this).attr('name');  
				temp_edit_dep_name = $(this).text().trim();
			});

	//切换所属于专业
	$("#addmajor .item").click(function() {  
		 
		temp_edit_major_no = $(this).attr('name');     
		temp_edit_major_name = $(this).text().trim();
		console.log(temp_edit_major_no)
	});
	showEditModal(); 
}
 
function showEditModal() {
	$('#newBaseTermModal').modal("setting", "closable", false).modal("show");
	$('#is_over_select') 
	  .dropdown(); 
	$('#addmajor').dropdown();
	$('#dep_no_select').dropdown(); 
}
function hideEditModal() {
	$('#newBaseTermModal').modal("setting", "closable", false).modal("hide");
}
function getAllTeaStu() {
	$.ajax({
		url:"do?invoke=baseClassAction@getTeaStu",
		type:'POST', 
		dataType:'json',
		data:{
			classno:temp_save_class_no
		},
		success:function(rep) {
			
			if(rep.result==0) {
				$.alert("没有取到教师或学生的相关信息~");
				return;
			} else {  
				 
				var teastu=rep.data[0];
				var alltea=[];
				var allstu=[];
				for(var i=0; i<teastu.teatb.length; i++) {
					alltea[i] = {title:teastu.teatb[i].teacher_name,description:teastu.teatb[i].teacher_no,"id":teastu.teatb[i].teacher_no};
				}
				$('.tea.ui.search').search({
					 source: alltea,
					 maxResults:10000,   
					 onSelect:function(itemtea) {
						 teaid = itemtea.id;
					 }
				  });	
				 for(var j=0; j<teastu.stutb.length; j++) {
					 allstu[j] = {title:teastu.stutb[j].stu_name,description:teastu.stutb[j].stu_no,"id":teastu.stutb[j].stu_no};
				 } 
				 $('.stu.ui.search').search({
					 source: allstu,
					 maxResults:10000,    
					 onSelect:function(itemstu) { 
						 stuid = itemstu.id; 
					 }
				  });	
			}
		}
	});
}
