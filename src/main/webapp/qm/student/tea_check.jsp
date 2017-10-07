<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<%
String rootpath = new PropertyConfig("sysConfig.properties").getValue("rootpath");
%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>
<script src="script/common/datepicker/jquery.datetimepicker.js"
	type="text/javascript"></script>
<link rel="stylesheet"
	href="script/common/datepicker/jquery.datetimepicker.css" /> 
<title>校内教学质量监控运行平台</title>
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport" />
<style>
	#container{   
		padding-top:104px !important;
		background:#fff;  
	}
	#checkTopBar{
		z-index:999;
	}
	#tea_check_table tbody tr .courseTD{ 
		padding:0px !important;   
		width:20%;  
		background:#FCFFF5 ;
	}  
	.nowSetTd{
		background:#FCFFF5 !important ;
		color:#3B713B !important;
	}
	.nowSetTd .courseName{ 
		color:#3B713B !important; 
	} 
	.nowSetTd .courseAddr{   
		color:#3B713B !important;
	}
	.setTD{
		vertical-align:middle !important;
		width:20px;
		background:#f9fafb;
		line-height:1.2; 
	}
	.courseSet{ 
		color:#3B713B;
		padding:8px; 
	}  
	.courseSet .content{ 
		margin-top:6px; 
	}
	#recordInfo{
		position:absolute;
		top:0px;  
		right:5px;
	}
	.cardItem{
		margin-top:8px;
	}
	.cardTitle{
		
	}
	.cardContent{
		margin-left:5%;
		font-size:96%;
		color:rgba(0,0,0,0.6); 
	} 
	#checkTopMenu{ 
		
		height:40px;  
		border:1px solid #eeece8;
		box-shadow:0px 1px 0px #eeece8;   
		background-color:#e9e9e9; 
		border-radius:3px;     
	}
	.checkItem , .checkContent{  
		text-overflow:ellipsis;
		color: rgba(128, 128, 128, 0.9);
		font-weight:500;   
		width:12%;  
		height:100%;  
		text-align:center;
		line-height:40px; 
		vertical-align: middle;
		font-size:15px;
	}
	.checkItem.left{
		cursor:pointer; 
		float:left;  
		border-right:1px solid #dbe1e6; 
	}
	.checkItem.right{
		cursor:pointer; 
		float:right;  
		border-left:1px solid #dbe1e6; 
	}
	.checkItem.icon{
		width:5%;  
	}
	.checkContent{
		float:left;
		width:60%;    
		background:#fff; 
	}
	.courseTypeTitle{
		float:left; 
		white-space:nowrap; 
		width:70%; 
		overflow:hidden; 
		text-overflow:ellipsis;
	}
	.courseTypeTitle.select{
		width:80% !important; 
	}
	.courseTypeTitle.selected{
		color:#696969;  
		padding-left:15px;  
		 font-size:16px;  
	}
	.checkContent .contentItem{ 
		font-size:17px; 
		float:left;    
		width:12%;     
		border-right:1px solid  rgba(220,225,231,0.5);
		height:30px; 
		line-height:30px;    
		margin-top:5px;  
		text-align:center; 
	} 
	.checkContent .contentItem label{
		font-size:14px; 
	}
	.checkItem:hover{
		background-color:#f6f6f6;  
	}
	.courseContent{   
		width:30% !important;
	} 
	.itemSelect{	
		background:#f6f6f6 !important;  
	} 
	#checkSubmit{
		width:22%;
		margin-top:0px !important;
		height:40px;line-height:40px;
		font-size:15px; 
		cursor:pointer;  
		color:color: rgba(128, 128, 128, 0.9);
		background:#21ba45;
		color:#fff; 
		
	} 
	#checkSubmit:hover{ 
		background-color:#16ab39;  
	}
	#checkSubmit label{
		cursor:pointer; 
	}
	.setSelect.table tbody td , .setSelect.table thead th {
		padding:5px !important;
		text-align:center; 
	} 
	.setSelect.table tbody .setTd{
		cursor:pointer;  
		font-size:18px !important; 
	} 
	.setSelect.table tbody .setTd:hover{
		background-color:#e5e5e5; 
	}
	
	/* 滑动层  --------------------------------*/
	.toggleDiv{
		border:1px solid rgba(188,188,188,0.6);   
		border-top:none; 
		border-radius:4px;   
		/* margin-top:39px;   */
		background:#f8f8f8;      
		z-index:997;
		overflow-y:auto; 
	}
	/* 滑动打分 ------------------------------------------------- */
	.rangeInput{
		width:90%;  
		margin-left:10%;
		vertical-align:middle;  
		padding:0;  
	}
	.rangeInput .rangeInput{ 
		width:50% !important; 
		padding:0px !important; 
	}
	 
	input[type=range] {
	  -webkit-appearance: none; 
	  width: 70%;
	  margin: 7.3px 0; 
	} 
	input[type=range]:focus { 
	  outline: none;
	}
	input[type=range]::-webkit-slider-runnable-track {
	  width: 100%;
	  height: 5px; 
	  cursor: pointer; 
	  box-shadow: 1px 1px 1px #000000, 0px 0px 1px #0d0d0d;
	  background: #ffffff;
	  border-radius: 5px; 
	  border: 0.2px solid #010101;
	}
	input[type=range]::-webkit-slider-thumb {
	  box-shadow: 0.9px 0.9px 1px #000031, 0px 0px 0.9px #00004b;
	  border: 1.8px solid #00001e;
	  height: 16px;
	  width: 16px; 
	  border-radius: 8px;
	  background: #84cfff; 
	  cursor: pointer;
	  -webkit-appearance: none;
	  margin-top: -6.5px;
	}
	input[type=range]:focus::-webkit-slider-runnable-track {
	  background: #ffffff;
	}
	input[type=range]::-moz-range-track {
	  width: 100%; 
	  height: 5px;
	  cursor: pointer;
	  box-shadow: 1px 1px 1px #000000, 0px 0px 1px #0d0d0d;
	  background: #ffffff;
	  border-radius: 5px;
	  border: 0.2px solid #010101;
	}
	input[type=range]::-moz-range-thumb {
	margin-top: -6.5px;
	  box-shadow: 0.9px 0.9px 1px #000031, 0px 0px 0.9px #00004b;
	  border: 1.8px solid #00001e;
	  height: 16px;
	  width: 16px;
	  border-radius: 8px;
	  background: #84cfff;
	  cursor: pointer;
	}
	input[type=range]::-ms-track {
	  width: 100%;
	  height: 5px;
	  cursor: pointer;
	  background: #ffffff;
	  border-color: transparent;
	  color: transparent;
	}
	input[type=range]::-ms-fill-lower {
	  background: #ffffff;
	  border: 0.2px solid #010101;
	  border-radius: 2.6px;
	  box-shadow: 1px 1px 1px #000000, 0px 0px 1px #0d0d0d;
	}
	input[type=range]::-ms-fill-upper {
	  background: #ffffff;
	  border: 0.2px solid #010101;
	  border-radius: 2.6px;
	  box-shadow: 1px 1px 1px #000000, 0px 0px 1px #0d0d0d;
	}
	input[type=range]::-ms-thumb {
	  box-shadow: 0.9px 0.9px 1px #000031, 0px 0px 0.9px #00004b;
	  border: 1.8px solid #00001e;
	  height: 16px;
	  width: 16px;
	  border-radius: 8px;
	  background: #84cfff;
	  cursor: pointer;
	  height: 5px;
	}
	input[type=range]:focus::-ms-fill-lower {
	  background: #ffffff; 
	} 
	input[type=range]:focus::-ms-fill-upper {
	  background: #ffffff; 
	} 
	.classBtn{
		font-size:14px !important; 
		font-weight:600 !important;  
		width:70%;   
		padding:5px !important;  
		margin-bottom:3px !important;  
	}
	.weekMenu{
		width:100%;
		paddding:0px;
		
	} 
	.weekBtn{
		float:left;
		width:4.8%;
		border:1px solid #eeece8;
		height:30px;  
		background:#fff;
		border-radius:2px;   
		border-right:none;  
		line-height:30px;
		text-align:center;   
		cursor:pointer;
		font-size:96%;  
		margin-top:6px;  
	}
	.weekBtn.last{  
		border-right:1px solid #eeece8 !important; 
	}
	.weekBtn:hover{
		background:#f3f3f3; 
		color:#2185D0;  
	} 
	.weekBtn.selected{ 
		width:8%;
		background:#f3f3f3; 
		color:#2185D0; 
	}
	.weekBtn label{
		display:none; 
	}
	.weekBtn.selected label{
		display:inline !important; 
	}
	.setTd.initSelected{
		background:#e5e5e5 !important;
	}
	.initBtn.initSelected{ 
		background:#47c264 !important;
		color:#fff !important; 
	}
	.initBtn.initSelected i{  
		color:#fff !important; 
	}
	.checkItem.courseSelected{
		width:23%; 
	} 
	.statusBtn{  
		top:10px;   
		font-size:22px !important;   
		cursor:pointer;   
		position:absolute;  
		color:#bcbcbc;  
	}
	.statusBtn.kk{
		left:3%; 
	}
	.statusBtn.zt{
		left:26%; 
	} 
	.statusBtn.cd{
		left:50%;  
	}
	.statusBtn.qj{ 
		left:73%;     
	}
	.statusBtn.qj:hover{ 
		color:#2185d0;     
	}
	.statusBtn.kk:hover{ 
		color:#db2828;     
	}
	.statusBtn.zt:hover{ 
		color:#f2711c;     
	}
	.statusBtn.cd:hover{ 
		color:#fbbd08;     
	}
	.stucard{
		margin-right:3%; 
		margin-bottom:20px;  
		float:left;
		position:relative; 
		width:17%;   
		border:1px solid #eeece8;  
		height:85px;   
		background:#fff;  
		border-radius:4px;   
		box-shadow:0px 1px 1px #e5e5e5;   
	}
	.stucard .header{
		position:relative;
		padding:3px;
		width:100%; 
		height:40px; 
		border-bottom:1px solid #e5e5e5;   
	}
	.stucard .content{
		position:relative;
		width:100%;
		height:40px;   
	}
	.stucard .header .name{
		top:11px;  
		font-size:110%;  
		white-space:nowrap; 
		width:45%; 
		left:4%;  
		overflow:hidden; 
		text-overflow:ellipsis; 
		position:absolute;
	} 
	.stucard .header .code{ 
		position:absolute;
		left:50%; 
		top:13px; 
	} 
	.fixStatus i{ 
		 font-size:15px !important;  
	} 
	#fixBar{
		display:none;
		position:fixed; 
		top:165px; 
		right:0;
		width:30px;
		border-radius:2px;  
	}
	#fixBar .item{
		width:100%; 
		height:25px; 
		background:rgba(188,188,188,0.3); 
		text-align:center; 
		line-height:25px; 
		vertical-align:middle; 
		border:1px solid rgba(188,188,188,0.5); 
		border-bottom:none;  
		color:rgba(0,0,0,0.5);
		cursor:pointer; 
	}
	#fixBar .item:hover{ 
		background:rgba(188,188,188,1.0); 
	}
	#fixBar .item.content.select{
		background:rgba(188,188,188,1.0); 
	}
	#fixBar .item.last{
		border-bottom:1px solid rgba(188,188,188,0.5);  
	}
	
	.moduleTitle{
		margin-right:5%; 
		margin-top:3px; 
	} 
	.extraInput{ 
		margin-left:5%; 
		width:50px !important;
		text-align:center;  
	}
	#courseRecordSelect{
		width:80%;
	}
	.gotoCheck{
		cursor:pointer;
	} 
	.gotoCheck:hover{ 
		box-shadow: 0 0 0 .1em #00b5ad inset !important;
	}
	.blockCourseTD{
		background:#f9fafb !important;
	}
	.blockCourseTD .blockPopup{
		color:#998e8e !important;
	} 
	.blockCourseTD .courseName{ 
		color:#998e8e ;
	}
	.blockCourseTD .courseAddr{  
		color:#998e8e ;
	}
	.blockClassBtn{  
		background:#f9fafb !important;
		cursor:default !important;
		font-weight:500 !important;
		color:#998e8e !important;
		font-size:14px !important; 
	}
	.blockClassBtn:hover{
		color:#998e8e !important;
	}
	/*  */
	.checkItem.upload {
		width:15%; 
	}
	.courseTypeTitle.upload {
		margin-left:2%;
		color: rgba(128, 128, 128, 0.9);
		font-size: 14.5px;
	}
	
