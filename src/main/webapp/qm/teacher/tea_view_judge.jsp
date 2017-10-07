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
.ui.cards{
width:95%;          
} 
.ui.very.basic.collapsing.celled.table{  
width:90%;  
margin-left:5%;
}
.xnpjf{ 
margin-left:40%;  
}
.dd{
margin-left:10%; 
}

</style>     
</head>  
<body>
<%@ include file="/commonjsp/header.jsp"%>
	<div id="container" >
		<div class="ui "> 
	    <h3 class="ui header" id='grbtkjl'> 
		  <i class="tasks icon"></i>
		  <div class="content">个人教学质量考核 </div>    
		</h3> 
	   	   
		</div> 
	</div>
	<!--这里绘制页面-->
</body> 
<script>  
	$(function() { 
		var SYSOBJCET=<%=SYSOBJCET%>;  
		var USEROBJECT=<%=USEROBJECT%>;  
		var term_no=SYSOBJCET.term_no;
		var tea_no=USEROBJECT.loginname;   
		var dep_no=USEROBJECT.userinfo.dep_no; 
		loadyear();
		loadtermInf();  //初始化下拉框和当前学期信息  

		function loadyear(){
			$.ajax({ 
				url:"do?invoke=teacherViewJudge@getyearInf", 
				type:'POST',  
				dataType:'json',   
				success:function(rep){ 
					
					var yearinf=rep.data; 
					for(var i=0;i<yearinf.length;i++){ 
						  
						var dom='<div class="ui segment yearinf" style = "width:43%;float:left;margin-right:5%;margin-bottom:8px;padding-bottom:5px;" id="segment'+yearinf[i].year_no+'">'+     
							  '<h4 class="ui left floated header"><i class="attach large icon"></i>'+yearinf[i].year_no+'年</h4>'+ 
							
							  '<i class="dd">等第：<i class="grand"></i></i>'+ 
							 '<div class="ui clearing divider grandinf"></div>'+       
							'<div class="ui two cards grandinf" id="year'+yearinf[i].year_no+'">'+ 
							'</div>'+ 
							'</div>'; 
							
						$('#container').append($(dom));
						loadgrand(yearinf[i].year_no,tea_no ,dep_no);//初始化等地、平均分  
						
						$('#segment'+yearinf[i].year_no+'').find('.ui.grandinf').hide();     
						
						
					}
				}
			});
		}
		function loadtermInf(){   //提取学期     
			
			$.ajax({
				url:"do?invoke=teacherViewJudge@getTermInf", 
				type:'POST',  
				dataType:'json',    
				data:{
					tea_no:tea_no,
				},
				success:function(rep){
					if(rep.result==0){ 
						 $('.ui.segment.yearinf').hide();  
						  var dom='<div class="ui green large message" id="messageinf">'+
							'<i class="announcement large inverted yellow up circular icon"></i>'+
								' 目前还没有你的考核记录哦！'+     
							'</div>';  

							$('#container').append($(dom)); 
					}else{
						 console.log(rep); 
						var table=rep.data;
						for(var i=0;i<table.length;i++){ 
							var card= 
								'<div class="ui card">'+  
										  '<div class="content term">'+
								    '<i class="remove bookmark large icon"></i> '+table[i].term_name+''+ 
								   '</div> '+
								  '<div class="content table">'+
								  	'<table class="ui very basic collapsing celled table">'+
									 ' <tbody>';
									 card+='<tr >'+ 
									      '<td >得分</td>'+         
									      '<td class="sumgrand">'+table[i].table_content[0].total+'</td>'+
										    '</tr>'+   
									      	'</tbody>'+ 
											'</table>'+ 
									 		 '</div> '+
											'</div>';
											var year=table[i].term_no.substring(0,4);
											 
											if(table[i].term_no.substring(4,5)=="1"){
												var year_=parseInt(year)+1;
												$('#year'+year_+'').append($(card)); 
											}else{ 
												$('#year'+year+'').append($(card));
											}
									   
						} 
					}
					/* $('.ui.segment.yearinf').unbind('click').click(function(){
						$(this).find('.ui.grandinf').transition('fade down');            
					})   */
				} 
			}); 
		} 
		function loadgrand(year_no,tea_no,dep_no){
			 
			$.ajax({  
				url:"do?invoke=teacherViewJudge@getgrand",  
				type:'POST',  
				dataType:'json',  
				 
				data:{ 
					year_no:year_no, 
					tea_no:tea_no,
					dep_no:dep_no,
				},
				success:function(rep){  
					
					
					if(rep.result==0){ 
						
						$('#segment'+year_no+'').remove();//隐藏整个学年     
					}else{
						var grandinf=rep.data;
						var average=Math.round(parseFloat(grandinf[0].average)*100)/100; 
						$('#segment'+year_no+'').find('.average').text(average);   
						if(grandinf[0].grand=='优秀'){      
							var lable='<a class="ui red right corner label ">'+ 
						        '<i class="thumbs up icon"></i>'+                 
						        '</a>';   
							$('#segment'+year_no+'').append($(lable));  
						}
						if(grandinf[0].grand=='良好'){      
							var lable='<a class="ui orange right corner label ">'+ 
						        '<i class="smile icon"></i>'+               
						        '</a>';   
							$('#segment'+year_no+'').append($(lable));        
						}
						if(grandinf[0].grand=='及格'){      
							var lable='<a class="ui green right corner label ">'+  
						        '<i class="checkmark icon"></i>'+               
						        '</a>'; 
							$('#segment'+year_no+'').append($(lable));       
						}
						$('#segment'+year_no+'').find('.grand').text(grandinf[0].grand);    
					}
				}
			});
		}
	});//JQ
	//--------------------------

</script>
<!--这里引用其他JS-->
</html>