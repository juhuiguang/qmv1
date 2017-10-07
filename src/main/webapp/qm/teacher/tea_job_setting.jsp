<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp" %>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp" %>
<!--这里引用其他样式-->
<title>欢迎使用-首页</title>
<style>
	.ui.mini.dropdown.selection { 
		display: block;  
		width: 28%;
	}
	#postMenu {
		min-width: 28%;
	}
	#TeaSearch {
		top: 142px;
	    left: 50%; 
		display: inline-block; 
		width: 30%;  
		position:absolute;
	}
	#segmentPanel {
		top: 190px;
	    left: 30%; 
		display: inline-block; 
		width: 70%;  
		position:absolute; 
		overflow-y:auto;  
	} 
	.bq {
		display: inline-block; 
		width:auto;
	    vertical-align: baseline;  
	    font-size: .92857143em;
	    font-weight: 700;
	    color: rgba(0,0,0,.87); 
	    text-transform: none; 
	}
	.bq.postname {
		margin-top: 15px;
    	margin-left: 11%;
	}
	.bq.posttea {
		margin-top: 15px;
    	margin-left: 44%; 
	}
	.bq.searchtea {
		margin-left: -180px;
    	margin-right: 10px;
	}
	#PostTeachers .item { 
		display:inline-block;
		margin-right:10px;
	    border-radius: 5px;
	    background-color: #F7F7F7;
	    text-indent: 1.5em;
	    line-height: 1.5;
	    width: 20% !important;
	    padding-bottom: 5px;
	    padding-top: 5px;
	    margin-bottom: 5px; 
	    position: relative;
	}    
	#PostTeachers .item:hover {
		background-color: #F1F1F1;
	} 
	.jobtealabel {
		width: 70% !important;
	}
	.remove.icon.teasingl {
		top: 4px;
	    right: 25px;
	    color:#6B6B6B;
	    position: absolute;
	}
	.remove.icon.teasingl:hover {
		cursor:pointer; 
		color:#DB2828;
	}
	#searchicon {
		margin-left: -62px;             
	}
	#SeaPanelTea {
		position: absolute;
	    top: 140px;
	    left: 810px;
	}
	#ShowAllTeas {
		float: right;
	}
	#ShowAllTeas:hover {
		cursor:pointer; 
		color:#2185D0;
	}
	
</style>
</head>
<body>
<%@ include file="/commonjsp/header.jsp"%>
	<div id="container" class="ui container"> 
	<div style="position:relative;">
		<h3  class="ui header "> 
	  			<i class="list layout icon"></i>
	  			<div class="content">教师岗位设置</div>
		</h3>
		
		<select class="ui mini dropdown" id="dropdown">
		</select>
		
		<label class="bq postname">岗位名称</label> 
		<label class="bq posttea">所属教师</label> 
		 
		<div class="ui vertical pointing menu" id="postMenu">
		
		</div>
		
		<div class="ui small search" id="TeaSearch">     	
 			<label class="bq searchtea">为此岗位添加教师</label>  		    
			<div class="ui icon input"  style="width: 210px;">
				<input class="prompt" type="text" id="SeaTeas" placeholder="输入教师姓名工号添加">
				<i class="search icon"></i>
			</div>    
		    <div class="results">         
			</div>
		</div>    
		
		<div class="ui search" id="SeaPanelTea"> 
	  		<div class="ui icon input" style="width: 170px;">    
			    <input class="prompt" id="SearchPanelTea" type="text" placeholder="搜索下列教师"> 
			</div>         
			<button class="circular ui basic mini button"  id="searchicon" data-content="点击搜索此岗位的教师" data-variation="small"><i class="search large icon"></i></button>
		</div>
		     
		<div class="stretched column" id="segmentPanel">
		    <div class="ui segment" id="PostTeachers">

		    </div>
		</div> 
 
	<!--这里绘制页面-->
	</div>
	</div>