</style> 
</head> 
<body>
	<%@ include file="/commonjsp/header.jsp"%>  
	<div id="container" > 
		<!-- 工具栏 -->
		<div id="checkTopBar"> 
			<div id="checkTopMenu"> 
			 	<div class="checkItem left clickItem itemSelect courseSelected" name="courseArrangeJS">
			 		<div class="courseTypeTitle select js">讲授课</div> 
			 		<i class="caret down icon"></i>  
			 	</div>    
			 	<div class="checkItem left clickItem" name="courseArrangeSX">
			 		<div class="courseTypeTitle sx">实训课</div>
			 		
			 		<i class="caret down icon"></i>
			 	</div>
			 	<div class="checkItem left clickItem upload" id="CheckUpdateWord">
			 		 <a class="courseTypeTitle upload" href="">考勤修改单</a>
			 		 <i class="download icon"></i>
			 	</div>
			 	
			 	<div class="checkContent" style="display:none;"> 
			 		<div class="courseContent contentItem">
			 			<label id="courseFlagInfo"></label>
			 		</div>
			 		<div class="contentItem" data-content="旷课" data-variation="mini"> 
			 			<i class="remove red icon"></i>
			 			<label id="kuangke">0</label>
			 		</div>
			 		
			 		<div class="contentItem" data-content="早退" data-variation="mini">
			 			<i class="warning orange icon"></i>
			 			<label id="zaotui">0</label>
			 		</div>
			 		<div class="contentItem" data-content="迟到" data-variation="mini">
			 			<i class="wait yellow icon"></i>
			 			<label id="chidao">0</label> 
			 		</div>
			 		<div class="contentItem" data-content="请假" data-variation="mini" style="border-right:none;">
			 			<i class="doctor blue icon"></i>
			 			<label id="qingjia">0</label>  
			 		</div>
			 		<div class="contentItem" id="checkSubmit"  data-content="忘记提交，考勤信息也不会丢失" data-variation="mini"> 
			 			<i class="checkmark icon"></i>     
			 			<label>完成考勤</label>   
			 		</div>
			 		
			 	</div>
			 	<div class="checkItem clickItem right icon" style="text-align:center;"  data-content="考勤记录" data-variation="mini" name='courseRecored' id="courseRecoredBtn">
			 		<i class="search icon"></i>   
			 	</div>   
			</div> 
		</div>
		<!-- 将授课 -->
		<div id="courseArrangeJS" class="toggleDiv">
			<div style="width:96%;margin-left:2%; margin-top:10px;margin-bottom:20px;"> 
			<!--  -->
				<div class = "weekMenu " name="讲授课" style="overflow:hidden">
					 
				</div>
			<!--  -->
			<table id= "tea_check_table" class="ui small structured celled table">
			  <thead class="center aligned">
			    <tr>
			      <th></th>
			      <th class="weekOne">周一</th>
			      <th class="weekTwo">周二</th>
			      <th class="weekThree">周三</th>  
			      <th class="weekFour">周四</th>
			      <th class="weekFive">周五</th>
			      <th class="weekSix">周六</th> 
			      <th class="weekSeven">周日</th>
			    </tr>
			  </thead>
			  <tbody class="center aligned ">  
			    <tr>
			      <td class="setTD setOne" >一节</td>
			      <td id="setK11" class=" weekOne setOne"> 
			      	<!--  -->
				     
			      	<!--  -->
				  </td>  
			      <td id="setK21" class=" weekTwo setOne">
			     
			      </td>
			      <td id="setK31" class=" weekThree setOne">
			      	
			      </td>
			      <td id="setK41" class="weekFour setOne"></td>
			      <td id="setK51" class="weekFive setOne"></td> 
			      <td id="setK61" class="weekSix setOne"></td>
			      <td id="setK71" class="weekSeven setOne"> 
			      	
			      </td>
			    </tr>
			    <tr>
			   	 <td  class="setTD setTwo" >二节</td>
			      <td id="setK12" class="weekOne setTwo"></td> 
			      <td id="setK22" class="weekTwo setTwo"></td>
			      <td id="setK32" class="weekThree setTwo"></td>
			      <td id="setK42" class="weekFour setTwo"></td>
			      <td  id="setK52" class="weekFive setTwo"></td>
			      <td id="setK62" class="weekSix setTwo"></td>
			      <td id="setK72" class="weekSeven setTwo"></td>
			    </tr> 
			    <tr>  
			      <td  class="setTD setThree">三节</td>
			      <td id="setK13" class="weekOne setThree"> 
			      	
			      </td> 
			      <td id="setK23" class="weekTwo setThree"></td>
			      <td id="setK33" class="weekThree setThree"></td>
			      <td id="setK43" class="weekFour setThree"></td>
			      <td id="setK53" class="weekFive setThree"></td>
			      <td id="setK63" class="weekSix setThree"></td>
			      <td id="setK73" class="weekSeven setThree"></td>
			    </tr>
			    <tr >
			    	<td  class="setTD setFour" >四节</td>
			      <td id="setK14" class="weekOne setFour"></td> 
			      <td id="setK24" class="weekTwo setFour"></td>
			      <td id="setK34" class="weekThree setFour"></td>
			      <td id="setK44" class="weekFour setFour"></td>
			      <td id="setK54" class="weekFive setFour" >
			      	
			      </td>
			      <td id="setK64" class="weekSix setFour">
			      	
			      </td>
			      <td id="setK74" class="weekSeven setFour"></td>
			    </tr>
			    <tr > 
			     <td  class="setTD setFive">五节</td>
			      <td id="setK15" class="weekOne setFive"></td> 
			      <td id="setK25" class="weekTwo setFive"></td>
			      <td id="setK35" class="weekThree setFive">
			      	
			      </td>
			      <td id="setK45" class="weekFour setFive"> 
			      
			      </td> 
			      <td id="setK55" class="weekFive setFive"></td>
			      <td id="setK65" class="weekSix setFive"></td>
			      <td id="setK75" class="weekSeven setFive"></td>
			    </tr>
				<tr class="single-row">
					<td  class="setTD setTwo" >六节</td>
					<td id="setK16" class="weekOne setTwo"></td>
					<td id="setK26" class="weekTwo setTwo"></td>
					<td id="setK36" class="weekThree setTwo"></td>
					<td id="setK46" class="weekFour setTwo"></td>
					<td  id="setK56" class="weekFive setTwo"></td>
					<td id="setK66" class="weekSix setTwo"></td>
					<td id="setK76" class="weekSeven setTwo"></td>
				</tr>
				<tr class="single-row">
					<td  class="setTD setTwo" >七节</td>
					<td id="setK17" class="weekOne setTwo"></td>
					<td id="setK27" class="weekTwo setTwo"></td>
					<td id="setK37" class="weekThree setTwo"></td>
					<td id="setK47" class="weekFour setTwo"></td>
					<td  id="setK57" class="weekFive setTwo"></td>
					<td id="setK67" class="weekSix setTwo"></td>
					<td id="setK77" class="weekSeven setTwo"></td>
				</tr>
				<tr class="single-row">
					<td  class="setTD setTwo" >八节</td>
					<td id="setK18" class="weekOne setTwo"></td>
					<td id="setK28" class="weekTwo setTwo"></td>
					<td id="setK38" class="weekThree setTwo"></td>
					<td id="setK48" class="weekFour setTwo"></td>
					<td  id="setK58" class="weekFive setTwo"></td>
					<td id="setK68" class="weekSix setTwo"></td>
					<td id="setK78" class="weekSeven setTwo"></td>
				</tr>
				<tr class="single-row">
					<td  class="setTD setTwo" >九节</td>
					<td id="setK19" class="weekOne setTwo"></td>
					<td id="setK29" class="weekTwo setTwo"></td>
					<td id="setK39" class="weekThree setTwo"></td>
					<td id="setK49" class="weekFour setTwo"></td>
					<td  id="setK59" class="weekFive setTwo"></td>
					<td id="setK69" class="weekSix setTwo"></td>
					<td id="setK79" class="weekSeven setTwo"></td>
				</tr>
			  </tbody>
			</table>
			
			<div class="ui gray large message" id="messageinf" style="border:none !important;box-shadow:none !important;margin-top:10px;">
				<i class="announcement large inverted yellow up circular icon"></i>
					本周您没有需要考勤的课程！     
			</div> 
		
		</div>
		</div> 
		<!-- 实训课 -->
		<div  id="courseArrangeSX" class="toggleDiv" style="display:none">
			<div style="width:96%;margin-left:2%; margin-top:10px;margin-bottom:20px;height:98%;"> 
				<!--  --> 
				<div class = "weekMenu" name="实训课" style="overflow:hidden">
					 
				</div> 
				<!-- 实训 -->
					<div class = "ui two cards" style="margin-top:8px;min-height:100px;">  
							
							<!-- --------------------- --> 
							
						</div> 
				<!--  -->
			</div>
		</div>
		<!-- 考勤记录 --> 
		<div  id="courseRecored" class="toggleDiv" style="display:none;padding:20px;min-height:400px;">     
			<div id = "courseRecordSelect" class="ui fluid small selection dropdown" > 
					<i class="dropdown icon"></i> <span class="default text">请先选择课程</span>
					<div class="menu"></div> 
			</div>  
			<!--  -->
			<div style="margin-top:20px;">
				<table  class="ui small celled table ">
						<thead class="center aligned">
							<tr>
								<th>周次</th>
								<th>节次</th> 
								<th>旷课</th>
								<th>早退</th>
								<th>迟到</th>
								<th>请假</th> 
								<th>出勤率</th>
								<th class='extraTH'>教室卫生</th>
								<th class='extraTH'>课堂纪律</th>
								<th>状态</th>
								<th>进入考勤</th>
								
							</tr>
						</thead> 
						<tbody id="recordTbody" class="center aligned">


						</tbody>
					</table>
			</div>
		</div>
		<div   style="display:none;"> 
			
		</div> 
		<!--  -->
		<div id="submitDiv" class="ui small modal">
		  <div class="header">班级打分
		  	<i class = "close icon" style="float:right;cursor:pointer;"></i> 
		  </div>
		  <div class="content">
		  		
				<div class="rangeInput" style="margin-bottom:20px;">
					<label class="moduleTitle">课堂纪律</label>
			 		<input id='ktjl'class="rangeInput"  type = 'range' value='80' min="0" max="100" step="1" />  
			 		<input id="ktjlInput" class="extraInput" type="text" value = '80' />
			 	</div>
		 		
		 		<div class="rangeInput"> 
		 			<label class="moduleTitle">教室卫生</label>
		 			<input id='jsws' class="rangeInput"  type = 'range' value='80' min="0" max="100" step="1" />  
		 			<input id="jswsInput" class="extraInput" type="text" value = '80' /> 
	 			</div>
		  </div>
		  <div class="actions">
		    <div class="ui cancel  button">返回</div>
		    <div id="extraSubmit" class="ui approve green button">提交</div>
		  </div>
		</div>
		<!--  -->
		<div id="checkMain" style="margin-top:25px;"> 
			<div id="stuCards" style="overflow:hidden">  
				
			</div>
		</div>
		<div id="fixBar">
			
		</div>
		<!-- 返回旧版 -->
		<div id="backOldVersion" style="position:fixed;top:110px;right:0px;cursor:pointer" data-content="返回旧版" data-variation="mini"> 
			<i class="circular grey small forward mail icon" style="background:#e5e5e5;"></i> 
		</div> 
	</div> 
	<!--这里绘制页面-->
