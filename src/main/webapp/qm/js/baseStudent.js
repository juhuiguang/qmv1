/**
 * 学生维护
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



function initTableBody(tabledata) {
	var temp = tabledata;
	for (var i = 0; i < temp.length; i++) {
		var dom = '<tr id="tr' + i + '">';
		dom += '<td id="teacher_name' + i + '">' + temp[i].stu_no + '</td>';
		dom += '<td id="course_name' + i + '">' + temp[i].stu_name + '</td>';
		dom += '<td id="course_name' + i + '">' + temp[i].stu_phone + '</td>';
		dom += '<td id="course_name' + i + '">' + temp[i].major_name + '</td>';
		dom += '<td id="course_name' + i + '">' + temp[i].stu_year + '</td>';
		dom += '<td id="course_name' + i + '">' + temp[i].class_name + '</td>';
		if (temp[i].stu_status == 1) {
			var stu = temp[i];
			dom += '<td id="teacher_status' + i + '">' + "正常" + '</td>';
			dom += '<td>'
					+ '<div class=" editT btnfirst circular ui small blue basic icon button" stuno="'
					+ temp[i].stu_no
					+ '" stuname="'
					+ temp[i].stu_name
					+ '" stubirthday="'
					+ temp[i].stu_birthday
					+ '" stuphone="'
					+ temp[i].stu_phone
					+ '" majorno="'
					+ temp[i].major_no
					+ '" majorname="'
					+ temp[i].major_name
					+ '" stuyear="'
					+ temp[i].stu_year
					+ '" stustatus="'
					+ temp[i].stu_status
					+ '" data-content="点击编辑此学生">'
					+ '<i class="edit icon" ></i>'
					+ '</div>'
					+ '<div style="margin-left:5px; margin-top:5px;" class="remove btnfirst circular ui small blue basic icon button" stuno="'
					+ temp[i].stu_no
					+ '" stuname="'
					+ temp[i].stu_name
					+ '" stustatus="'
					+ temp[i].stu_status
					+ '" data-content="点击停用此学生">'
					+ '<i class="lock icon"></i>'
					+ '</div>' + '</td>';
		} else {
			dom += '<td class="error" id="teacher_status' + i + '">' + "停用"
					+ '</td>';
			dom += '<td>'
					+ '<div class="editT btnfirst circular ui small blue basic icon button" temp="'
					+ temp[i].stu_name
					+ '" data-content="点击编辑此学生">'
					+ '<i class="edit icon"></i>'
					+ '</div>'
					+ '<div style="margin-left:5px; margin-top:5px;" class="remove btnfirst circular ui small blue basic icon button" stuno="'
					+ temp[i].stu_no + '" stuname="' + temp[i].stu_name
					+ '" stustatus="' + temp[i].stu_status
					+ '" data-content="点击启用此学生">'
					+ '<i class="unlock alternate icon"></i>' + '</div>'
					+ '</td>';
		}

		$("#tablepane").append(dom);
	}
	$('.btnfirst.circular.ui.blue.basic.icon.button').popup();
	$('.editT').bind(
			"click",
			function() {
				var tempclass = $(this).closest("tr");
				var stu_no = $(this).attr('stuno');
				var stu_name = $(this).attr('stuname');
				var stu_birthday = $(this).attr('stubirthday');
				var stu_phone = $(this).attr('stuphone');
				var major_no = $(this).attr('majorno');
				var major_name = $(this).attr('majorname');
				var stu_year = $(this).attr('stuyear');
				var stu_status = $(this).attr('stustatus');
				editStuTableRow(tempclass, stu_no, stu_name, stu_birthday,
						stu_phone, major_no, major_name, stu_year, stu_status);

			});
	$('.remove').bind("click", function() {
		var tempclass = $(this).closest("tr");
		var stu_no = $(this).attr('stuno');
		var stu_name = $(this).attr('stuname');
		var stu_status = $(this).attr('stustatus');
		removeStuTableRow(tempclass, stu_no, stu_name, stu_status);
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
//学生编辑信息
function editStuTableRow(tempclass, stu_no, stu_name, stu_birthday, stu_phone,
		major_no, major_name, stu_year, stu_status) {
	$("#addstuno").prop('disabled', true);
	$("#addstuname").prop('disabled', true);
	$("#addstuyear").prop('disabled', true);
	$("#addstuno").val(stu_no);
	$("#addstuname").val(stu_name);
	$("#addstubir").val(stu_birthday);
	$("#addstuphone").val(stu_phone);
	$("#addstuyear").val(stu_year);
	temp_major_no = major_no;
	temp_major_name = major_name;
	loadingDropDownMajor();
	showEditModal();
}
// 获取当前所有的专业
function loadingDropDownMajor() {
	$
			.ajax({
				url : "do?invoke=commonAction@queryBaseMajor",
				type : 'POST',
				dataType : 'json',
				success : function(rep) {
					if (rep.result == 0) {
						$.alert("", rep.message);
					} else {
						$("#addmajor").empty();
						var selectDep = rep.data;
						for (var i = 0; i < selectDep.length; i++) {
							$("#addmajor").append(
									"<option value=\"" + selectDep[i].major_no
											+ "\">" + selectDep[i].major_name
											+ "</option>");
						}
						
						var count = $("#addmajor option").length;
						for (var i = 0; i < count; i++) {
							if ($("#addmajor").get(0).options[i].text == temp_major_name) {
								$("#addmajor").get(0).options[i].selected = true;
								break;
							}
						}
						$('.ui.addmajor').dropdown();
						// 获取当前选择的
						temp_major_no = $("#addmajor").val();
						temp_major_name = $("#addmajor")
								.find("option:selected").text();
					}
				}
			});
}

//显示学生编辑窗口
function showEditModal() {
	$('#newBaseTermModal').modal("setting", "closable", false)
			.modal("show");
}
//显示学生隐藏窗口
function hideEditModal() {
	$('#newBaseTermModal').modal("setting", "closable", false)
			.modal("hide");

}