</body>
<script src="script/common/alert/jquery.alert.js" type="text/javascript"></script>
<script>
	 $(function() {
		 var termid= ""; 
		 var postD = "";
		 var job_no = ""; 
		 var PostTeas = "";
		 var AllTeas = "";
		 var flag = 0;
		 var allteaD = [];
		 downAllTerm(); 
		 $("#searchicon").popup(); 
		//取岗位数据 
//		 readPostData(); 
		
		//搜索当前岗位已有教师中的某位教师 
		 ClickSeaButPanel();
		
		 function readPostData() { 
			 $.ajax({
				 url: "do?invoke=postSetManage@getPostInfor",
				 type: 'POST',
				 dataType: 'json',
				 success: function(rep) {
					 if(rep.result == 0) {
						 $.alert("暂没有获取到岗位相关信息！"); 
					 } else {
						 console.log(rep);   
						 postD = rep.data;
						 job_no = postD[0].job_no;
						  
						 //画左侧岗位栏
						 drawLeftPostMenu();
					 }
					 
				 }
			 });
		 }
		 
		
		  
		//画左侧岗位栏 
		function drawLeftPostMenu() {  
			var dom = '<a class="item active" id="'+postD[0].job_no+'">'+postD[0].job_name+'</a>';
			for(var i=1; i<postD.length; i++) {  				
				dom +=
					'<a class="item" id="'+postD[i].job_no+'">'+postD[i].job_name+'</a>';
			} 
			$("#postMenu").append($(dom));
			
			//根据点击的岗位号去学期教师表中获取对应的老师有及所有的老师
			 readPostTeaData();
			
			$('#postMenu a.item').unbind('click').click(function(){ 
				 $('#postMenu a.item.active').removeClass('active');
				 $(this).addClass('active');   
				 job_no = $(this).attr("id");
				 
				 //根据点击的岗位号去学期教师表中获取对应的老师有及所有的老师
				 readPostTeaData();
			 });
			
		 }
		
		function readPostTeaData(){   
			$.ajax({
    			 url:"do?invoke=supervisorPostTeaManage@getPostTeaInfor",
				 type: 'POST',
				 dataType: 'json',
				 data:{
					 job_no:job_no, 
					 term_no:termid
				 },
				 success: function(rep) {
					 console.log(rep);   
					 if(rep.jobteas.result == 0) {
						$.alert("此岗位暂未设置所属教师，您可以设置添加！");
						$("#PostTeachers").empty();   
						$('.ui.segment').css({'min-height':'70px'});     
						PostTeas = "";     
						
						AllTeas = rep.allteas.data;
						//所有岗位为空的教师
							allteaD = [];
							for(var j=0; j<AllTeas.length; j++) {
								allteaD[j] =
									{
										title:AllTeas[j].teacher_name,
										description:AllTeas[j].teacher_no,
										price:AllTeas[j].dep_name, 
										"id":AllTeas[j].teacher_no 
									};
							}
							
							$("#TeaSearch").search({
								cache:false,   
								source:allteaD,
								maxResults:5,        
								onSelect:function(itemteacher,rep) {
									//画新添教师的标签
									DrawAddTeaLabel(itemteacher);
								}
							});  
						 
					 } else {
						 PostTeas = rep.jobteas.data; 
						 AllTeas = rep.allteas.data;

						 //所有岗位为空的教师
							allteaD = [];
							for(var j=0; j<AllTeas.length; j++) {
								allteaD[j] =
									{
										title:AllTeas[j].teacher_name,
										description:AllTeas[j].teacher_no,
										price:AllTeas[j].dep_name, 
										"id":AllTeas[j].teacher_no 
									};
							}
							
							$("#TeaSearch").search({
								cache:false,   
								source:allteaD,
								maxResults:5,        
								onSelect:function(itemteacher,rep) {
									//画新添教师的标签
									DrawAddTeaLabel(itemteacher);
								}
							});           
							
						 //画各个岗位的教师      
						 drawPostTeaD(); 
					 }
					 
				 }
			});
		}
		 
		function drawPostTeaD() {
			$("#PostTeachers").empty();
			
			//该岗位原有教师
			for(var i=0; i<PostTeas.length; i++) {   
 				if(PostTeas.length > 100) {
	//				$('#segmentPanel').css({'overflow-y':'scroll', 'height':'89%'});  
					$('#segmentPanel').css({'height':'89%'});    
				} 
 				var dom = "";  
 				if(PostTeas[i].teacher_status == 0) {
					dom =  
						'<div class="item" id="'+PostTeas[i].teacher_no+'" style="background-color:#FDF0F0"><label class="jobtealabel">'+PostTeas[i].teacher_name+'</label><i class="remove icon teasingl" id="'+PostTeas[i].teacher_no+'"></i></div>'; 
				} else {
					dom =
						'<div class="item" id="'+PostTeas[i].teacher_no+'"><label class="jobtealabel">'+PostTeas[i].teacher_name+'</label><i class="remove icon teasingl" id="'+PostTeas[i].teacher_no+'"></i></div>'; 
				}
				$("#PostTeachers").append($(dom));     
			}   
			
			//点击教师标签的删除图标
			$('#PostTeachers .teasingl').unbind('click').click(function(){
				var tea_no = $(this).attr("id");
				console.log(tea_no);  
				//删除岗位的某位教师
				DelSinglTeaPost(tea_no);
			});
			
	/* 		//所有岗位为空的教师
			allteaD = [];     
			for(var j=0; j<AllTeas.length; j++) {
				allteaD[j] =
					{
						title:AllTeas[j].teacher_name,
						description:AllTeas[j].teacher_no,
						price:AllTeas[j].dep_name, 
						"id":AllTeas[j].teacher_no 
					};
			}
			$("#TeaSearch").search({
				source:allteaD,      
				maxResults:5,        
				onSelect:function(itemteacher,rep) {
					//画新添教师的标签
					DrawAddTeaLabel(itemteacher);
				}
			}); */
			
		}
		
		function ClickSeaButPanel() {
			$("#searchicon").unbind('click').click(function(){
				$("#PostTeachers").empty();  
				var tea = $("#SearchPanelTea").val();
				for(var i=0; i<PostTeas.length; i++){
					if(tea == PostTeas[i].teacher_name || tea == PostTeas[i].teacher_no) {
						var dom = "";
						if(PostTeas[i].teacher_status == 0) {
							dom =  
								'<div class="item" id="'+PostTeas[i].teacher_no+'" style="background-color:#FDF0F0"><label class="jobtealabel">'+PostTeas[i].teacher_name+'</label><i class="remove icon teasingl" id="'+PostTeas[i].teacher_no+'"></i></div>'; 
						} else {
							dom = 
								'<div class="item" id="'+PostTeas[i].teacher_no+'"><label class="jobtealabel">'+PostTeas[i].teacher_name+'</label><i class="remove icon teasingl" id="'+PostTeas[i].teacher_no+'"></i></div>'; 
						}
						$("#PostTeachers").append($(dom)); 
					} else {
						$('.ui.segment').css({'min-height':'70px'});   
					}  
				}    
				$("#PostTeachers").append($('<i class="angle large double left icon" id="ShowAllTeas" data-content="点击返回" data-variation="small"></i>')); 
				tea = $("#SearchPanelTea").val(""); 
				
	//			$("#ShowAllTeas").popup();
	 			$("#ShowAllTeas").unbind('click').click(function(){
					drawPostTeaD();  
				});
				
				//点击教师标签的删除图标
				$('#PostTeachers .teasingl').unbind('click').click(function(){
					var tea_no = $(this).attr("id");
					flag = 1;
					console.log(tea_no);   
					//删除岗位的某位教师
					DelSinglTeaPost(tea_no);
				});
				
			});
		}
		
		function DrawAddTeaLabel(item) {
			$.ajax({
				url:"do?invoke=supervisorPostTeaManage@AddSinglTeaPost",
				 type: 'POST',
				 dataType: 'json',
				 data:{
					 job_no:job_no, 
					 term_no:termid,
					 tea_no:item.description
				 },
				 success: function(rep) { 
					 if(rep.result == 0) {
//						 $.alert("本岗位此教师添加失败！");
						 $.alert(rep.message);  
						 return;
					 } else {
						 var dom =
								'<div class="item" id="'+item.description+'"><label class="jobtealabel">'+item.title+'</label><i class="remove icon teasingl" id="'+item.description+'"></i></div>'; 
						 $("#PostTeachers").append($(dom));   
					 }
					//点击教师标签的删除图标
						$('#PostTeachers .teasingl').unbind('click').click(function(){
							var tea_no = $(this).attr("id");
							console.log(tea_no);   
							//删除岗位的某位教师
							DelSinglTeaPost(tea_no);
						});
				 }
			});
			
		}
		
		function DelSinglTeaPost(tea_no) {
			$.confirm({
				msg          :"您确定要删除本岗位的此教师么？",       
				btnSure     :'确定',
				btnCancel  :'取消',   
				sureDo       : function(){
					$.ajax({
			   			 url:"do?invoke=supervisorPostTeaManage@DelSinglTeaPostD",
							 type: 'POST',
							 dataType: 'json',
							 data:{
								 job_no:job_no,  
								 term_no:termid,
								 tea_no:tea_no
							 },
							 success: function(rep) { 
								 if(rep.result == 0) {
									 $.alert("本岗位此教师删除失败");   
								 } else {  
									 if(flag == 1) { 
				//						$('.ui.segment').css('height','50px');         两种写法 
										$('.ui.segment').css({'min-height':'70px'});   
									 }	    
									 $('#PostTeachers .item#'+tea_no+'').remove();  
									 flag = 0; 
								 }        
							 }
						}); 
				},
				cancelDo:function(){
					
				}
			});
								
		}   
		 
		 
	     function downAllTerm(){
	    	$.ajax({
				url:"do?invoke=supervisorViewListen@getAllTerm",
				type:'POST',
				dataType:'json',
				success:function(rep){
					if(rep.result==0){
						$.alert("",rep.message);
						return;
					} else {
						var temp=rep.data;
						
						for(var i=0;i<temp.length;i++){
							var dom= '<option value="'+temp[i].term_no+'">'+temp[i].term_name+'</option>';
							$("#dropdown").prepend(dom);
						}
						$('.ui.dropdown').dropdown();
					}
					termid = temp[temp.length-1].term_no;              
					console.log(termid); 
					readPostData();  
					
					$("#dropdown").change(function(){ 
						termid=$("#dropdown").val();       		   
						readPostTeaData();   				
					});
				}  
	    	});       
	    }
	 });
</script>
<!--这里引用其他JS-->
</html>