</body>
<script>
	$(function() {
	    if(!SINGLESCHE) $(".single-row").hide();

		$('.courseTypeTitle.upload').attr("href","template/QM_Check_Update.docx");
		var messageArray = [];
		var SYSOBJCET =<%=SYSOBJCET%>; 
		var USEROBJECT =<%=USEROBJECT%>;
		var term_no = SYSOBJCET.term_no; 
		var tea_no = USEROBJECT.loginname;  
		var currentweek = SYSOBJCET.currentweek;
		var switchFlag = true;      
		var schoolFlag = VERSIONTYPE;  
		var displayFlag = false;     
		var selectWeekFlag = null;
		var selectScheFlag = null;
		var classCount = null;
		var selectCourseType = null;
		var selectClassNo = null;
		var selectScheNo = null ; 
		var selectClassName = null;
		var selectCourseName = null;
		var selectSelected = null;
		var now_check_main_no = null;
		var selectTable = null ;
		var selectClassTeacherNo = null;
		 var statusArray = {
				 '旷课':'<a class="ui red mini right corner label fixStatus">'+
						'<i class="remove  icon"></i>'+
						'</a>',
				'请假':'<a class="ui blue mini right corner label fixStatus">'+
					'<i class="doctor  icon"></i>'+
					'</a>',
				'早退':'<a class="ui orange mini right corner label fixStatus">'+
				'<i class="warning  icon"></i>'+ 
				'</a>',
				'迟到':'<a class="ui yellow mini right corner label fixStatus">'+  
				'<i class="wait  icon"></i>'+ 
				'</a>',
				'到勤':'<a class="ui green mini right corner label fixStatus">'+
				'<i class="checkmark  icon"></i>'+
				'</a>'
		 }
		 var statusFlag = {
				'旷课':'kuangke',
				'请假':'qingjia',
				'早退':'zaotui',
				'迟到':'chidao',
				'到勤':'dapqin' 
		 }
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
		/* 初始化------------------------------- */
		//南工程 只能使用新版本
		if(schoolFlag == '1'){
			$('#backOldVersion').remove(); 
		}
			$('#checkTopBar , .toggleDiv').css({
				'width':$('#container').width(), 
				'margin-left':$('#container').css('margin-left')
			});
			$('#courseRecoredBtn , #backOldVersion').popup({
				position: 'bottom center',
			});  
			$(window).scroll(function(){  
					var scrollValue = $(window).scrollTop() +6 ;
					var index = parseInt(scrollValue / 210);
					var extraValue = scrollValue % 210 ;
					if(extraValue > 120){
						$('#fixBar .content.item').removeClass('select'); 
						$('.fix'+(index+1)+'').addClass('select');
					}else{ 
						$('#fixBar .content.item').removeClass('select');  
						$('.fix'+(index)+'').addClass('select');  
					}
				if($(window).scrollTop()>9){       
					$('#checkTopBar').css({'position':'fixed' , 'margin-top':'-9px'});   
				}else{    
					$('#checkTopBar').css({'position':'relative' , 'margin-top':'0'});    
				}
			});  
		$('.contentItem').popup({
			position: 'bottom center',
		}); 
		
		//
			//判断开关
			loadSwitch();
			//加载考勤记录
			loadCheckRecord();
		/* 取数据 -------------------------------- */
			//绘制周次 , 默认取当前周
			drawnWeek();
			
		/* 界面逻辑 -------------------------------- */
			//top item 点击事件
			topMenuClick();
			//点击周事件  
			weekBtnClick();
			//点击进如考勤 
			classClick(); 
			//提交考勤 
			submitClick();
			$('#backOldVersion').unbind('click').click(function(){
				location.href = BASE_PATH + "qm/student/stu_check.jsp?module=12";    
			})
		/* 函数区域 -------------------------------- */
		function loadCheckRecord(){ 
				$.ajax({
					url : "do?invoke=TeacherCheck@checkRecordInfo",
					type : 'POST', 
					dataType : 'json', 
					data : {
						term_no : term_no,
						currentWeek : currentweek,
						teacher_no:tea_no,
					},
					success : function(rep) {
						//绘制考勤记录的课程dom  
						if(rep.result == 0){
							var dom ='<div class="ui gray large message" id="" style="border:none !important;box-shadow:none !important;margin-top:10px;">'+
										'<i class="announcement large inverted yellow up circular icon"></i>'+
											'暂无课程信息'+
									'</div>'; 
							$('#courseRecored').empty();
							$('#courseRecored').append($(dom));
						}else{
							var dom = '';
							if(schoolFlag != '1'){
								$('.extraTH').remove(); 
							}
							var courseInfo = rep.data;
							for(var i = 0 ; i < courseInfo.length ; i ++){
								if(courseInfo[i].course_type == '实训课'){
									dom+='<div teacher_no = "'+courseInfo[i].teacher_no+'" sche_set="'+courseInfo[i].sche_set+'" course_name="'+courseInfo[i].course_name+'" class_name="'+courseInfo[i].class_name+'" class_no = "'+courseInfo[i].class_no+'" course_type="'+courseInfo[i].course_type+'" course_week="'+courseInfo[i].course_week+'" sche_no = "'+courseInfo[i].sche_no+'" class="item classinf">'+(i+1)+'、'+courseInfo[i].course_name + '——'+courseInfo[i].course_type+'——'+courseInfo[i].class_name +'</div>';
								}else{
									dom+='<div teacher_no = "'+courseInfo[i].teacher_no+'" sche_set="'+courseInfo[i].sche_set+'" course_name="'+courseInfo[i].course_name+'" class_name="'+courseInfo[i].class_name+'" class_no = "'+courseInfo[i].class_no+'" course_type="'+courseInfo[i].course_type+'" course_week="'+courseInfo[i].course_week+'" sche_no = "'+courseInfo[i].sche_no+'" class="item classinf">'+(i+1)+'、'+courseInfo[i].course_name + '——'+courseInfo[i].course_type+'——'+courseInfo[i].class_name +'——'+weekArray[courseInfo[i].sche_set.substring(1,2)]+'/'+setArray[courseInfo[i].sche_set.substring(2,3)]+'</div>';
								}
							}  
							$('#courseRecordSelect .menu').append($(dom)); 
							checkRecordClick();
							$('#courseRecordSelect').dropdown();
							$('.classinf').eq(0).trigger('click'); 
						}
						
					}
				})
		}
		function checkRecordClick(){
			$('.classinf').unbind('click').click(function(){
				$('#recordTbody').empty(); 
				var course_type = $(this).attr('course_type');
				var sche_no = $(this).attr('sche_no'); 
				var class_no = $(this).attr('class_no'); 
				var class_name = $(this).attr('class_name'); 
				var course_name = $(this).attr('course_name'); 
				var course_week = $(this).attr('course_week'); 
				var sche_set = $(this).attr('sche_set'); 
				var teacher_no = $(this).attr('teacher_no');
				var courseWeekArray = course_week.split(",");
				var weekArray_ = [];
				var course_set = null;
				if(course_type != '实训课'){
					course_set = $(this).text().split('——')[3];
				}
				for (var i = 0 ; i < courseWeekArray.length ; i++) {
					var  courseWeekArray_ = courseWeekArray[i].split("-");
					if(courseWeekArray_.length == 1){
						weekArray_.push(courseWeekArray_[0]);
					}else{
						var star = parseInt(courseWeekArray_[0]);
						var end = parseInt(courseWeekArray_[1]);
						for(var j = star ; j <= end ; j++ ){
							weekArray_.push(j);
						}
					}
				}
				var trDom = "";   
				var colAcount = schoolFlag == "1" ? 11:9;  
				for(var i = weekArray_.length-1 ; i >=0 ; i --){
					if(parseInt(weekArray_[i]) <= parseInt(currentweek)){  
						trDom+='<tr id="checkWeek'+weekArray_[i]+'" class="negative">';
						for(var j = 0 ; j < colAcount ; j++){ 
							if(j == 0){ 
								trDom+='<td>'+weekArray_[i]+'</td>'; 
								continue;
							}
							if(course_type != '实训课' && j == 1){
								trDom+='<td>'+course_set+'</td>';
								continue; 
							} 
							if(j == colAcount - 2){
								trDom+='<td>未提交</td>';
								continue;
							}
							if(j==colAcount - 1){ 
								trDom+='<td><i selectWeek = "'+weekArray_[i]+'" sche_set = "'+sche_set+'" class_name="'+class_name+'" course_name="'+course_name+'" class_no="'+class_no+'" sche_no="'+sche_no+'" course_type="'+course_type+'" class="gotoCheck circular teal arrow right icon"></i></td>';
								continue;
							}
							trDom+='<td></td>'; 
						}
						trDom+='</tr>';
					}
				}
				
				$('#recordTbody').append($(trDom));  
				
				$.ajax({
					url : "do?invoke=TeacherCheck@checkRecordDetail",
					type : 'POST', 
					dataType : 'json', 
					data : {
						course_type : course_type,
						sche_no : sche_no,
						course_week:course_week
					},
					success : function(rep) { 
						var checkRecord = rep.data;
						if(checkRecord != null){
							if(course_type != '实训课'){
								for(var index = 0  ; index < checkRecord.length ; index++ ){
									$('#checkWeek'+checkRecord[index].check_week+'').find('td').eq(2).text(checkRecord[index].check_kk);
									$('#checkWeek'+checkRecord[index].check_week+'').find('td').eq(3).text(checkRecord[index].check_zt);
									$('#checkWeek'+checkRecord[index].check_week+'').find('td').eq(4).text(checkRecord[index].check_cd);
									$('#checkWeek'+checkRecord[index].check_week+'').find('td').eq(5).text(checkRecord[index].check_qj);
									$('#checkWeek'+checkRecord[index].check_week+'').find('td').eq(6).text(checkRecord[index].check_ratio);
									
									$('#checkWeek'+checkRecord[index].check_week+'').find('td').eq(colAcount - 1).find('i').attr('check_main_no',checkRecord[index].check_main_no);
									if(colAcount == 9){ 
										if(checkRecord[index].check_main_status == '1' ){ 
											$('#checkWeek'+checkRecord[index].check_week+'').find('td').eq(7).text('已提交');  
											$('#checkWeek'+checkRecord[index].check_week+'').removeClass('negative').addClass('positive');
										}
									}else{
										$('#checkWeek'+checkRecord[index].check_week+'').find('td').eq(7).text(checkRecord[index].check_jsws);
										$('#checkWeek'+checkRecord[index].check_week+'').find('td').eq(8).text(checkRecord[index].check_ktjl);
										
										if(checkRecord[index].check_main_status == '1' ){
											$('#checkWeek'+checkRecord[index].check_week+'').find('td').eq(9).text('已提交');
											$('#checkWeek'+checkRecord[index].check_week+'').removeClass('negative').addClass('positive');
										}
									}
								}  
							}else{
								$('#recordTbody').empty(); 
								var sxDom = "";
								for(var index = 0  ; index < checkRecord.length ; index++ ){
									if(checkRecord[index].check_main_status == '1'){
										sxDom+='<tr  class="positive">';
									}else{ 
										sxDom+='<tr  class="negative">';  
									}
									sxDom+='<td>'+checkRecord[index].check_week+'</td>';
									sxDom+='<td>'+weekArray[checkRecord[index].check_sx.substring(1,2)]+'/'+setArray[checkRecord[index].check_sx.substring(2,3)]+'</td>';
									sxDom+='<td>'+checkRecord[index].check_kk+'</td>';
									sxDom+='<td>'+checkRecord[index].check_zt+'</td>';
									sxDom+='<td>'+checkRecord[index].check_cd+'</td>';
									sxDom+='<td>'+checkRecord[index].check_qj+'</td>';
									sxDom+='<td>'+checkRecord[index].check_ratio+'</td>';
									if(schoolFlag == '1'){
										sxDom+='<td>'+checkRecord[index].check_jsws+'</td>';
										sxDom+='<td>'+checkRecord[index].check_ktjl+'</td>';
									}
									if(checkRecord[index].check_main_status == '1'){
										sxDom+='<td>已提交</td>';
									}else{
										sxDom+='<td>未提交</td>';
									}
									 
									sxDom+='<td><i teacher_no = "'+teacher_no+'" selectWeek = "'+checkRecord[index].check_week+'" sche_set = "'+checkRecord[index].check_sx+'" class_name="'+class_name+'" course_name="'+course_name+'" class_no="'+class_no+'" sche_no="'+sche_no+'" course_type="'+course_type+'" class="gotoCheck circular teal arrow right icon"></i></td>';
									sxDom+='</tr>'; 
								}
								$('#recordTbody').append($(sxDom));  
							} 
							/*  */
						}
						gotoCheckClick();
					}
				});
				
			})
		}
		function gotoCheckClick(){
			$('.gotoCheck').unbind('click').click(function(){ 
				getStudentInfo('' , $(this).attr('course_type') ,$(this).attr('class_no') , $(this).attr('check_main_no')  , $(this).attr('sche_set').trim(), $(this).attr('selectWeek') , $(this).attr('sche_no') , $(this).attr('class_name') , $(this).attr('course_name'),$(this).attr('teacher_no'));
			})
		} 
		function topMenuClick(){
			$('.clickItem.checkItem').unbind('click').click(function(){
				//将滚动条拉回顶部
				 $('body,html').animate({ scrollTop: 0 }, 50);
				if($(this).hasClass('itemSelect')){
					$('#'+$('.itemSelect.clickItem').attr('name')+'').fadeOut('fast');
					$(this).removeClass('itemSelect');
					//xianshi
					if(displayFlag){
						$('#checkMain ,#fixBar').show(); 
					}
				}else{ 
					
					if($('.itemSelect.clickItem').length == 0){
						//yincang  
						$('#checkMain ,#fixBar').hide(); 
						$('#'+$(this).attr('name')+'').fadeIn('fast'); 
						$(this).addClass('itemSelect');
					}else{   
						
						$(this).addClass('itemSelect_');  
						$('#'+$('.itemSelect.clickItem').attr('name')+'').fadeOut('fast' , function(){
							$('#'+$('.itemSelect_.clickItem').attr('name')+'').fadeIn('fast'); 
							$('.itemSelect.clickItem').removeClass('itemSelect');  
							$('.itemSelect_').addClass('itemSelect').removeClass('itemSelect_');  
						});   
					}
				}
			})
		}
		//点击获得某次考勤信息
		function classClick(){
			$('.setTd , .initBtn').unbind('click').click(function(){
				$('.setTd , .initBtn').removeClass('selectedFlag'); 
				//添加选中类
				$(this).addClass('selectedFlag');
				var courseType = $(this).attr('course_type');
				if(courseType == '' || courseType == null){
					courseType ='实训课';
				}
				var classNo = "";
				var check_main_no = null;
				var sx_check_set = null;
				var selectedWeek = null;
				var scheNo = null;
				var className = null;
				var courseName = null;
				var class_teacher_no = null;
				if(courseType == '实训课'){
					class_teacher_no = $(this).parents('.card').attr('teacher_no');
					classNo = $(this).parents('.card').attr('class_no');  
					sx_check_set =$(this).attr('name').substring(2,5); 
					selectTable = $(this).parents('table').attr('id');
					selectedWeek = $('#courseArrangeSX').find('.weekMenu').find('.selected').attr('name');
					scheNo = $(this).parents('.card').attr('sche_no');
					className = $(this).parents('.card').attr('class_name');
					courseName = $(this).parents('.card').attr('course_name'); 
				}else{
					class_teacher_no = $(this).attr('teacher_no');
					sx_check_set = $(this).attr('sche_set');
					className = $(this).attr('class_name');
					courseName = $(this).attr('course_name');  
					classNo = $(this).attr('class_no'); 
					check_main_no = $(this).attr('check_main_no');
					selectedWeek = $('#courseArrangeJS').find('.weekMenu').find('.selected').attr('name');
				} 
				getStudentInfo('.selectedFlag' , courseType ,classNo , check_main_no  , sx_check_set, selectedWeek , scheNo , className , courseName ,class_teacher_no);
			})
		}
		function weekBtnClick(){
			$('.weekBtn').unbind('click').click(function(){
				if($(this).hasClass('selected')){ 
					return; 
				}
				getCheckCourse($(this).attr('name') , $(this).parent('.weekMenu').attr('name'));
				$(this).parent('.weekMenu').find('.weekBtn').removeClass('selected'); 
				$(this).addClass('selected'); 
			})
		}
		function loadSwitch(){
			$.ajax({
				url : "do?invoke=studentCheck@loadSwitch",
				type : 'POST', 
				async: false,
				dataType : 'json',
				data : {
					term_no : term_no,
				},
				success : function(rep) {
					if(rep.result ==0){
						$.alert("获得学年学期信息失败");
					}else{
						if(rep.data[0].term_kq == "1"){ 
							switchFlag = false;
						} 
					}
				}
	    	});
		}	
		
		function getCheckCourse(selectWeek , course_type ){ 
			$.ajax({
				url : "do?invoke=TeacherCheck@checkInfo",
				type : 'POST', 
				dataType : 'json', 
				async: false,   
				data : {
					term_no : term_no,
					currentWeek : selectWeek, 
					teacher_no:tea_no,
					course_type:course_type,
				},
				success : function(rep) {  
					//绘制表格 ， 根据type
					var courseInfo = rep.data;
					if(course_type == "实训课"){
						//清空 
						$('#courseArrangeSX .ui.cards').empty();
						if(courseInfo.length ==0){  
							//空数据   
							var dom = '<div class="ui gray large message" style="border:none !important;box-shadow:none !important;">'+ 
								'<i class="announcement large inverted yellow up circular icon"></i>'+
								' 本周您没有需要考勤的实训课程！      '+ 
							'</div>';
							$('#courseArrangeSX .ui.cards').append($(dom));
						}else{
							for(var i = 0 ; i < courseInfo.length ; i++){ 
								var dom ='<div class="ui card" teacher_no = "'+courseInfo[i].teacher_no+'" class_name="'+courseInfo[i].class_name+'" course_name = "'+courseInfo[i].course_name+'" sche_no = "'+courseInfo[i].sche_no+'" class_no="'+courseInfo[i].class_no+'">'+
											  '<div class="content" style="text-align:center">'+
										  '<label class="courseName">'+courseInfo[i].course_name+' </label>  <label class="cardContent">'+courseInfo[i].class_name+'</label>'+
										  '</div>'+
										  '<div class="content" style="padding:15px;">' +
										  			'<table id="table'+i+'" class="ui setSelect small very basic collapsing celled table" style="width:100%;">'+ 
		
													'<thead>'+
														'<tr>'+
															'<th id="tabletitle"></th>'+
															'<th>一</th>'+
															'<th>二</th>'+ 
															'<th>三</th>'+
															'<th>四</th>'+
															'<th>五</th>'+
															'<th>六</th>'+
															'<th>天</th>'+ 
														'</tr>'+
													'</thead>'+
													'<tbody>'+
														'<tr>'+
															'<td  class="trTitle">一</td>'+
															'<td class="sxK11 setTd" name = "sxK11"><i class="checkmark icon"></i></td>'+
															'<td class="sxK21 setTd" name = "sxK21"><i class="checkmark icon"></i></td>'+
															'<td class="sxK31 setTd" name = "sxK31"><i class="checkmark icon"></i></td>'+
															'<td class="sxK41 setTd" name = "sxK41"><i class="checkmark icon"></i></td>'+
															'<td class="sxK51 setTd" name = "sxK51"><i class="checkmark icon"></i></td>'+
															'<td class="sxK61 setTd" name = "sxK61"><i class="checkmark icon"></i></td>'+
															'<td class="sxK71 setTd" name = "sxK71"><i class="checkmark icon"></i></td>'+
														'</tr>'+
														'<tr>'+
															'<td  class="trTitle">二</td>'+
															'<td class="sxK12 setTd" name = "sxK12"><i class="checkmark  icon"></i></td>'+
															'<td class="sxK22 setTd" name = "sxK22"><i class="checkmark  icon"></i></td>'+
															'<td class="sxK32 setTd" name = "sxK32"> <i class="checkmark icon"></i></td>'+
															'<td class="sxK42 setTd" name = "sxK42"><i class="checkmark  icon"></i></td>'+
															'<td class="sxK52 setTd" name = "sxK52"><i class="checkmark  icon"></i></td>'+
															'<td class="sxK62 setTd" name = "sxK62"><i class="checkmark  icon"></i></td>'+
															'<td class="sxK72 setTd" name = "sxK72"><i class="checkmark  icon"></i></td>'+
														'</tr>'+
														'<tr>'+
															'<td class="trTitle">三</td>'+
															'<td class="sxK13 setTd" name = "sxK13"><i class="checkmark  icon"></i></td>'+
															'<td class="sxK23 setTd" name = "sxK23"><i class="checkmark  icon"></i></td>'+
															'<td class="sxK33 setTd" name = "sxK33"><i class="checkmark  icon"></i></td>'+
															'<td class="sxK43 setTd" name = "sxK43"><i class="checkmark icon"></i></td>'+
															'<td class="sxK53 setTd" name = "sxK53"><i class="checkmark icon"></i></td>'+
															'<td class="sxK63 setTd" name = "sxK63"><i class="checkmark icon"></i></td>'+
															'<td class="sxK73 setTd" name = "sxK73"><i class="checkmark icon"></i></td>'+
														'</tr>'+
														'<tr>'+
															'<td  class="trTitle">四</td>'+
															'<td class="sxK14 setTd" name = "sxK14"><i class="checkmark  icon"></i></td>'+
															'<td class="sxK24 setTd" name = "sxK24" ><i class="checkmark  icon"></i></td>'+
															'<td class="sxK34 setTd" name = "sxK34"><i class="checkmark  icon"></i></td>'+
															'<td class="sxK44 setTd" name = "sxK44"><i class="checkmark  icon"></i></td>'+
															'<td class="sxK54 setTd" name = "sxK54"><i class="checkmark  icon"></i></td>'+
															'<td class="sxK64 setTd" name = "sxK64"><i class="checkmark  icon"></i></td>'+
															'<td class="sxK74 setTd" name = "sxK74"><i class="checkmark  icon"></i></td>'+
														'</tr>'+
														'<tr>'+
															'<td class="trTitle">晚</td> '+
															'<td class="setTd sxK15" name = "sxK15"><i class="checkmark  icon"></i></td>'+
															'<td class="setTd sxK25" name = "sxK25"><i class="checkmark  icon"></i></td>'+
															'<td class="setTd sxK35" name = "sxK35"><i class="checkmark  icon"></i></td>'+
															'<td class="setTd sxK45" name = "sxK45"><i class="checkmark  icon"></i></td>'+
															'<td class="setTd sxK55" name = "sxK55"><i class="checkmark  icon"></i></td>'+
															'<td class="setTd sxK65" name = "sxK65"><i class="checkmark  icon"></i></td>'+
															'<td class="setTd sxK75" name = "sxK75"><i class="checkmark  icon"></i></td>'+
														'</tr>'+ 
													'</tbody>'+
												'</table>'+
										   '</div>'+ 
										'</div>'; 
										$('#courseArrangeSX .ui.cards').append($(dom)); 
										if(courseInfo[i].sx_recored != null){
											var sx_recored = courseInfo[i].sx_recored; 
											for(var j = 0 ; j < sx_recored.length ; j ++){ 
												$('#table'+i+' .sx'+sx_recored[j].check_sx+'').find('i').addClass('green');
											} 
										}
							}	
							classClick(); 
						}
					}else{
						console.log(courseInfo)
						//清空 
						$('td.weekOne , td.weekTwo , td.weekThree ,td.weekFour ,td.weekFive ,td.weekSix ,td.weekSeven').empty();
						$('#tea_check_table').find('td').removeClass('courseTD');   
						$('#tea_check_table').find('td').removeClass('blockCourseTD');  
						if(courseInfo.length == 0){
							$('#messageinf').show();
							$('#tea_check_table').hide();
						}else{
							$('#messageinf').hide();
							$('#tea_check_table').show(); 
							//
							for(var i = 0 ; i < courseInfo.length ; i++ ){
								//已存在该课程 
								var tempFlag = true;
								if($('#set'+courseInfo[i].sche_set+'').find('.courseSet').length > 0){
									for(var index = 0 ; index < $('#set'+courseInfo[i].sche_set+'').find('.courseSet').length ; index++){
										if($('#set'+courseInfo[i].sche_set+'').find('.courseSet').eq(index).attr('course_name') == courseInfo[i].course_name){
											tempFlag = false;
											var dom = "";
											//判断是否是当周课
											if(courseInfo[i].arrangeFlag == '0'){
												dom+='<button id="'+courseInfo[i].check_main_no+'" class="ui blockClassBtn classBtn button" >'+courseInfo[i].class_name+'</button>';
											}else{
												if(courseInfo[i].check_main_status == '1'){ 
													dom+='<button teacher_no = "'+courseInfo[i].teacher_no+'" sche_set = "'+courseInfo[i].sche_set+'" class_name = "'+courseInfo[i].class_name+'" course_name="'+courseInfo[i].course_name+'" id="'+courseInfo[i].check_main_no+'"  check_main_no = "'+courseInfo[i].check_main_no+'" class_no = "'+courseInfo[i].class_no+'" course_type="'+courseInfo[i].course_type+'" class="ui initBtn classBtn button" ><i class="checkmark green icon"></i>'+courseInfo[i].class_name+'</button>';
									      	  	}else{
									      	  		dom+='<button teacher_no = "'+courseInfo[i].teacher_no+'" sche_set = "'+courseInfo[i].sche_set+'" class_name = "'+courseInfo[i].class_name+'" course_name="'+courseInfo[i].course_name+'" id="'+courseInfo[i].check_main_no+'" check_main_no = "'+courseInfo[i].check_main_no+'" class_no = "'+courseInfo[i].class_no+'" course_type="'+courseInfo[i].course_type+'" class="ui classBtn initBtn button"  >'+courseInfo[i].class_name+'</button>';
									      	  	} 
											}
											$('#set'+courseInfo[i].sche_set+'').find('.courseSet').eq(index).append($(dom));
											break;
										}else{
											continue;
										}
									}
									if(tempFlag){
										var dom='<div style = "border-top:1px solid #e5e5e5; " class="courseSet" course_name = "'+courseInfo[i].course_name+'">' +
						      	  		'<div class="courseName content">'+
					      	  			courseInfo[i].course_name +
							      	  	'</div>' +
							      	  /* 	'<div class="courseWeek content">['+
							      	    courseInfo[i].course_week + '周' +   
							      	  	']</div>'+  */ 
							      	  	'<div class="courseAddr content">'+ 
							      		 courseInfo[i].sche_addr +  
							      	  	'</div>'+  
							      	  	'<div class="ui divider" style="margin:5px;"></div>'; 
										if(courseInfo[i].arrangeFlag == '0'){
											dom+='<button id="'+courseInfo[i].check_main_no+'" class="ui blockClassBtn classBtn button" >'+courseInfo[i].class_name+'</button>';
										}else{  
								      	  	if(courseInfo[i].check_main_status == '1'){  
								      	  		dom+='<button teacher_no = "'+courseInfo[i].teacher_no+'" sche_set = "'+courseInfo[i].sche_set+'" class_name = "'+courseInfo[i].class_name+'" course_name="'+courseInfo[i].course_name+'" id="'+courseInfo[i].check_main_no+'" check_main_no = "'+courseInfo[i].check_main_no+'" class_no = "'+courseInfo[i].class_no+'" course_type="'+courseInfo[i].course_type+'" class="ui initBtn classBtn button" ><i class="checkmark green icon"></i>'+courseInfo[i].class_name+'</button>';
								      	  	}else{
								      	  		dom+='<button teacher_no = "'+courseInfo[i].teacher_no+'" sche_set = "'+courseInfo[i].sche_set+'" class_name = "'+courseInfo[i].class_name+'" course_name="'+courseInfo[i].course_name+'" id="'+courseInfo[i].check_main_no+'" check_main_no = "'+courseInfo[i].check_main_no+'" class_no = "'+courseInfo[i].class_no+'" course_type="'+courseInfo[i].course_type+'" class="ui classBtn initBtn button" >'+courseInfo[i].class_name+'</button>'; 
								      	  	} 
										}
							      		dom+='</div>'; 
							      		$('#set'+courseInfo[i].sche_set+'').append($(dom)); 
							      		$('#set'+courseInfo[i].sche_set+'').addClass('courseTD'); 
							      		
							      		if(courseInfo[i].arrangeFlag == '0'){ 
							      			$('#set'+courseInfo[i].sche_set+'').addClass('blockCourseTD'); 
							      			var blockDom = '<div class="blockPopup">(非本周)</div>'  
							      			$('#set'+courseInfo[i].sche_set+'').find('.courseSet').last().prepend($(blockDom));
							      		}else{ 
							      			$('#set'+courseInfo[i].sche_set+'').find('.courseSet').last().addClass('nowSetTd'); 
							      		}
									}
								}else{
									var dom='<div  class="courseSet" course_name = "'+courseInfo[i].course_name+'">' +
					      	  		'<div class="courseName content">'+
				      	  			courseInfo[i].course_name +
						      	  	'</div>' +
						      	  /* 	'<div class="courseWeek content">['+
						      	    courseInfo[i].course_week + '周' +   
						      	  	']</div>'+  */ 
						      	  	'<div class="courseAddr content">'+ 
						      		 courseInfo[i].sche_addr +  
						      	  	'</div>'+  
						      	  	'<div class="ui divider" style="margin:5px;"></div>'; 
									if(courseInfo[i].arrangeFlag == '0'){
										dom+='<button id="'+courseInfo[i].check_main_no+'" class="ui blockClassBtn classBtn button" >'+courseInfo[i].class_name+'</button>';
									}else{  
							      	  	if(courseInfo[i].check_main_status == '1'){  
							      	  		dom+='<button teacher_no = "'+courseInfo[i].teacher_no+'" sche_set = "'+courseInfo[i].sche_set+'" class_name = "'+courseInfo[i].class_name+'" course_name="'+courseInfo[i].course_name+'" id="'+courseInfo[i].check_main_no+'" check_main_no = "'+courseInfo[i].check_main_no+'" class_no = "'+courseInfo[i].class_no+'" course_type="'+courseInfo[i].course_type+'" class="ui initBtn classBtn button" ><i class="checkmark green icon"></i>'+courseInfo[i].class_name+'</button>';
							      	  	}else{
							      	  		dom+='<button teacher_no = "'+courseInfo[i].teacher_no+'" sche_set = "'+courseInfo[i].sche_set+'" class_name = "'+courseInfo[i].class_name+'" course_name="'+courseInfo[i].course_name+'" id="'+courseInfo[i].check_main_no+'" check_main_no = "'+courseInfo[i].check_main_no+'" class_no = "'+courseInfo[i].class_no+'" course_type="'+courseInfo[i].course_type+'" class="ui classBtn initBtn button" >'+courseInfo[i].class_name+'</button>'; 
							      	  	} 
									}
						      		dom+='</div>'; 
						      		$('#set'+courseInfo[i].sche_set+'').append($(dom)); 
						      		$('#set'+courseInfo[i].sche_set+'').addClass('courseTD');  
						      		if(courseInfo[i].arrangeFlag == '0'){
						      			$('#set'+courseInfo[i].sche_set+'').eq(0).addClass('blockCourseTD'); 
						      			var blockDom = '<div class="blockPopup">(非本周)</div>'
						      			$('#set'+courseInfo[i].sche_set+'').find('.courseSet').prepend($(blockDom));
						      		}
								}
							}
							//隐藏不需要的行和列
							hideRowCol();
							$('.classBtn').popup({
								position: 'right center',
							}); 
							classClick(); 
						}
						// 
						
					}
				}
			});
		}
		function hideRowCol(){   
			//调整courseSet高度  
			$('#tea_check_table').find('td , th').show();
			var setArray = ['One' , 'Two' , 'Three' , 'Four' , 'Five' , 'Six' , 'Seven'];
			var length = 0; 
			var hideArray = [];
			for(var i = 0 ; i < 7 ; i ++){ 
				if($('td.week'+setArray[i]+'').find('.courseSet').length == 0){
					length ++ ; 
					hideArray.push(setArray[i]);
				}else{ 
					$('.week'+setArray[i]+'').show(); 
				} 
			}
			if(length <= 2){       
				for(var i = 0 ; i < hideArray.length ; i++){ 
					$('.week'+hideArray[i]+'').hide();
				}
			}
		//
		}
		function drawnWeek(){ 
			//绘制周次按钮  放入两个地方  选中当前周  触发初始化  ， 周次点击事件
			var currentIntWeek = parseInt(currentweek); 
			var dom = ""; 
			for(var i = currentIntWeek ; i >= 1 ; i-- ){ 
				if(currentIntWeek == 1){
					dom+='<div class="weekBtn selected week'+i+' last" name="'+i+'">'+i+'<label>周</label></div> ';
					continue;
				}
				if(i == currentIntWeek){
					dom+='<div class="weekBtn selected week'+i+'"  name="'+i+'">'+i+'<label>周</label></div> ';
					continue;
				} 
				if(i == 1){
					dom+='<div class="weekBtn last  week'+i+'" name="'+i+'">'+i+'<label>周</label></div> ';
					continue;
				}
				dom+='<div class="weekBtn week'+i+'"  name="'+i+'">'+i+'<label>周</label></div> ';
			}
			$('#courseArrangeJS').find('.weekMenu').append($(dom)); 
			$('#courseArrangeSX').find('.weekMenu').append($(dom)); 
			//取得课程数据 
			getCheckCourse(currentIntWeek , "讲授课"); 
			//取得课程数据 
			getCheckCourse( currentIntWeek, "实训课"); 
		}
		function getStudentInfo(selected , course_type , class_no , check_main_no , course_set , selectedWeek , sche_no , class_name , course_name , class_teacher_no){
			$('.checkItem.upload').hide();
			selectWeekFlag = selectedWeek;
			selectScheFlag = course_set;
			selectCourseType = course_type;
			selectClassNo = class_no;
			selectScheNo = sche_no ; 
			selectClassName = class_name;
			selectCourseName = course_name;
			selectClassTeacherNo = class_teacher_no;
			//清空
			$('#checkMain #stuCards').empty(); 
			//收起所有toggleDiv
			 $('body,html').animate({ scrollTop: 0 }, 50); 
			$('.toggleDiv').fadeOut('fast'); 
			$('.itemSelect.clickItem').removeClass('itemSelect');  
			//判断实训或者讲授 //点击周 
			if(course_type == '实训课'){
				getCheckCourse($('#courseArrangeSX').find('.weekBtn.week'+selectedWeek+'').attr('name') , $('#courseArrangeSX').find('.weekBtn.week'+selectedWeek+'').parent('.weekMenu').attr('name'));
				$('#courseArrangeSX').find('.weekBtn.week'+selectedWeek+'').parent('.weekMenu').find('.weekBtn').removeClass('selected'); 
				$('#courseArrangeSX').find('.weekBtn.week'+selectedWeek+'').addClass('selected');
				 selectSelected = '#'+selectTable+' '+' tbody tr .sx'+course_set;    
			}else{
				getCheckCourse($('#courseArrangeJS').find('.weekBtn.week'+selectedWeek+'').attr('name') , $('#courseArrangeJS').find('.weekBtn.week'+selectedWeek+'').parent('.weekMenu').attr('name'));
				$('#courseArrangeJS').find('.weekBtn.week'+selectedWeek+'').parent('.weekMenu').find('.weekBtn').removeClass('selected'); 
				$('#courseArrangeJS').find('.weekBtn.week'+selectedWeek+'').addClass('selected');
				selectSelected = '#'+check_main_no;    
			}  
			
			//去掉所有选择状态   
			$('.setTd , .initBtn').removeClass('initSelected'); 
			//添加自己选中状态 
			$(''+selectSelected+'').addClass('initSelected');       
			//删除标志类     
			$(''+selectSelected+'').removeClass('selectedFlag');  
			//ajax请求 
			getClassCheckInfo(course_type , class_no ,check_main_no , course_set , selectedWeek ,sche_no ,class_name ,course_name );
			
		}
		//请求班级考勤数据
		function getClassCheckInfo(course_type , class_no ,check_main_no , course_set , selectedWeek ,sche_no,class_name ,course_name ){
			$.ajax({
				url : "do?invoke=TeacherCheck@getStudentCheckInfo",
				type : 'POST',  
				dataType : 'json',
				async:false,
				data : {
					term_no : term_no,
					selectedWeek : selectedWeek, 
					check_main_no:check_main_no,
					course_type:course_type,
					class_no:class_no,
					course_set:course_set,
					sche_no:sche_no
				},
				success : function(rep) {
					//TODO:重置信息数组
					messageArray = [];
					$('#courseFlagInfo').text(class_name + '('+selectedWeek+'周)'); 
					$('.checkContent ,#fixBar , #checkMain').show();   
					displayFlag = true;
					//将数量归0
					$('#kuangke , #qingjia , #zaotui , #chidao').text('0'); 
					if(course_type == '实训课'){ 
						$('.courseTypeTitle.sx').html('<i class="book icon" style="font-size:14px !important;"></i>'+course_name);
						$('.courseTypeTitle.js').text("讲授课");
						$('.courseTypeTitle.js').removeClass('select selected');   
						$('.courseTypeTitle.sx').addClass('select selected');  
						$('.courseTypeTitle.js').parents('.checkItem').removeClass('courseSelected'); 
						$('.courseTypeTitle.sx').parents('.checkItem').addClass('courseSelected');
					}else{   
						$('.courseTypeTitle.js').html('<i class="book  icon" style="font-size:14px !important;"></i>'+course_name); 
						$('.courseTypeTitle.sx').text("实训课");  
						$('.courseTypeTitle.sx').removeClass('select selected');   
						$('.courseTypeTitle.js').addClass('select selected');
						$('.courseTypeTitle.sx').parents('.checkItem').removeClass('courseSelected');
						$('.courseTypeTitle.js ').parents('.checkItem').addClass('courseSelected');
					}
					//绘制学生卡片
					drawnCard(rep.data , rep.message); 
				}
			});
			//替换标题信息
			//
			function drawnCard(info , check_main_no){
				if(info != null){ 
					$('#jsws , #jswsInput').val('80'); 
					$('#ktjl , #ktjlInput').val('80');  
					classCount = info.length; 
					now_check_main_no = check_main_no;
					var dom = "";
					$('#fixBar').empty();
					var index = 0;
					var fixDom = '<div id="prevPage" class="item">'+
									'<i class="caret up icon" style="margin-left:5px;"></i>'+
									'</div>';
					for(var i = 0 ; i < info.length ; i ++){ 
						
						var check_jsws = info[i].check_jsws;
						var check_ktjl = info[i].check_ktjl;
						if(check_jsws!=null&& check_ktjl!=null&&check_jsws!=''&&check_ktjl!=null){
							$('#jsws , #jswsInput').val(check_jsws); 
							$('#ktjl , #ktjlInput').val(check_ktjl);  
						}
						 
						if(i % 10 ==0){ 
							if(i==0){
								fixDom +='<div name = "fix'+i+'" class="item select content fix'+index+'">'+
								'0'+(i+1)+
								'</div>';
							}else{  
								fixDom +='<div name = "fix'+i+'" class="item content fix'+index+'">'+
								(i+1)+ 
								'</div>';
							}  
							index++;
						} 
						dom += '<div id="fix'+i+'" class="stucard '+check_main_no+'" status = "'+((info[i].check_status == null || info[i].check_status) == '' ? '到勤':info[i].check_status)+'"  check_main_no="'+check_main_no+'" stu_no ="'+info[i].stu_no+'">'; 
								if(info[i].check_status == null || info[i].check_status == ''){
									dom+=statusArray['到勤'];
								}else{ 
									dom+=statusArray[info[i].check_status]; 
									changeAmount('plus' , statusFlag[info[i].check_status]); 
								}
								dom+='<div class="header">'+
									'<div class="name">'+  
									info[i].stu_name +
									'</div>'+
									'<div class="code">'+
									 info[i].stu_no  
										.substring(
												info[i].stu_no.length - 2, 
												info[i].stu_no.length)+
									'号</div>'+
								'</div>'+
								'<div class="content">'+
									'<a class="statusBtn kk" data-content="旷课"data-variation="mini" ><i class="remove  icon"></i></a>'+
									'<a class=" statusBtn zt" data-content="早退"data-variation="mini"><i class="warning  icon "></i></a>'+
									'<a class=" statusBtn cd" data-content="迟到"data-variation="mini"><i class="wait  icon"></i></a>'+
									'<a class=" statusBtn qj" data-content="请假"data-variation="mini"><i class="doctor  icon "></i></a>'+
								'</div>'+
							'</div>';
					} 
					fixDom+='<div id="nextPage" class="item last">'+
							'<i class="caret down icon" style="margin-left:5px;"></i>'+
							'</div>'; 
					$('#fixBar').append($(fixDom));
					fixBarClick();
					$('#stuCards').append($(dom));   
					$('.statusBtn').popup({ 
						position: 'bottom center', 
					});
					 cardClick();
					 iconClick(); 
				}
			}
		}
		//
		function fixBarClick(){
			//prevPage
			$('#prevPage').unbind('click').click(function(){
				if($('#fixBar .content.select').prev().hasClass('content')){
					var target = $('#fixBar .content.select').prev().attr('name');
					var margin_top  = $('#'+target+'').offset().top;
					judgeTarget(margin_top);
					$('#fixBar .content.select').removeClass('select').prev().addClass('select');
				} 
			})
			//nextPage 
			$('#nextPage').unbind('click').click(function(){
				if($('#fixBar .content.select').next().hasClass('content')){
					var target = $('#fixBar .content.select').next().attr('name');
					var margin_top  = $('#'+target+'').offset().top;
					judgeTarget(margin_top);
					$('#fixBar .content.select').removeClass('select').next().addClass('select');
				}  
			})
			$('#fixBar .item.content').unbind('click').click(function(){ 
				var target = $(this).attr('name');
				var margin_top  = $('#'+target+'').offset().top;   
				judgeTarget(margin_top);
				$('#fixBar .item.content').removeClass('select');   
				$(this).addClass('select');
			})
		}
		function judgeTarget(margin_top){
			var flag = $('#checkTopBar').css('position');
			if(flag != 'fixed'){
				$('body,html').animate({ scrollTop: margin_top-190 }, 0); 
			}else{  
				$('body,html').animate({ scrollTop: margin_top-150}, 0);   
			}
		}
		//点击卡片事件
		function cardClick(){
			$('.stucard').unbind('click').click(function(){
				if(!judgeOverTime()){
					$.alert("已超出考勤周期，不可以继续考勤");
					return;
				}
				//loading
				if($(this).hasClass('loading')){
					return;
				}
				$(this).addClass('loading'); 
				var check_main_no = $(this).attr('check_main_no');
				var stu_no  = $(this).attr('stu_no');
				var oldStatus = $(this).attr('status');
				var stu_name = $(this).find('.name').text();
				$(this).find('.fixStatus').remove(); 
				//TODO:添加到messageArray
				
				if(oldStatus == '到勤'){ 
					messageManage(stu_no ,'旷课' ,stu_name);
					changeAmount('plus' , 'kuangke'); 
					$(this).prepend($(statusArray['旷课']));
					 $(this).attr('status' , '旷课');
					 postStuStatus(check_main_no , stu_no , '旷课');
				}else{
					messageManage(stu_no ,'到勤' ,stu_name);
					changeAmount('minus' , statusFlag[oldStatus]);
					$(this).prepend($(statusArray['到勤'])); 
					 $(this).attr('status' , '到勤');
					 postStuStatus(check_main_no , stu_no , '到勤');
					
				}
			})
		}
		//判断是否超出考勤规定时间
		function judgeOverTime(){
			//7天限制
			/* var nowDate = new Date();
			var week = nowDate.getDay();
			if(week == '0'){
				week = '7' ; 
			}
			if(switchFlag){
				return true;
			}
			var selectWeek = selectScheFlag.substring(1,2);
			if(parseInt(currentweek) - parseInt(selectWeekFlag) == 1){
				if(parseInt(week) > parseInt(selectWeek)){
					return false;
				}
				return true;
			}else if(parseInt(currentweek) - parseInt(selectWeekFlag) > 1){
				return false;
			}else{
				return true;
			} */
			//同一周限制
			if(!switchFlag){ 
				return true; 
			}
			/* var selectWeek = selectScheFlag.substring(1,2); */
			if(parseInt(currentweek) - parseInt(selectWeekFlag) > 0){
				//超过限制
				return false;
			}else{
				return true;
			}
		}
		//点击提交事件
		function submitClick(){
			$('#checkSubmit').unbind('click').click(function(){
				if(!judgeOverTime()){ 
					$.alert("已超出考勤周期，不可以继续考勤");
					return;
				}
				if(schoolFlag == '1'){
					submitExtraModule();
				}else{
					postCheckMain();
				}
			})
			
		}
		function submitExtraModule(){
			$('#submitDiv').modal('show'); 
			$('.rangeInput').change(function(){  
				$(this).next().val($(this).val()); 
			});
			$('.extraInput').change(function(){ 
				var score = parseFloat($(this).val());
				if(score >= 0){ 
					if(score > 100){ 
						$(this).val('100'); 
						$(this).prev().val('100');  
					}else{
						$(this).val(Math.round(score*10)/10); 
						$(this).prev().val(Math.round(score)); 
					} 
				}else{   
					$(this).val($(this).prev().val());  
				}
			})
			//提交事件
			$('#extraSubmit').unbind('click').click(function(){ 
				 var jswsValue = $('#jswsInput').val();
				 var ktjlValue = $('#ktjlInput').val();
				 postCheckMain(jswsValue , ktjlValue);
			})
		}
		
		function postCheckMain(jswsValue , ktjlValue){ 
		
			var kuangkeValue = $('#kuangke').text();
			var chidaoValue = $('#chidao').text();
			var zaotuiValue = $('#zaotui').text();
			var qingjiaValue = $('#qingjia').text();
			
			var ratio =(( parseInt(classCount) - (parseInt(kuangkeValue) +  parseInt(chidaoValue) + parseInt(zaotuiValue)) ) /  parseInt(classCount) *100).toFixed(2);
			if(selectCourseType != '任选课'){
				for(var i = 0 ; i < messageArray.length ; i++){
					new $.getPort({
						config:{
							tourl:"postInfData.interface", 
							inf_type:"考勤信息", 
							inf_importance:"0",
							inf_content:"你在第"+selectWeekFlag+"周"+weekArray[selectScheFlag.substring(1,2)]+'/'+setArray[selectScheFlag.substring(2,3)]+"《"+selectCourseName + "》"+messageArray[i].status + "了!",
							inf_post:"质量监控平台",
							inf_get_name:"质量监控平台",
							inf_get:messageArray[i].stu_no,
							inf_system:'qm',
							inf_return_url:'<%=rootpath%>'+"qm/student/person_checking.jsp?module=14&menu=45",
						},
						callback:function(rep){
							if(rep.result == '0'){
								console.log("信息发送失败")
							}else{
							
							}
						}
					});
				}
				if(messageArray.length > 0){
					new $.getPort({ 
						config:{
							tourl:"postInfData.interface", 
							inf_type:"考勤信息",
							inf_importance:"0",
							inf_content:selectClassName+"在第"+selectWeekFlag+"周"+weekArray[selectScheFlag.substring(1,2)]+'/'+setArray[selectScheFlag.substring(2,3)]+"《"+selectCourseName + "》【旷课"+kuangkeValue+"人】、【早退"+zaotuiValue+"人】、【迟到"+chidaoValue+"人】、【请假"+qingjiaValue+"人】,出勤率为"+ratio+"%",
							inf_post:"质量监控平台",
							inf_get_name:"质量监控平台", 
							inf_get:selectClassTeacherNo,
							inf_system:'qm',
							inf_return_url:'<%=rootpath%>'+"qm/student/class_checking.jsp?module=13&menu=41",
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
			messageArray= [];  
			$.ajax({ 
				url : "do?invoke=TeacherCheck@postMainCheckInfo",
				type : 'POST', 
				dataType : 'json',
				data : {
					check_main_no : now_check_main_no,
					check_kk:kuangkeValue,
					check_cd:chidaoValue,
					check_qj:qingjiaValue,
					check_zt:zaotuiValue,
					check_ratio:ratio,
					check_count:classCount,
					jswsValue:jswsValue,
					ktjlValue:ktjlValue
				}, 
				success : function(rep) {
					//  
					if(rep.result == 0){
						$.alert('提交失败');
					}else{ 
						$.alert('考勤提交成功'); 
						//发送消息
						$('.classinf').eq(0).trigger('click'); 
						getStudentInfo(selectSelected , selectCourseType , selectClassNo , now_check_main_no , selectScheFlag , selectWeekFlag , selectScheNo , selectClassName , selectCourseName , selectClassTeacherNo);
					} 
				}
			});
		}
		//点击icon事件
		function iconClick(){
			$('.statusBtn').unbind('click').click(function(event){
				if(!judgeOverTime()){
					$.alert("已超出考勤周期，不可以继续考勤");
					return; 
				}
				event.stopPropagation(); 
				if($(this).parents('.stucard').hasClass('loading')){
					return;
				}
				$(this).parents('.stucard').addClass('loading'); 
				var check_main_no = $(this).parents('.stucard').attr('check_main_no');
				var stu_no  = $(this).parents('.stucard').attr('stu_no');
				var oldStatus = $(this).parents('.stucard').attr('status');
				var newStatus = $(this).attr('data-content');
				var stu_name = $(this).parents('.stucard').find('.name').text();
				 if(oldStatus == newStatus){
					 $(this).parents('.stucard').removeClass('loading'); 
					 return;
				 }
				//TODO:添加到messageArray
				messageManage(stu_no ,newStatus ,stu_name);
				$(this).parents('.stucard').find('.fixStatus').remove();
				$(this).parents('.stucard').prepend($(statusArray[newStatus]));
				changeAmount('minus' , statusFlag[oldStatus]);
				changeAmount('plus' , statusFlag[newStatus]);   
				$(this).parents('.stucard').attr('status',newStatus);
				postStuStatus(check_main_no , stu_no , newStatus);
			})	
		}  
		function changeAmount(flag , status){ 
			if(flag == 'minus'){ 
				$('#'+status+'').text(parseInt($('#'+status+'').text())-1); 
			}else{
				$('#'+status+'').text(parseInt($('#'+status+'').text())+1);
			}
		}
		function postStuStatus(check_main_no , stu_no , check_status){
			
			$.ajax({
				url : "do?invoke=TeacherCheck@postStuStatus",
				type : 'POST', 
				dataType : 'json',
				data : {
					check_main_no : check_main_no,
					stu_no:stu_no , 
					check_status:check_status
				}, 
				success : function(rep) {
					$('.'+check_main_no+'.loading').removeClass('loading');
				}
			});
		}
		function messageManage(stu_no , status ,stu_name){
			for(var i = 0 ; i < messageArray.length ; i ++){
				if(messageArray[i].stu_no == stu_no){
					if(status == '到勤'){
						//删除记录
						messageArray.splice(i,1); 
					}else{
						messageArray[i].status = status;
					}
					return;
				}
			}
			if(status != '到勤'){
				messageArray.push({
					stu_no :stu_no,
					status:status,
					stu_name:stu_name
				});
			}
		}
	});//JQ
	//--------------------------
</script>
<!--这里引用其他JS-->
</html>