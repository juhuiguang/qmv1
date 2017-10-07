<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp" %>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp" %>
<!--这里引用其他样式-->
<title>校内教学质量监控运行平台</title>
<style>
 input[type=range] {
  -webkit-appearance: none;
  width: 100%;
  margin: 3px 0;
}
input[type=range]:focus {
  outline: none;
}
input[type=range]::-webkit-slider-runnable-track {
  width: 100%;
  height: 9px;
  cursor: pointer;
  box-shadow: 0px 0px 4.1px #3b2f5b, 0px 0px 0px #46386c;
 background: #97c6f4;
  border-radius: 25px;
  border: 0px solid rgba(121, 100, 92, 0);
}
input[type=range]::-webkit-slider-thumb {
  box-shadow: 0.9px 0.9px 0px #413b4d, 0px 0px 0.9px #4d465b;
  border: 0px solid #773e3d;
  height: 15px;
  width: 16px;
  border-radius: 50px;
  background: rgba(156, 0, 255, 0);
  cursor: pointer;
  -webkit-appearance: none;
  margin-top: -3px;
}
input[type=range]:focus::-webkit-slider-runnable-track {
  background: #5396ff;
}
input[type=range]::-moz-range-track {
  width: 100%;
  height: 9px;
  cursor: pointer;
  box-shadow: 0px 0px 4.1px #3b2f5b, 0px 0px 0px #46386c;
  background: #97c6f4;
  border-radius: 25px;
  border: 0px solid rgba(121, 100, 92, 0);
}
input[type=range]::-moz-range-thumb {
  box-shadow: 0.9px 0.9px 0px #413b4d, 0px 0px 0.9px #4d465b;
  border: 0px solid #773e3d;
  height: 15px;
  width: 16px;
  border-radius: 50px;
  background: rgba(156, 0, 255, 0);
  cursor: pointer;
}
input[type=range]::-ms-track {
  width: 100%;
  height: 9px;
  cursor: pointer;
  background: transparent;
  border-color: transparent;
  color: transparent;
}
input[type=range]::-ms-fill-lower {
  background: #d8dae3;
  border: 0px solid rgba(121, 100, 92, 0);
  border-radius: 50px;
  box-shadow: 0px 0px 4.1px #3b2f5b, 0px 0px 0px #46386c;
}
input[type=range]::-ms-fill-upper {
  background: #dee0e7;
  border: 0px solid rgba(121, 100, 92, 0);
  border-radius: 50px;
  box-shadow: 0px 0px 4.1px #3b2f5b, 0px 0px 0px #46386c;
}
input[type=range]::-ms-thumb {
  box-shadow: 0.9px 0.9px 0px #413b4d, 0px 0px 0.9px #4d465b;
  border: 0px solid #773e3d;
  height: 15px;
  width: 16px;
  border-radius: 50px;
  background: rgba(156, 0, 255, 0);
  cursor: pointer;
  height: 9px;
}
input[type=range]:focus::-ms-fill-lower {
  background: #dee0e7;
}
input[type=range]:focus::-ms-fill-upper {
  background: #e4e6eb;
}
#btnsubmit{
		width:100%;
		height:5%;
		margin:10px auto;
	}
	.run{
	margin-top:6%;
	margin-left:-15%
	}
	.lefth5{
	float:left
	} 
	 input{
	 width:30%!important;
	 font-weight:400;
	 font-size:14px;
	 }
	 #tempMark{
	float:right;
	 }
</style>
</head>
<body>
<%@ include file="/commonjsp/header.jsp"%>
	<div id="container">
		<h3  class="ui header "> 
	  			<i class="ui  unordered list icon"></i>
	  			<div class="content">教师评学</div>
		</h3> 
		<div class="ui grid">
		  <div  class="thirteen wide column" id="left">	
		<div class="ui two doubling cards" id="doubling">
		</div>	
  </div>
  <div class="seven wide column" id="right" >
      
  </div>
</div>
</div>
	<!--这里绘制页面-->
