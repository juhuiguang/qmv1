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
.ui.container.segment .button{ 
	margin-top:10px;  
	margin-right:10px;
} 
.xnpjf{ 
margin-left:40%;  
}
.dd{ 
margin-left:10%; 
} 
#selectyear{
    
width:20%;    
}

#tableinf{ 
width:100%; 
}
#mychart{   
width:85%;   
}  
#divider{  
width:80%;
margin-left:10%; 
margin-bottom:30px;     	 
 
}
.ui.very.basic.collapsing.celled.table{  
width:90%;  
margin-left:5%;
} 
</style>      
</head>   
<body>
<script src="script/common/echarts/echarts-all.js"></script>   
<%@ include file="/commonjsp/header.jsp"%>
	<div id="container" >
		
		<div class="ui ">
	    <h3 class="ui header" id='tittle'> 
		  <i class="tasks icon"></i>
		  <div class="content">教学质量考核 ——学年统计</div>     
		</h3> 
	   	   
	   	   <div class="ui fluid selection dropdown" id="selectyear"> 
				<i class="dropdown icon"></i> <span class="default text">请先选择课程</span>
				<div class="menu infro"></div>
			</div> 
			 
		</div> 
		<div class="ui segment" id="chartsegment">
			<div id="mychart"style="height:400px" ></div> 
		</div>   
	<h4 class="ui horizontal divider header" id="divider"> <i id="grandinf">教师年度考核详情</i></h4>    
	<table class="ui compact blue striped table " id="tableinf">         
			<tbody>   
				<tr>
					<td>教师工号</td>
					<td>教师姓名</td> 
					<td>教师职称</td>
					<td>年平均得分</td>
					<td>考核等第</td>  
					<td>查看详情</td> 
				</tr>


			</tbody>
		</table>
	    
	    <div class="ui  modal long"> 
		  <i class="close icon"></i> 
		  <div class="content grand">
		  
		    
		  </div> 
		</div>   
	
	</div>
	<!--这里绘制页面-->
