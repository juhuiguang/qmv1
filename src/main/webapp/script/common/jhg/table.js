/**
 * 页面绘制表格
 * var tableoption={
			content:"#maintable",
			url:"do?invoke=opManage@getop",
			header:[
			        {field:'OP_ID',name:"编号",key:true},
			        {field:'OP_NAME',name:"运营商名称"},
			        {field:'OP_LOGINNAME',name:"登录名"},
			        {field:'OP_CONTACT',name:"联系人"},
			        {field:'OP_PHONE',name:"联系电话"},
			        {field:'COMMON_USERID',name:"公共平台编号"},
			        {type:'button',name:"操作",content:[
			                        {name:"修改"},
			                        {name:"删除",color:"red"}
                      ]}
	        ]
		};
 */
function table(option) {
	var table = $('<table id="table_'+option.content+'" class="ui small table"></table>');
	if (option.header && option.header.length > 0) {
		var header = $("<thead><tr></tr></thead>");
		//如果显示行号
		if(option.rownumber){
			var item = $("<th>序号</th>");
			header.append(item);
		}
		for (var i = 0; i < option.header.length; i++) {
			if(option.header[i].hidden){
				continue;
			}
			var item = $("<th>" + option.header[i].name + "</th>");
			header.append(item);
		}
		table.append(header);
	}
	if (option.content) {
		$(option.content).children().remove();
		$(option.content).append(table);
	} else {
		$("body .ui.small.table").children().remove();
		$("body").append(table);
	}
	if (option.url) {
		$.ajax({
			url : option.url,
			type : 'POST',
			dataType : 'json',
			data:option.data,
			success : function(dt) {
				renderdata(dt);
				if(option.onload){
					option.onload(dt);
				}
			}
		});
	}

	function renderdata(data) {
		table.find("tbody").remove();
		var tbody = $("<tbody></tbody>");
		var tbh = data.tableHeader;
		for (var i = 0; i < data.tableRows.length; i++) {
			var tr = $("<tr></tr>");
			if(option.rownumber){
				td = $("<td>" + (i+1) + "</td>");
				tr.append(td);
			}
			for (var j = 0; j < option.header.length; j++) {
				var td = "";
				if(option.header[j].hidden){
					continue;
				}
				if (option.header[j].type && option.header[j].type == "button") {
					var html = "";
					td = $("<td></td>");
					for (var k = 0; k < option.header[j].content.length; k++) {
						var text = option.header[j].content[k].name;
						var color = option.header[j].content[k].color;
						var button = $("<a class='tablebutton ui "
								+ (color ? color : "green") + " button mini'>"
								+ text + "</a>");
						var render=option.header[j].content[k].render;
						if(render){
							button.html(render(row,data,button));
						}
						var callback=option.header[j].content[k].click;
						if(callback){
							button.unbind("click").bind("click",{rowIndex:i,row:data.tableRows[i],data:data},callback);
						}
						td.append(button);
					}
					
				} else {
					var pos = tbh.indexOf(option.header[j].field);
					var value= data.tableRows[i][pos];
					var row=data.tableRows[i];
					if(option.header[j].render){
						td=$("<td>" +option.header[j].render(value,row,data)+ "</td>");
					}else{
						td = $("<td>" +value+ "</td>");
					}
					
					if(option.header[j].key){
						tr.attr("key",data.tableRows[i][pos]);
					}
				}
				tr.append(td);
			}
			tbody.append(tr);
		}
		table.append(tbody);
	}
	
	this.refreshData=function(){
		if (option.url) {
			$.ajax({
				url : option.url,
				type : 'POST',
				dataType : 'json',
				data:option.data,
				success : function(dt) {
					renderdata(dt);
					if(option.onload){
						option.onload(dt);
					}
				}
			});
		}
	}
}