</body>
<script>
 $(function(){
	  //$("input[name='username']")
  	  loadtable();
	//读取创建表格所需要的数据
 	 function loadtable(){
		$.ajax({
			url:"do?invoke=Tea_commentclass@gettableinformation",
			type:"POST",
			dataType:"json",
			data:{
				term_no:SYSOBJCET.term_no,
				teacher_no:USEROBJECT.loginname
			},
			success:function(rep){
				$.ajax({
					url:"do?invoke=Tea_commentclass@getPXinformation",
					type:"POST",
					dataType:"json",
					data:{
						term_no:SYSOBJCET.term_no,
						teacher_no:USEROBJECT.loginname
					},
					success:function(table){
						if(rep.result==0){
							$('#container').empty();
    						var dom='<div class="ui green large message">'+
							'<i class="frown large inverted yellow circular icon"></i> 抱歉！暂无您的相关课程信息！'+
						'</div>';
    						$('#container').append(dom);
						}else
						cratetable(rep.data,table.data);	
					}
				});
			}
		});
	};
	var temptask_no='';
	//创建选择表格
	function cratetable(information,tableinformation){
		  
					var temp=information;
					var tempinfo=tableinformation;
					if(tempinfo==""){
						for(var i=0;i<temp.length;i++){
							 var dom='<div class="csscard ui  card" >'+
		                       '<div class="content">'+
		                         '<h5 class="ui header">课程名称:'+temp[i].course_name+'</h5>'+
		                       '</div>'+
		                       '<div class="extra content">'+
		                         '<div><h5 class="lefth5 ui header" >班级名称:</h5>&nbsp'+temp[i].class_name+' </div>'+
		                       '</div>'+
		                       '<div class="extra content">'+
		                         '<div><h5 class="lefth5 ui header" >班级人数:</h5>&nbsp'+temp[i].course_scount+' </div>'+
		                       '</div>';
  								dom+= '<div class="extra content">'+
  		                         '<div><h5 class="lefth5 ui header" >评学时间:</h5>&nbsp尚未评学 </div>'+
	    		                       '</div>';
  								dom+= '<div class="extra content">'+
	    							'<button  class="pxclicka ui  container center aligned blue button" task_no="'+temp[i].task_no+'" control="0">'+
	    							  '评学 '+
	    						  '</button>'
	    		                       '</div>';
								dom+='</div>'; 
	                   $("#doubling").append(dom);
						}
	    			           $(".listen.btnfirst.circular.ui.blue.basic.icon.button").click(function(){creatpxtableinformation($(this).attr('task_no'),$(this).attr('control'))})
 					}
					else{
						for(var i=0;i<temp.length;i++){
						            var c=1;
								    var dom='<div class="csscard ui  card" >'+
			    		                       '<div class="content">'+
			    		                         '<h5 class="ui header">课程名称:'+temp[i].course_name+'</h5>'+
			    		                       '</div>'+
			    		                       '<div class="extra content">'+
			    		                         '<div><h5 class="lefth5 ui header" >班级名称:</h5>&nbsp'+temp[i].class_name+' </div>'+
			    		                       '</div>'+
			    		                       '<div class="extra content">'+
			    		                         '<div><h5 class="lefth5 ui header" >班级人数:</h5>&nbsp'+temp[i].course_scount+' </div>'+
			    		                       '</div>';
			    		                      for(var m=0;m<tempinfo.length;m++){
				    							if(temp[i].task_no==tempinfo[m].task_no){
						    					dom+= '<div class="extra content">'+
					    		                         '<div><h5 class="lefth5 ui header" >评学时间:</h5>&nbsp'+tempinfo[m].px_time+' </div>'+
						    		                       '</div>';
				    							dom+= '<div class="extra content">'+
				    							'<button  class="pxclicka ui teal container center aligned button" task_no="'+temp[i].task_no+'" control="1">'+
				    							  '修改评学 '+
				    						  '</button>'
				    		                       '</div>';
						    		                     c=0;
				    							}
				    							}
				    							if(c==1){
				    								dom+= '<div class="extra content">'+
				    		                         '<div><h5 class="lefth5 ui header" >评学时间:</h5>&nbsp尚未评学 </div>'+
					    		                       '</div>';
				    								dom+= '<div class="extra content">'+
					    							'<button  class="pxclicka ui  container center aligned blue button" task_no="'+temp[i].task_no+'" control="0">'+
					    							  '评学 '+
					    						  '</button>'
					    		                       '</div>';
				    							}
			   								dom+='</div>'; 
					                   $("#doubling").append(dom);
						}
						console.log($('#left').hasClass("thirteen"))
						if($('#left').hasClass("thirteen")){
						}else{
							$('#left').addClass("thirteen wide column")
						}
					}
					 $(".pxclicka").click(function(){
						 if($(this).attr('task_no')==temptask_no)return;
						 temptask_no=$(this).attr('task_no')
						$('.pxclicka').attr("disabled","disabled");
				    	$(this).addClass('loading')
						 creatpxtableinformation($(this).attr('task_no'),$(this).attr('control'))
						 })
	};
	//获得评学表格所需的数据
	function creatpxtableinformation(a_task_no,b){
		var temp=a_task_no;
		$.ajax({
					url:"do?invoke=Tea_commentclass@loadtable",
					type:"POST",
					dataType:"json",
					data:{
						flag:'PJ_PX'
					},
					success:function(table){
						if(table.result==0){
						    $.alert("",table.message)
							}
						else{
							$("#right").html("");
							  creatpxtable(table.data,temp,b);
								$("#left").attr("class","eight wide column");
								$("#right").transition("fly left in")
						}
					}
		});
	}
	//创建评学表格
	function creatpxtable(tabledata,task_no,b){
		var temp=tabledata;
		for(var i=temp.length-1;i>=0;i--){
			var label=
			'<div>'+
			'<i class="grid layout icon"></i>'+
			temp[i].rule_title+'('+temp[i].rule_goal+'分)'+

		 		' &nbsp&nbsp<input class="middle aligned" type="range" step=1 value='+parseInt(temp[i].rule_goal/2)+' min="0" max="'+temp[i].rule_goal+'"/>'+	
		 		'<div class="ui mini  icon input" style="float:right;margin-top:-1%">'+
		 		'<div class="ui mini  left icon input">'+
		 		'<i class="large write icon"></i>'+
		 		'<input type="text" class="intext" style="width:80px!important" value='+parseInt(temp[i].rule_goal/2)+' id="'+temp[i].rule_field+'" placeholder="请打分..." fieldname="'+temp[i].rule_field+'" grade="'+temp[i].rule_goal+'"></div>'+
		 	'</div>'+
		
			'</div >'+
	 	'</div>'+
	 	'<div class="ui divider"></div>';
	 	$('#right').prepend(label)
		}
		var summark =   '<div id="tempMark">总分：<div class="ui big blue    label" id= "sumMark">50</div></div>';
		$('#right').append(summark)
	
		var templabel=
		'<div class="ui form">'+
		 '<div class="ui blue ribbon label">班级评价</div>'+
		  '<textarea id="xxjy"  rows="1"></textarea>'+
		 ' </div>'+
       '<div class="ui container center aligned">'+
		'<button id="btnsubmit" class="ui green button">'+
		  '<i class="checkmark icon"></i>提交 '+
	'</button></div>';
	$('#right').append(templabel)
		$(".middle.aligned").change(function(){
			var score= $(this).val()
			var tempScore = $(this).next().find(".intext").val();
		    $('#sumMark').text($('#sumMark').text()-tempScore+parseInt(score));
			$(this).next().find(".intext").val(score);
		});
	
		 $(".intext").blur(function(){
				var demo=$(this).attr('grade');
			    if($(this).val()==""){
			    	$('#sumMark').text($('#sumMark').text()-parseInt($(this).parent().parent().parent().find('.middle.aligned').val()));
			    	$(this).val('0');
			    	$(this).parent().parent().parent().find('.middle.aligned').val(0)
			    	return;
			    }
				if(isNaN($(this).val())){
					$('#sumMark').text($('#sumMark').text()-parseInt($(this).parent().parent().parent().find('.middle.aligned').val()));
				      $(this).val('0');
				      $(this).parent().parent().parent().find('.middle.aligned').val(0)
				      return;
				};
				
				
				if(($(this).val()-demo)>0){
					$('#sumMark').text($('#sumMark').text()-parseInt($(this).parent().parent().parent().find('.middle.aligned').val()));
				   $(this).val('0');
				   $(this).parent().parent().parent().find('.middle.aligned').val(0)
				   return;
				}
				var score = $(this).val();
				score = parseInt(score);
				$(this).val(score);
				var temp =  $(this).parent().parent().parent().find('.middle.aligned').val();
				$('#sumMark').text($('#sumMark').text()-temp+score);
				$(this).parent().parent().parent().find('.middle.aligned').val(score)
			}); 
		 if(b==1){
			 $.ajax({
					url:"do?invoke=Tea_commentclass@getclassmark",
					type:"POST",
					dataType:"json",
					data:{
						task_no:task_no
					},
					success:function(pxmark){
						if(pxmark.result==0){
							$.alert("",pxmark.meeage);
							location.href='/QualityMonitor2/qm/teacher/tea_commentclass.jsp'
							return;
						}
						else{
						    var mark=pxmark
						    var summark1 = 0;
							for(var i=0;i<mark.length-1;i++){
							  
							    $('.intext[fieldname='+mark[i].rule_field+']').val(mark[i].rule_per);
							summark1+=parseInt(mark[i].rule_per)
							}
							    $('.intext').blur();        
							}
							    $("#xxjy").val(mark[mark.length-1].xxjy);
							    $("#sumMark").text(summark1)
					}
		     }); 
		 } 
		  $('.pxclicka').removeAttr("disabled");
	      $('.pxclicka[task_no='+task_no+']').removeClass('loading');
		 writedata(task_no,b);
	}
    
		//数据传递
	function writedata(task_no,b){
			$("#btnsubmit").click(function(){
				if($(this).hasClass("loading"))return;
				$("#btnsubmit").addClass("loading");
				postFormData(task_no);
			});
		   function postFormData(task_no){
				var o={
					fields:"",
					total:0,
					xxjy:"",
					task_no:""
				};
				
				var items=$(".intext");
				for(var i=0;i<items.length;i++){
					var item=items[i];
					var c=$(item).val();
					   if(c==""){
						   $.alert("","存在未评分项，请填写完再提交");
						   $("#btnsubmit").removeClass("loading");
						   return;
					   }
					   if(c){
						   var rowfield=  $(items[i]).attr("fieldname");
							 if(o.fields==""){
								 o.fields+=rowfield;
							 }else{
								 o.fields+=","+rowfield;
							 }
							 o[rowfield]=c;
						 o.total+=parseInt(c);
					   }
				}
				o.xxjy=$("#xxjy").val();
				o.task_no=task_no;
				if(o.xxjy=="" ){
					$.confirm({
						msg       :"您没有填写班级学习建议，确认给该班级评 <b>"+o.total+"</b> 分吗？",
						btnSure   : '确认提交 ',
						btnCancel : '继续填写',
						sureDo	  : function(){
							if(b==0)
							postdata(o);
							if(b==1)
							changedata(o)
							$("#left").removeClass("eight wide column");
							$("#left").transition("fly right in")
							$("#right").html("");
						},
						cancelDo:function(){
							$("#btnsubmit").removeClass("loading");
						}
					});
					return ;
				}else{
					$.confirm({
						msg       :"您确定要给该班级评 "+o.total+" 分吗？",
						btnSure   : '确认提交 ',
						btnCancel : '重新填写',
						sureDo	  : function(){
							if(b==0)
							postdata(o);
							if(b==1)
							changedata(o)
							$("#left").removeClass("eight wide column");
							$("#left").transition("fly right in")
							$("#right").html("");
						},
						cancelDo:function(){
							$("#btnsubmit").removeClass("loading");
						}
					});
				}
				
			}
		   <%
			String rootpath = new PropertyConfig("sysConfig.properties").getValue("rootpath");
			%>
			function postdata(o){
				$.ajax({
					url:"do?invoke=Tea_commentclass@postListen",
					type:'POST',
					dataType:'json',
					data:o,
					success:function(rep){
						$.alert("",rep.message);
						$("#btnsubmit").removeClass("loading");
						$('#doubling').html('');
						if(rep.result==1){
							if(rep.data[0].main_tea=="" || rep.data[0].main_tea==null){
								$.alert("暂无班主任信息，无法发送消息")
							}else{
								new $.getPort({
									config:{
										tourl:"postInfData.interface", 
										inf_type:"教师评学", 
										inf_importance:"0",
										inf_content:""+rep.data[0].course_name+"的"+rep.data[0].teacher_name+"教师给"+rep.data[0].class_name+"打了"+o.total+"分",
										inf_post:"质量监控平台",
										inf_get_name:"质量监控平台",
										inf_get:rep.data[0].teacher_no,
										inf_system:'qm',
										inf_return_url:'<%=rootpath%>'+"qm/student/classcheckpx.jsp?module=13&menu=63",
									},
									callback:function(rep){
										if(rep.result == '0'){
											console.log("信息发送失败")
										}else{
										
										}
									}
								});	
							}
					}
						loadtable();
					}
				});
			}
			function changedata(o){
				$.ajax({
					url:"do?invoke=Tea_commentclass@postchangeListen",
					type:'POST',
					dataType:'json',
					data:o,
					success:function(rep){
						$.alert("",rep.message);
						$("#btnsubmit").removeClass("loading");
						$('#doubling').html(''); 
						if(rep.result==1){
							if(rep.data[0].main_tea=="" || rep.data[0].main_tea==null){
								$.alert("暂无班主任信息，无法发送消息")
							}else{
								new $.getPort({
									config:{
										tourl:"postInfData.interface", 
										inf_type:"教师评学", 
										inf_importance:"0",
										inf_content:""+rep.data[0].course_name+"的"+rep.data[0].teacher_name+"教师将"+rep.data[0].class_name+"的评学分数修改为"+o.total+"",
										inf_post:"质量监控平台",
										inf_get_name:"质量监控平台",
										inf_get:rep.data[0].teacher_no,
										inf_system:'qm',
										inf_return_url:'<%=rootpath%>'+"qm/student/classcheckpx.jsp?module=13&menu=63",
									},
									callback:function(rep){
										if(rep.result == '0'){
											console.log("信息发送失败")
										}else{
										
										}
									}
								});	
							}
						}
						loadtable();
					}
				});
			}
	};
}); 
</script>
<!--这里引用其他JS-->
</html>