</body> 
<script>  
	$(function() { 
		 $('#tableinf').hide();  
		 $("#divider").hide();
		var SYSOBJCET=<%=SYSOBJCET%>; 
		var term_no=SYSOBJCET.term_no;
		
		var dep_no=USEROBJECT.userinfo.dep_no; 
		var dep_name=USEROBJECT.userinfo.dep_name;
		var myDate = new Date();
		var year_no=myDate.getFullYear(); 
		
		var year_No=year_no; 
		loadyear(year_no,dep_no);
		function loadyear(year_no,dep_no){
			$.ajax({ 
				url:"do?invoke=masterJudgeChart@getyearInf", 
				type:'POST',  
				dataType:'json',   
				success:function(rep){ 
					 if(rep.result==0){
						 var dom='<div class="ui green large message" id="messageinf">'+
							'<i class="announcement large inverted yellow up circular icon"></i>'+
								' 没有学期信息'+   
							'</div>';

							$('#container').append($(dom));
					 }else{
					  
						 var yearinf = rep.data; 
						 for(var i = 0; i < yearinf.length; i++){
							 var year = '<div class="item yearinf" name="'+yearinf[i].year_no+'">'+
								 		yearinf[i].year_no +'年</div>';  
										$(".menu.infro").append($(year));   
							if (yearinf[i].year_no == year_no) { 
								
								loadchart(year_no , dep_no );//初始化图表
								$(".default.text").text(yearinf[i].year_no+'年');     
							}
						 }
						 $('.ui.dropdown').dropdown();  
						$('.item.yearinf').unbind('click').click(function(){ 	//学年点击事件  
							$('#messageinf').remove();  
							var Year_no=$(this).attr("name"); 
							year_No=Year_no;
							 $('#tableinf').hide();   
							 $("#divider").hide();
							loadchart(Year_no,dep_no );//初始化图表 
						}) 
					 }
				}
			}); 
		}
		function loadchart(year_no,dep_no ){ 
			 
			$.ajax({ 
				url:"do?invoke=masterJudgeChart@getgrand",   
				type:'POST',  
				dataType:'json', 
				data:{
					year_no:year_no, 
					dep_no:dep_no, 
				}, 
				success:function(rep){ 
					console.log(rep);
					if(rep.result==0){  
						$('#mychart').hide(); 
						var dom='<div class="ui green large message" id="messageinf">'+
						'<i class="announcement large inverted yellow up circular icon"></i>'+
							'  该部门教师尚未进行考核！'+     
						'</div>';

						$('#chartsegment').append($(dom)); 
					}else{  
						$('#mychart').show();   
						
						var chartinf=rep.data; 
						var myChart = echarts.init(document.getElementById('mychart')); 
						 var dataStyle = {
								    normal: {
								        label: {show:false},
								        labelLine: {show:false}
								    }
								};  
								var placeHolderStyle = {
								    normal : {
								        color: 'rgba(0,0,0,0)',
								        label: {show:false},
								        labelLine: {show:false}
								    },
								    emphasis : {
								        color: 'rgba(0,0,0,0)'
								    }
								};
							var option = {
									    title: {
									        text: '教师考核汇总', 
									        subtext: dep_name,
									        x: 'center',
									        y: 'center',
									        itemGap: 20,
									        textStyle : {
									            color : 'rgba(30,144,255,0.8)',
									            fontFamily : '微软雅黑',
									            fontSize : 20,   
									            fontWeight : 'bolder' 
									        }
									    },
									    tooltip : {
									        show: true, 
									        formatter: "{b}:({d}%)" 
									    },
									    legend: {
									        orient : 'vertical',
									        x : document.getElementById('mychart').offsetWidth / 2,
									        y : 45,
									        itemGap:12,
									        data:['及格教师'+chartinf[chartinf.length-1].jige_tea+'人','良好教师'+chartinf[chartinf.length-1].lianghao_tea+'人','优秀教师'+chartinf[chartinf.length-1].youxiu_tea+'人'] 
									    },
									    toolbox: {
									        show : true,
									        feature : {
									            mark : {show: true},
									            dataView : {show: true, readOnly: false},
									            restore : {show: true},
									            saveAsImage : {show: true}
									        }
									    },
									    series : [
									        {
									            name:'1',
									            type:'pie',
									            clockWise:false,
									            radius : [125, 150],
									            itemStyle : dataStyle, 
									            data:[
									                {
									                    value:parseInt(chartinf[chartinf.length-1].jige_tea),
									                    name:'及格教师'+chartinf[chartinf.length-1].jige_tea+'人'
									                }, 
									                {
									                    value:chartinf.length-1-parseInt(chartinf[chartinf.length-1].jige_tea),
									                    name:chartinf.length-1-parseInt(chartinf[chartinf.length-1].jige_tea), 
									                    itemStyle : placeHolderStyle 
									                }
									            ]
									        },
									        {
									            name:'2',
									            type:'pie',
									            clockWise:false,
									            radius : [100, 125],
									            itemStyle : dataStyle,
									            data:[
									                {
									                    value:parseInt(chartinf[chartinf.length-1].lianghao_tea), 
									                    name:'良好教师'+chartinf[chartinf.length-1].lianghao_tea+'人'
									                },
									                {
									                    value:chartinf.length-1-parseInt(chartinf[chartinf.length-1].lianghao_tea),
									                    name:chartinf.length-1-parseInt(chartinf[chartinf.length-1].lianghao_tea),
									                    itemStyle : placeHolderStyle
									                }
									            ]
									        },
									        {
									            name:'3', 
									            type:'pie',
									            clockWise:false,
									            radius : [75, 100],
									            itemStyle : dataStyle,
									            data:[
									                {
									                    value:parseInt(chartinf[chartinf.length-1].youxiu_tea), 
									                    name:'优秀教师'+chartinf[chartinf.length-1].youxiu_tea+'人' 
									                },
									                {
									                    value:chartinf.length-1-parseInt(chartinf[chartinf.length-1].youxiu_tea),  
									                    name:chartinf.length-1-parseInt(chartinf[chartinf.length-1].youxiu_tea),  
									                    itemStyle : placeHolderStyle
									                } 
									            ] 
									        }  
									    ]  
									};
							myChart.setOption(option); 
							 myChart.on(echarts.config.EVENT.CLICK,function(item){  //点击图表  
									 $('#tableinf').show();  
									 $("#divider").show(); 
								 var t=setTimeout("window.scrollTo(0,550)",300);       
				    	    	   $('.teacherinf').remove();     
				    	    	   loaditem(year_no,item.seriesName ,chartinf);  
				    	    	  
				    	      });  
							
					}
					
				}
			});
		}
		 function loaditem(year_no,set , chartinf){ 
			  
			 if(set=='1'){
				    
				 for(var i=0;i<chartinf.length-1;i++){
					 if(chartinf[i].grand=='及格'){
						 var average=Math.round(parseFloat(chartinf[i].average)*100)/100;
						 var dom='<tr class="teacherinf">'+ 
						 '<td class="teacher_no" name="'+chartinf[i].teacher_no+'">'+chartinf[i].teacher_no+'</td>'+
							'<td class="teacher_name">'+chartinf[i].teacher_name+'</td>'+ 
							'<td class="teacher_title" name="'+chartinf[i].teacher_title+'">'+chartinf[i].teacher_title+'</td>'+
							'<td class="teacher_average" name="'+chartinf[i].average+'">'+average+'</td>'+   
							'<td class="teacher_grand" name="'+chartinf[i].grand+'"><div class="ui button change small orange">'+chartinf[i].grand+'</div>'+
							 
							'<div class="ui flowing popup top left transition visible animating scale out">'+
							  '<div class="ui three column divided center aligned grid">'+
							  '<div class="column">'+  
						      '<div class="ui button grade green">优秀</div>'+
						    '</div>'+
						    '<div class="column">'+  
						    
						      '<div class="ui button grade teal">良好</div>'+ 
						    '</div>'+ 
						   '<div class="column">'+  
						      
						      '<div class="ui button grade orange">及格</div>'+
						    '</div>'+ 
							  '</div>'+
							  '</div>'+
							'</td>'+  
								'<td><div class="btnfirst circular ui small blue basic icon button">'+ 
								'<i class="file text icon"></i>'+
								'</div></td>'+     
							'</tr>';
						 $('#tableinf').find('tbody').append($(dom));
					 }
				 }
			 }
			 if(set=='2'){ 
				 for(var i=0;i<chartinf.length-1;i++){
					if(chartinf[i].grand=='良好'){
						var average=Math.round(parseFloat(chartinf[i].average)*100)/100;
						 var dom='<tr class="teacherinf">'+ 
						 '<td class="teacher_no" name="'+chartinf[i].teacher_no+'">'+chartinf[i].teacher_no+'</td>'+
							'<td class="teacher_name">'+chartinf[i].teacher_name+'</td>'+   
							'<td class="teacher_title" name="'+chartinf[i].teacher_title+'">'+chartinf[i].teacher_title+'</td>'+
							'<td class="teacher_average" name="'+chartinf[i].average+'">'+average+'</td>'+   
							'<td class="teacher_grand" name="'+chartinf[i].grand+'"><div class="ui button change small teal">'+chartinf[i].grand+'</div>'+
							
							'<div class="ui flowing popup top left transition visible animating scale out">'+
							  '<div class="ui three column divided center aligned grid">'+
							  '<div class="column">'+ 
						      '<div class="ui button grade green">优秀</div>'+
						    '</div>'+
						    '<div class="column">'+ 
						    
						      '<div class="ui button grade teal">良好</div>'+ 
						    '</div>'+ 
						   '<div class="column">'+ 
						      
						      '<div class="ui button grade orange">及格</div>'+
						    '</div>'+ 
							  '</div>'+
							  '</div>'+
							'</td>'+
								'<td><div class="btnfirst circular ui small blue basic icon button">'+ 
								'<i class="file text icon"></i>'+
								'</div></td>'+     
							'</tr>';
						 $('#tableinf').find('tbody').append($(dom));
					 }
				 }		 
			 } 
			 if(set=='3'){
				   
 				for(var i=0;i<chartinf.length-1;i++){ 
 					if(chartinf[i].grand=='优秀'){
 						var average=Math.round(parseFloat(chartinf[i].average)*100)/100;
						 var dom='<tr class="teacherinf">'+ 
								'<td class="teacher_no" name="'+chartinf[i].teacher_no+'">'+chartinf[i].teacher_no+'</td>'+
								'<td class="teacher_name">'+chartinf[i].teacher_name+'</td>'+   
								'<td class="teacher_title" name="'+chartinf[i].teacher_title+'">'+chartinf[i].teacher_title+'</td>'+
								'<td class="teacher_average" name="'+chartinf[i].average+'">'+average+'</td>'+   
								'<td class="teacher_grand" name="'+chartinf[i].grand+'"><div class="ui button change small green">'+chartinf[i].grand+'</div>'+
								 
								'<div class="ui flowing popup top left transition visible animating scale out">'+
								  '<div class="ui three column divided center aligned grid">'+ 
								    '<div class="column">'+ 
								      '<div class="ui button grade green ">优秀</div>'+  
								    '</div>'+
								    '<div class="column">'+ 
								    
								      '<div class="ui button grade teal">良好</div>'+ 
								    '</div>'+ 
								   '<div class="column">'+
								       
								      '<div class="ui button grade orange">及格</div>'+
								    '</div>'+  
								  '</div>'+
								  '</div>'+
								  '</td>'+ 
								
								'<td><div class="btnfirst circular ui small blue basic icon button">'+ 
								'<i class="file text icon"></i>'+
								'</div></td>'+       
							'</tr>'; 
						 $('#tableinf').find('tbody').append($(dom));
					 }
				 }      
			 } 
			 
			 $('.ui.button.change')     
			  .popup({ 
				  hoverable: true,
				  delay: { 
			      hide: 200
			    }  });  
			$('.btnfirst.circular.ui.small.blue.basic.icon.button').unbind('click').click(function(){//点击查看详情
				$(".content.grand").empty();//清空弹出层
				var no_teacher= $(this).parent().prevAll('.teacher_no').attr("name");
				var average_teacher= $(this).parent().prevAll('.teacher_average').attr("name"); 
				var grand_teacher= $(this).parent().prevAll('.teacher_grand').attr("name");   
				    
				loaddetail(year_no,no_teacher , average_teacher , grand_teacher);//初始化弹出层
			}) 
			
			
			$('.ui.button.grade').unbind('click').click(function(){	//修改等第
				var tea_no=$(this).parents('.teacherinf').find('.teacher_no').attr("name");
				var grade=""; 
				if($(this).hasClass('green')){ 
					grade="优秀";   
					
					if($(this).parents('.teacherinf').find('.ui.button.change').hasClass('green')){
						 
					}else{ 
						 changegrade(tea_no , year_No , grade);
					   $(this).parents('.teacherinf').find('.ui.button.change').removeClass('teal').removeClass('orange').addClass('green').text('优秀');
					}
					
				}
				if($(this).hasClass('teal')){
					grade="良好";
					if($(this).parents('.teacherinf').find('.ui.button.change').hasClass('teal')){
						
					}else{
						 changegrade(tea_no , year_No , grade);
						$(this).parents('.teacherinf').find('.ui.button.change').removeClass('orange').removeClass('green').addClass('teal').text('良好');
					}
				}
				if($(this).hasClass('orange')){
					grade="及格";
					if($(this).parents('.teacherinf').find('.ui.button.change').hasClass('orange')){
						 
					}else{
						 changegrade(tea_no , year_No , grade);
						$(this).parents('.teacherinf').find('.ui.button.change').removeClass('teal').removeClass('green').addClass('orange').text('及格');
					} 
				}
			})
		 } 
		 
		 function loaddetail(year_no , teacher_no , average ,grand){
			 var Average=Math.round(parseFloat(average)*100)/100;
			 
			 var dom='<div class="ui segment yearinf" id="segment'+year_no+'">'+      
					  '<h4 class="ui left floated header"><i class="attach large icon"></i>'+year_no+'年</h4>'+ 
					  '<i class="xnpjf">年平均分：'+Average+'<i class="average"></i></i>'+
					  '<i class="dd">等第：'+grand+'<i class="grand"></i></i>'+  
					 '<div class="ui clearing divider grandinf"></div>'+         
					'<div class="ui two cards grandinf" id="yearcard">'+   
					'</div>'+ 
					'</div>';  
		
				$('.grand.content').append($(dom));   
				load_teacher_detail(year_no , teacher_no);
				//----------------------------------------------
				
				
				
		 }
		 function load_teacher_detail(year_no , teacher_no){   //提取学期     
				
				$.ajax({
					url:"do?invoke=masterJudgeChart@getTeacherInf", 
					type:'POST',  
					dataType:'json',   
					data:{
						year_no:year_no,   
						teacher_no:teacher_no
					}, 
					success:function(rep){
						if(rep.result==0){
							$.alert('暂无考核结果');
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
										 ' <thead>'+ 
										    '<tr>'+
											    '<th>评分标准</th>'+ 
											    '<th>得分</th>' + 
										 	 '</tr>'+
										  '</thead>'+
										 ' <tbody>';
										 
										 for(var j=0;j<table[i].table_rule.length;j++){
											var score=0;
											if(table[i].table_content[0][table[i].table_rule[j].rule_item_field]!=""&&table[i].table_content[0][table[i].table_rule[j].rule_item_field]!="0.0"){
												score=table[i].table_content[0][table[i].table_rule[j].rule_item_field];
											}
											 card+='<tr>'+ 
												      '<td>'+table[i].table_rule[j].rule_item_title+'('+table[i].table_rule[j].rule_item_formula+'%)'+' </td>'+  
												      '<td>'+score+' </td>'+   
												    '</tr>';   
												   
										 }
										 card+='<tr >'+ 
										      '<td >总分</td>'+         
										      '<td >'+table[i].table_content[0].total+'</td>'+
											    '</tr>'+   
										      	'</tbody>'+ 
												'</table>'+
										 		 '</div> '+ 
												'</div>';
											
										$('#yearcard').append($(card));     
							} 
							$('.modal.long') //弹出层初始化 
							  .modal('show')      
							; 
						} 
					}   
				}); 
			} 
		 
		 function changegrade(tea_no , year_no ,grade){
			 $.ajax({
					url:"do?invoke=masterJudgeChart@changegrade", 
					type:'POST',  
					dataType:'json',   
					data:{ 
						year_no:year_no,   
						teacher_no:tea_no,
						grade:grade,
					}, 
					success:function(rep){
						if(rep.result==0){ 
							$.alert('修改失败');
						}else{ 
							loadchart(year_No,dep_no );//初始化图表   
						} 
					}
			 });
		 }
	});//JQ 
	//--------------------------

</script>
<!--这里引用其他JS-->
</html>