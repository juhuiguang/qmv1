<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp" %>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp" %>
<!--这里引用其他样式-->
<title>校内教学质量监控运行平台</title>
		<style>
		.lefth5{
	      float:left
	    }
	    #adddepartment{
	    	margin-bottom:5px;
	    	float:right
	    }
	
	 #cancel{
	 flaot:right
	 }
	  #right{
	 display:none;
	 } 
	 .ccc{
	 width:15%!important
	 }
		</style>
</head>
<body>
<%@ include file="/commonjsp/header.jsp"%>
	<div id="container">
		<h3  class="ui header "> 
	  			<i class="ui  unordered list icon"></i>
	  			部门维护
		</h3>
		 <button class="ui small teal button" id='adddepartment'><i class=" plus icon"></i>添加部门</button>
		<div class="ui cards" id="doubling">
		</div>	

	  <div class="sixteen wide column" id="right" >
		  <form class="ui form segment" id="myform" action=""  method="post" target="id_iframe">
			  <p>填写添加部门的信息</p>
			  <div class="two fields">
			    <div class="dep field">
			      <label>部门名称</label>
			      <input placeholder="部门名称" name="dep_name" type="text">
			    </div>
			    <div class="dep field">
			       <label>部门编号</label>
			      <input placeholder="部门编号" name="dep_no" type="text">
			    </div>
			  </div>
			  <div class="two fields">
			 
			    <div class="dep field">
			      <label>部门类型</label>
			      <select class="ui dropdown" name="dep_type" id="myodropdown">
			        <option value="行政">行政</option>
			        <option value="教学">教学</option>
			      </select>
			    </div>
			    <div class="dep field">
			      <label>部门检索编号</label>
			      <input placeholder="部门检索编号" name="dep_cddw_no" type="text">
			    </div>
			  </div>
			   <div class="two fields">
			   <div class="dep field">
			      <label>部门排序编号</label>
			      <input placeholder="部门排序编号" name="dep_sort" type="text">
			    </div>  
			     <div class="dep field">
			      <label>部门简称</label>
			      <input placeholder="部门简称" name="dep_abbreviation" type="text">
			    </div>  
			    </div>
			
	    	<div class="ui  container center aligned">
	    	 <button class=" ccc ui  green  button "id="add">添加</button>
			     <div class="ccc ui  red button" id='cancel'>取消</div>
			  </div>
	    	</form>
	    	<iframe id="id_iframe" name="id_iframe" style="display:none;"></iframe>
		</div>

</div>
	<!--这里绘制页面--> 
</body>
<script>
 $(function(){
	 $("#myodropdown").dropdown({
  
       });
	 $('#myform')
	  .form({
		  fields : 'validationRules',
		    inline : true,
		    on     : 'blur',
		    duration:'200',
	    fields: {
	      dep_name: {
	        identifier  : 'dep_name',
	        rules: [
	          {
	            type   : 'empty',
	            prompt : '请输入正确的部门名称'
	          }
	        ]
	      },
	      dep_no: {
		        identifier  : 'dep_no',
		        rules: [
		          {
		            type   : 'empty',
		            prompt : '请输入正确的部门编号'
		          }
		        ]
		      },
	      dep_type: {
	        identifier  : 'dep_type',
	        rules: [
	          {
	            type   : 'empty',
	            prompt : '请选择部门类型'
	          }
	        ]
	      },
	      dep_cddw_no: {
	        identifier : 'dep_cddw_no',
	        rules: [
	          {
	            type   : 'empty',
	            prompt : '请输入部门排序编号'
	          }
	        ]
	      },
	      dep_sort: {
	        identifier : 'dep_sort',
	        rules: [
	          {
	            type   : 'empty',
	            prompt : '请输入部门排序编号'
	          }
	        ]
	      }
	    }
	  })
	;
	 //添加按钮点击事件
	 $('#add').unbind('click').click(function(){
			 var dep_name=$('input[name="dep_name"]').val()
			 var dep_no=$('input[name="dep_no"]').val()
			 var dep_type=$('.text').text()
			 var dep_cddw_no=$('input[name="dep_cddw_no"]').val()
			 var dep_sort=$('input[name="dep_sort"]').val()
			 var dep_abbreviation=$('input[name="dep_abbreviation"]').val()
		 if(dep_name=="" || dep_no==""||dep_type==""|| dep_cddw_no=="" || dep_sort==""){
			 $.alert("请填写完整再提交");
			 return;
		 }else{
			 $('#add').addClass("loading")
			 if($('#add').text()=="添加"){
			 $.ajax({
					url:"do?invoke=departmentmaintain@insertdep",
					type:"POST",
					dataType:"json",
					data:{
						dep_name:dep_name,
						dep_no:dep_no,
						dep_type:dep_type,
						dep_cddw_no:dep_cddw_no,
						dep_sort:dep_sort,
						dep_abbreviation:dep_abbreviation
						
					},
					success:function(rep){
						$('#add').removeClass("loading")
						if(rep.result==0){
						$.alert(rep.message)
						}
						else{
						$.alert(rep.message, function returntable(){
							 $('#doubling').html('');
								loadtable();
							 $('#right').transition({
								 animation  :'horizontal flip out',
									 onComplete : function() {  
										 $('#doubling').transition('fly left in')
									    }
								 })
						 });

						}
					}
				});
			 }else{
				 var dep_no1=$("#add").attr("dep_no1")
				 $.ajax({
						url:"do?invoke=departmentmaintain@updatedep",
						type:"POST",
						dataType:"json",
						data:{
							dep_no1:dep_no1,
							dep_name:dep_name,
							dep_no:dep_no,
							dep_type:dep_type,
							dep_cddw_no:dep_cddw_no,
							dep_sort:dep_sort,
							dep_abbreviation:dep_abbreviation
							
						},
						success:function(rep){
							$('#add').removeClass("loading")
							if(rep.result==0){
							$.alert(rep.message)
							}
							else{
								$.alert(rep.message, function returntable(){
									 $('#doubling').html('');
										loadtable();
									 $('#right').transition({
										 animation  :'horizontal flip out',
											 onComplete : function() {  
												 $('#doubling').transition('fly left in')
											    }
										 })
								 });
							}
						}
					});
			 }
		 }
	 })
	 	 //添加部门按钮点击事件
	 $("#adddepartment").unbind('click').click(function(){
		  if($('#right').css("display")=='none'){
		 $('#add').text("添加")
		 $(this).attr("disabled","disabled");
 		$(this).addClass('loading')
			  $("input").val('')
			  $(".dep").removeClass('error')
			  $(".ui.red.pointing.prompt.label.transition.visible").remove();
		 $('#doubling').transition({
			 animation  :'horizontal flip out',
				 onComplete : function() {  
		    	      $('#myodropdown').dropdown('set selected',"行政");
					 $('#right').transition('horizontal flip in')
					 $('#adddepartment').removeAttr("disabled");
		    	      $('#adddepartment').removeClass('loading');
				    }
			 })
		  }
	 })
	  $("#cancel").unbind('click').click(function(){
		 if($('#right').css("display")=='block'){
			 $(this).attr("disabled","disabled");
		 		$(this).addClass('loading')
		  $('#right').transition({
			 animation  :'horizontal flip out',
				 onComplete : function() {  
					 $('#doubling').transition('horizontal flip in')
					 $('#cancel').removeAttr("disabled");
		    	      $('#cancel').removeClass('loading');
				    }
			 })
		 }
			 
	 })
  loadtable();
  //读取部门数据
  function loadtable(){
	  $.ajax({
			url:"do?invoke=departmentmaintain@gettableinformation",
			type:"POST",
			dataType:"json",
			success:function(rep){
              //建造表格
				createtable(rep.data)
			}
		});
  };
 function createtable(data){
	  var temp=data;
	  for(var i=0;i<temp.length;i++){
		  var dom='<div class="csscard ui  card" >'+
          '<div class="content">'+
            '<h5 class="ui header">部门名称:&nbsp'+temp[i].dep_name+'</h5>'+
          '</div>'+
          '<div class="extra content">'+
          '<div><h5 class="lefth5 ui header" >部门简称:</h5>&nbsp'+temp[i].dep_abbreviation+' </div>'+
        '</div>'+
          '<div class="extra content">'+
            '<div><h5 class="lefth5 ui header" >部门代码:</h5>&nbsp'+temp[i].dep_no+' </div>'+
          '</div>'+
          '<div class="extra content">'+
            '<div><h5 class="lefth5 ui header" >部门类型:</h5>&nbsp'+temp[i].dep_type+' </div>'+
          '</div>';
				dom+= '<div class="extra content">'+
				'<div class="ui  container center aligned">'+
				'<button class="changedep ui mini green button" dep_abbreviation="'+temp[i].dep_abbreviation+'" dep_no="'+temp[i].dep_no+'"  dep_name="'+temp[i].dep_name+'"  dep_type="'+temp[i].dep_type+'"  dep_cddw_no="'+temp[i].dep_cddw_no+'"  dep_sort="'+temp[i].dep_sort+'"> 修改</button>&nbsp&nbsp&nbsp'+
				'<button class="deletedep ui mini red button"  dep_no="'+temp[i].dep_no+'">删除</button>'+
				'</div>'
                  '</div>';
			dom+='</div>'; 
  $("#doubling").append(dom);
	  }
	  $('.changedep').unbind('click ').click(function(){ 
		  $(this).attr("disabled","disabled");
		  $(this).addClass('loading')
		  $("#add").text("修改")
			 var dep_name=$(this).attr('dep_name')
			 var dep_no=$(this).attr('dep_no')
			 var dep_type=$(this).attr('dep_type')
			 var dep_cddw_no=$(this).attr('dep_cddw_no')
			 var dep_sort=$(this).attr('dep_sort')
			 var dep_abbreviation = $(this).attr('dep_abbreviation');
			 $("#add").attr("dep_no1",dep_no)
			 $('input[name="dep_name"]').val(dep_name)
			 $('input[name="dep_no"]').val(dep_no)
			 $('.item[data-value!=""]').removeClass('active selected');
			$('.item[data-value="'+dep_type+'"]').addClass('active selected');
		  $('.text').text(dep_type);
		  $('.text').removeClass('default');
			 $('input[name="dep_cddw_no"]').val(dep_cddw_no)
			 $('input[name="dep_sort"]').val(dep_sort)
			  $('input[name="dep_abbreviation"]').val(dep_abbreviation)
			  $(".dep").removeClass('error')
			  $(".ui.red.pointing.prompt.label.transition.visible").remove();
		 $('#doubling').transition({
			 animation  :'horizontal flip out',
				 onComplete : function() {  
					 $('#right').transition('horizontal flip in')
					 $('.changedep').removeAttr("disabled");
		    	      $('.changedep').removeClass('loading');
				    }
			 })
	  })
	 $('.deletedep').unbind('click').click(function(){
		 var dep_no=$(this).attr('dep_no')
		 $.confirm({
						msg       :"您确定删除该部门么吗？",
						btnSure   : '确定 ',
						btnCancel : '取消',
						sureDo	  : function(){
							  $.ajax({
									url:"do?invoke=departmentmaintain@deletedep",
									type:"POST",
									dataType:"json",
									data:{
										dep_no:dep_no
									},
									success:function(rep){
						              //建造表格
										if(rep.result==0)
											$.alert(rep.message)
										else{
											$.alert(rep.message, function returntable(){
												 $('#doubling').html('');
													loadtable();
													$('#doubling').transition('fly left in')
											 })									
										}
									}
								});		
						},
						cancelDo:function(){
						}
					});
		  })
  }
}); 
</script>
<!--这里引用其他JS-->
</html>