<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commonjsp/doctype.jsp"%>
<html>
<head>
<%@ include file="/commonjsp/meta.jsp"%>

<!--这里引用其他样式-->
<title></title>
	<script src="script/common/uploadify/swfobject.js"
	type="text/javascript"></script>

<script src="script/common/uploadify/jquery.uploadify.min.js"
	type="text/javascript"></script>
<style>
	#depdiv .label {
		margin-bottom:10px;
	}          
	.bq {
		display: inline-block;
	    width: auto;
	    vertical-align: baseline; 
	    font-size: .92857143em;
	    font-weight: 700;
	    color: rgba(0,0,0,.87);
	    text-transform: none;
	    margin-bottom: 8px;   
	}
	#bq2 {
		margin-left: 80px;      
	}
    #lgaddstu {
    	float: right;   
    	margin-top: -18px;     
    }      
    .checkmark.icon{
    	cursor:pointer;      
    } 
    #buticon {
    	margin-left: -62px;     
    }
    #lgshowstu {
    	float: right;      
    	margin-top: -18px;     
    	display:none;
    }
    #lgClassStuAddmessage {
    	display:none;
    }
    #lgstuadd {
    	margin-left: 50px;   	
    }
    #lgstuaddSearch {	
    	margin-left: 200px;             
    	margin-top: -40px;
    }
    #addlgstuHide {
    	margin-left: 780px;
    	margin-top: -80px;
    }
    #teaSearch {
    	display: inline-block;
	    margin-left: 18px;
	    margin-top: -36px;      
    }      
    #ClassSearch {
	  	margin-left: 580px;
	    margin-top: -42px;       
    }         
    #bq4 {     
 		margin-top: 38px;
    }
    #bq5 {
	  	margin-left: 25px;
	    margin-top: 24px;        
    }
    #bq6 {           
    	margin-top: -8px;        
    }
    #TaskInforMessage {
    	background-color: white;
    }
    .coursetask.item {
    	width: 600px;       
    	height: 50px;          
    }   
    .classes.item {
    	width: 260px;    
    	height: 38px;    
    }
    .remove.scheDel {   
    	margin-left: 85px;                                                     
    }
    .remove.clickadd_scheDel {   
    	margin-left: 60.5px;                                    
    }
    #tabletitle {
    	width: 17%;
    	font-size: .92857143em;
	    font-weight: 700;  
	    color: rgba(0,0,0,.87);   
    }
    #TaskScheInforPane {
    	margin-top: 20px;       
    }
    #addsche {
    	float: right;   
    	cursor:pointer;    
    }
    #sche_add {
    	float: right;
    	cursor:pointer;
    }
	#searchicon {
		margin-left: -62px;             
	}
 	#addCourse {
		margin-left: 73px;
	} 
	#bq8 {
		margin-left: 180px;      
	}
	#TeachTeaSearch {
		margin-left: 535px;             
		margin-top: -40px;   
		width: 200px;
	}
	.bq.zdyW {
		margin-top: 10px;
		margin-left: 87px;     
	}  
	.bq.zdyWD {
		margin-top: 10px;
		margin-left: 190px;             
	}   
	#bq9 {
		margin-top: 10px;
	}   
	#courseattr {  
		margin-left: 10px;      
	}  
	#courseweek {
		margin-left: 20px;
	}
	#ccount {
		margin-left: 32px;
	}
	#scount {
		margin-left: 48px;      
	}
	.ui.small.input.zdyW {
		width: 150px;  
	}
	#bq14 {
		margin-top: 20px;
	}
	#ClassesSearch {
		margin-left: 80px;    
		margin-top: -33px;       
	}
   
	#AddCoursename {
		margin-left: 60px;  
		margin-top: -8px;   
	}
	#bq17 {
		margin-left: 300px;
	}
	#TaskScheInforPane {
		display:none;   
	}
	.Class_Del.remove {
		margin-left: 20px;
	}
	#classschetab {
		display:none;
	}
	.newScheDel.remove {
		margin-left: 70px;
	}
	 .scheinfor.item {
	 	width: 700px;      
    	height: 50px;          
    }  
    #classschetab {
    	margin-top: 20px;      
    }
    .file.import {
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
	    width:130px;
	    text-align:center;
	    height:15%;
	    padding: 0.3em;
	}
	#Clickmore {
		height: 50px;
        background-color: #F9FAFB;
        cursor:pointer;     
	}
	#ButtMore {
		margin-left: 43%;          
   		margin-top: 6px;
   		cursor:pointer;          
	}
	#lgClickmore {
		height: 50px;
        background-color: #F9FAFB;
        cursor:pointer;
	}
	#lgButtMore {
		margin-left: 43%;          
   		margin-top: 6px;
   		cursor:pointer;  
	}
	.updLabel {
		width: 180px;
	}

</style>
<script src="script/common/echarts/echarts-all.js"></script>
</head>
<body>
	<%@ include file="/commonjsp/header.jsp"%>
	
	<%
		//接收参数
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String term_no = "";
		if(request.getParameter("term_no") != null) {
			term_no = (String) request.getParameter("term_no");
		} 
	%>
	
	
	<div id="container">
			<h3  class="ui header "> 
		  			<i class="unordered list icon"></i>
		  			<div class="content">课程维护</div>
			</h3>
		
			<div id="depdiv">
				<a class="ui blue label" id="all">全&nbsp;&nbsp;&nbsp;&nbsp;部</a>
			</div>
			
			<select class="ui mini dropdown" id="dropdown">
			</select>

			<div class="ui search" style="margin-top: -43px;margin-left: 250px;">
		  		<div class="ui icon input">    
				    <input class="prompt" id="SearchMHTea" type="text" placeholder="可输入搜索各类相关信息"> 
				</div>         
				<button class="circular ui basic mini button"  id="searchicon" data-content="点击搜索" data-variation="small"><i class="search large icon"></i></button>
			</div>
			<div style="margin-left: 550px;margin-top: -43px;">   
				<button class="ui basic button" id="import_dr" data-content="点击导入" data-variation="small"><i class="sign in icon"></i> 导 入 </button>
				<button class="ui basic button" id="export_dc" data-content="点击导出" data-variation="small"><i class="upload icon"></i> 导 出 </button>
				<button class="ui basic blue small button"  id="addCourse" data-content="点击新添课程" data-variation="small"><i class="plus icon"></i> 新添课程 </button>
			</div>
			   
			<div id="ImportMod" class="ui modal">
				<i class="close icon" style="float: right;"></i>
				<div class="header" id="statusExcelTitle">导入课程信息</div>
				<div class="content">
					<label class="bq">导入课程数据：</label>
					 <a href="javascript:;" class="file import">
						<input  type="file" name="courseuploadify" id="courseuploadify" />
					 </a>

					 <p></p>   
					 <label class="bq">下载数据模板：</label> 
					 <a class="selectButton ui red small labeled icon add button" href=""><i class="download icon"></i>下载课程模板</a>
				</div>
				<div class="actions">   
				      <div class="ui positive right labeled icon button" id="excelImportSaveModal"> 导 入 <i class="checkmark icon"></i></div>
				</div>
			 </div>

			<div id="AddCourseMod" class="ui modal">
			  <div class="header">
			  	新添课程信息：      
			  	<i class="close icon" style="float: right;"></i>                
			  </div>
			    <div class="content">      
				  	<div class="description">
				  		<div class="ui message" id="AddCourseInforMessage">
				  			<label class="bq" id="bq7">课程代码：</label> 
				  			<label class="bq zdyWD" id="bq15">课程名称：</label>    
				  			<label class="bq zdyWD" id="bq16">授课教师：</label> 
				  			  
				  			<div class="ui small input zdyWD">
								<input type="text" placeholder="例：110042363" id="AddCourseno" value="">     
							</div>
							<div class="ui small input zdyWD">   
								<input type="text" placeholder="例：*计算机应用基础" id="AddCoursename" value="">     
							</div>             
							      
			  				<div class="ui small search" id="TeachTeaSearch">            
								<div class="ui icon input">
									<input class="prompt" type="text" id="SeaTeano" placeholder="可搜索教师姓名、工号">
									<i class="search icon"></i>
								</div>    
								<div class="results">        
								</div>
							</div>
							
							<label class="bq" id="bq9">课程类型：</label>     
				  			<label class="bq zdyW" id="bq10">课程属性：</label>
				  			<label class="bq zdyW" id="bq11">课程周数：</label> 
				  	        <label class="bq zdyW" id="bq12">课程课时：</label>  
				  			<label class="bq zdyW" id="bq13">上课人数：</label> 
				  			 
							<div class="ui small input zdyW">
								<input type="text" placeholder="例：讲授课" id="coursetype" value="">     
							</div>               
							<div class="ui small input zdyW">   
								<input type="text" placeholder="例：公共基础课" id="courseattr" value="">     
							</div>
							<div class="ui small input zdyW">
								<input type="text" placeholder="例：1-18" id="courseweek" value="">           
							</div>
							<div class="ui small input zdyW">
								<input type="text" placeholder="例：32" id="ccount" value="">           
							</div>
							<div class="ui small input zdyW">
								<input type="text" placeholder="例：40" id="scount" value="">           
							</div>
							
							<label class="bq" id="bq14">授课班级：</label>  
							<label class="bq" id="bq17">所属院系：</label>           
							<div class="ui small search" id="ClassesSearch">   
								<div class="ui icon input">
									<input class="prompt" type="text" id="SeaClassno" placeholder="可搜索班级名称、编号">   
									<i class="search icon"></i>
								</div>     
								<div class="results">
								</div>  
							</div>
							<div style="margin-top: -37px;margin-left: 470px;">         
								<div class="ui dropdown" id="depselect">
								  	<div class="text">选择部门</div>
						   		  		<i class="dropdown icon"></i>
							  			<div class="menu" style="max-height:168px;overflow-y:scroll;">
							    						    
							  			</div>
								</div>
							</div>
							<div class="ui message" style="background-color: white;min-height: 60px;/* width: 300px; */margin-top: 25px;">               
							       <label class="bq" >所选班级 (可多选)：</label>
							       <div id="ClassesPane" >
							       
							       </div>   
							</div>
							<div class="ui message" style="background-color: white;min-height: 60px;/* width: 500px;margin-left: 305px;margin-top: -76px; */">               
							       <label class="bq" >所选节次 (可多选)：</label>  
							       <i class="plus large icon" id="sche_add" data-content="添加节次" data-variation="small"></i>
							       <div id="ClassesTasksPane">    
							           
							       </div>
							       <div id="ClassesTasksTablePane">
							       			<table class="ui small definition table" id="classschetab">  
												<thead>
													<tr> 
														<th id="tabletitle">选择上课节次</th>   
														<th>星期一</th>
														<th>星期二</th>   
														<th>星期三</th>
														<th>星期四</th>
														<th>星期五</th>
														<th>星期六</th> 
														<th>星期天</th>
													</tr>
												</thead>
												<tbody>          
													<tr id="K1">   
														<%--<td>1-2节</td>--%>
														<td>第1节</td>
														<td id="K11" class="z1"><i class="checkmark icon"></i></td>               
														<td id="K21" class="z2"><i class="checkmark icon"></i></td>   
														<td id="K31" class="z3"><i class="checkmark icon"></i></td>
														<td id="K41" class="z4"><i class="checkmark icon"></i></td>
														<td id="K51" class="z5"><i class="checkmark icon"></i></td>
														<td id="K61" class="z6"><i class="checkmark icon"></i></td>
														<td id="K71" class="z7"><i class="checkmark icon"></i></td>
													</tr>
													<tr id="K2">
														<%--<td>3-4节</td>--%>
														<td>第2节</td>
														<td id="K12" class="z1"><i class="checkmark icon"></i></td>
														<td id="K22" class="z2"><i class="checkmark icon"></i></td>
														<td id="K32" class="z3"><i class="checkmark icon"></i></td>
														<td id="K42" class="z4"><i class="checkmark icon"></i></td>
														<td id="K52" class="z5"><i class="checkmark icon"></i></td>
														<td id="K62" class="z6"><i class="checkmark icon"></i></td>
														<td id="K72" class="z7"><i class="checkmark icon"></i></td>      
													</tr>
													<tr id="K3">
														<%--<td>5-6节</td>--%>
														<td>第3节</td>
														<td id="K13" class="z1"><i class="checkmark icon"></i></td>
														<td id="K23" class="z2"><i class="checkmark icon"></i></td>
														<td id="K33" class="z3"><i class="checkmark icon"></i></td>
														<td id="K43" class="z4"><i class="checkmark icon"></i></td>
														<td id="K53" class="z5"><i class="checkmark icon"></i></td>
														<td id="K63" class="z6"><i class="checkmark icon"></i></td>
														<td id="K73" class="z7"><i class="checkmark icon"></i></td>
													</tr>
													<tr id="K4">
														<%--<td>7-8节</td>--%>
														<td>第4节</td>
														<td id="K14" class="z1"><i class="checkmark icon"></i></td>
														<td id="K24" class="z2"><i class="checkmark icon"></i></td>
														<td id="K34" class="z3"><i class="checkmark icon"></i></td>
														<td id="K44" class="z4"><i class="checkmark icon"></i></td>
														<td id="K54" class="z5"><i class="checkmark icon"></i></td>
														<td id="K64" class="z6"><i class="checkmark icon"></i></td>
														<td id="K74" class="z7"><i class="checkmark icon"></i></td>
													</tr>
													<tr id="K5">
														<%--<td>9-10节</td>--%>
														<td>第5节</td>
														<td id="K15" class="z1"><i class="checkmark icon"></i></td>   
														<td id="K25" class="z2"><i class="checkmark icon"></i></td>
														<td id="K35" class="z3"><i class="checkmark icon"></i></td>
														<td id="K45" class="z4"><i class="checkmark icon"></i></td>
														<td id="K55" class="z5"><i class="checkmark icon"></i></td>
														<td id="K65" class="z6"><i class="checkmark icon"></i></td>      
														<td id="K75" class="z7"><i class="checkmark icon"></i></td>  
													</tr>
													<tr id="K6">
														<td>第6节</td>
														<td id="K16" class="z1"><i class="checkmark icon"></i></td>
														<td id="K26" class="z2"><i class="checkmark icon"></i></td>
														<td id="K36" class="z3"><i class="checkmark icon"></i></td>
														<td id="K46" class="z4"><i class="checkmark icon"></i></td>
														<td id="K56" class="z5"><i class="checkmark icon"></i></td>
														<td id="K66" class="z6"><i class="checkmark icon"></i></td>
														<td id="K76" class="z7"><i class="checkmark icon"></i></td>
													</tr>
													<tr id="K7">
														<td>第7节</td>
														<td id="K17" class="z1"><i class="checkmark icon"></i></td>
														<td id="K27" class="z2"><i class="checkmark icon"></i></td>
														<td id="K37" class="z3"><i class="checkmark icon"></i></td>
														<td id="K47" class="z4"><i class="checkmark icon"></i></td>
														<td id="K57" class="z5"><i class="checkmark icon"></i></td>
														<td id="K67" class="z6"><i class="checkmark icon"></i></td>
														<td id="K77" class="z7"><i class="checkmark icon"></i></td>
													</tr>
													<tr id="K8">
														<td>第8节</td>
														<td id="K18" class="z1"><i class="checkmark icon"></i></td>
														<td id="K28" class="z2"><i class="checkmark icon"></i></td>
														<td id="K38" class="z3"><i class="checkmark icon"></i></td>
														<td id="K48" class="z4"><i class="checkmark icon"></i></td>
														<td id="K58" class="z5"><i class="checkmark icon"></i></td>
														<td id="K68" class="z6"><i class="checkmark icon"></i></td>
														<td id="K78" class="z7"><i class="checkmark icon"></i></td>
													</tr>
												</tbody>
											</table>
							       </div>     
							</div>
				  		</div>
				  	</div>
				</div>    
				<div class="actions">   
				    <div class="ui positive right labeled icon button" id="AddSubmit"> 提 交 <i class="checkmark icon"></i></div>
				 </div>   
			</div>

			<table class="ui compact blue table">    
				  <thead>
				    <tr>   
				      <th>课程名称</th>
				      <th>课程类型</th>
				      <th>授课班级</th>
				      <th>任课教师</th>
				      <th>操 作</th>
				    </tr>
				  </thead>     
				  <tbody id="coursetable">
				  </tbody>
			</table>		
			
			<div id="modCourseInfor" class="ui long modal">
			  <div class="header">
			  	课程详细信息：
			  	<i class="close icon" style="float: right;"></i>                
			  </div>
			    <div class="content">      
				  	<div class="description">
				  		<div class="ui message" id="courseInforMessage">
				  				<label class="bq" id="bq6">课程名称：</label> 
								<div class="ui small input updLabel">
								  <input type="text" placeholder="" id="coursename">     
								</div>
			  					<label class="bq" id="courseterm">课程类型：</label>
			  					<%--<div class="ui small input input updLabel">--%>
									<select class="ui mini dropdown" id="course_type">
										<option class="subjuct_kind" value="讲授课">讲授课</option>
										<option class="subjuct_kind" value="实训课">实训课</option>
										<option class="subjuct_kind" value="任选课">任选课</option>
									</select>
								  <%--<input type="text" placeholder="" id="">   --%>
								<%--</div>--%>
								<label class="bq" id="bqweeks">上课周数：</label>
			  					<div class="ui small input updLabel" style="width: 19%">
								  <input type="text" placeholder="" id="course_weeks">       
								</div>
				  				<label class="bq" id="bq4">授课教师：</label>      
				  				<div class="ui small search" id="teaSearch">
									<div class="ui icon input">
										<input class="prompt" type="text" id="teach_teano" placeholder="可搜索修改教师姓名、工号">
										<i class="search icon"></i>
									</div>
									<div class="results">
									</div>
								</div>   
											
								    
								<label class="bq" id="bq5">授课班级：</label>     
								<div class="ui small search" id="ClassSearch">   
									<div class="ui icon input">
										<input class="prompt" type="text" id="teach_class" placeholder="可搜索修改班级名称、编号">
										<i class="search icon"></i>
									</div>
									<div class="results">
									</div>
								</div>
			  			</div>
			  			
			  			<div class="ui message" id="TaskInforMessage">
			  				 <i class="plus large icon" id="addsche" data-content="新添节次" data-variation="small"></i>
			  				<div id="TaskInforPane" style="min-height: 60px;">    
			  				       
			  				</div>
			  				<div id="TaskScheInforPane">
			  					<table class="ui small definition table" id="tableset">  
									<thead>
										<tr> 
											<th id="tabletitle">选择上课节次</th>   
											<th>星期一</th>
											<th>星期二</th>   
											<th>星期三</th>
											<th>星期四</th>
											<th>星期五</th>
											<th>星期六</th> 
											<th>星期天</th>
										</tr>
									</thead>
									<tbody>
										<tr id="K1">
											<td>第1节</td>
											<td id="K11" class="z1"><i class="checkmark icon"></i></td>
											<td id="K21" class="z2"><i class="checkmark icon"></i></td>
											<td id="K31" class="z3"><i class="checkmark icon"></i></td>
											<td id="K41" class="z4"><i class="checkmark icon"></i></td>
											<td id="K51" class="z5"><i class="checkmark icon"></i></td>
											<td id="K61" class="z6"><i class="checkmark icon"></i></td>
											<td id="K71" class="z7"><i class="checkmark icon"></i></td>
										</tr>
										<tr id="K2">
											<td>第2节</td>
											<td id="K12" class="z1"><i class="checkmark icon"></i></td>
											<td id="K22" class="z2"><i class="checkmark icon"></i></td>
											<td id="K32" class="z3"><i class="checkmark icon"></i></td>
											<td id="K42" class="z4"><i class="checkmark icon"></i></td>
											<td id="K52" class="z5"><i class="checkmark icon"></i></td>
											<td id="K62" class="z6"><i class="checkmark icon"></i></td>
											<td id="K72" class="z7"><i class="checkmark icon"></i></td>
										</tr>
										<tr id="K3">
											<td>第3节</td>
											<td id="K13" class="z1"><i class="checkmark icon"></i></td>
											<td id="K23" class="z2"><i class="checkmark icon"></i></td>
											<td id="K33" class="z3"><i class="checkmark icon"></i></td>
											<td id="K43" class="z4"><i class="checkmark icon"></i></td>
											<td id="K53" class="z5"><i class="checkmark icon"></i></td>
											<td id="K63" class="z6"><i class="checkmark icon"></i></td>
											<td id="K73" class="z7"><i class="checkmark icon"></i></td>
										</tr>
										<tr id="K4">
											<td>第4节</td>
											<td id="K14" class="z1"><i class="checkmark icon"></i></td>
											<td id="K24" class="z2"><i class="checkmark icon"></i></td>
											<td id="K34" class="z3"><i class="checkmark icon"></i></td>
											<td id="K44" class="z4"><i class="checkmark icon"></i></td>
											<td id="K54" class="z5"><i class="checkmark icon"></i></td>
											<td id="K64" class="z6"><i class="checkmark icon"></i></td>
											<td id="K74" class="z7"><i class="checkmark icon"></i></td>
										</tr>
										<tr id="K5">
											<td>第5节</td>
											<td id="K15" class="z1"><i class="checkmark icon"></i></td>
											<td id="K25" class="z2"><i class="checkmark icon"></i></td>
											<td id="K35" class="z3"><i class="checkmark icon"></i></td>
											<td id="K45" class="z4"><i class="checkmark icon"></i></td>
											<td id="K55" class="z5"><i class="checkmark icon"></i></td>
											<td id="K65" class="z6"><i class="checkmark icon"></i></td>
											<td id="K75" class="z7"><i class="checkmark icon"></i></td>
										</tr>
										<tr id="K6">
											<td>第6节</td>
											<td id="K16" class="z1"><i class="checkmark icon"></i></td>
											<td id="K26" class="z2"><i class="checkmark icon"></i></td>
											<td id="K36" class="z3"><i class="checkmark icon"></i></td>
											<td id="K46" class="z4"><i class="checkmark icon"></i></td>
											<td id="K56" class="z5"><i class="checkmark icon"></i></td>
											<td id="K66" class="z6"><i class="checkmark icon"></i></td>
											<td id="K76" class="z7"><i class="checkmark icon"></i></td>
										</tr>
										<tr id="K7">
											<td>第7节</td>
											<td id="K17" class="z1"><i class="checkmark icon"></i></td>
											<td id="K27" class="z2"><i class="checkmark icon"></i></td>
											<td id="K37" class="z3"><i class="checkmark icon"></i></td>
											<td id="K47" class="z4"><i class="checkmark icon"></i></td>
											<td id="K57" class="z5"><i class="checkmark icon"></i></td>
											<td id="K67" class="z6"><i class="checkmark icon"></i></td>
											<td id="K77" class="z7"><i class="checkmark icon"></i></td>
										</tr>
										<tr id="K8">
											<td>第8节</td>
											<td id="K18" class="z1"><i class="checkmark icon"></i></td>
											<td id="K28" class="z2"><i class="checkmark icon"></i></td>
											<td id="K38" class="z3"><i class="checkmark icon"></i></td>
											<td id="K48" class="z4"><i class="checkmark icon"></i></td>
											<td id="K58" class="z5"><i class="checkmark icon"></i></td>
											<td id="K68" class="z6"><i class="checkmark icon"></i></td>
											<td id="K78" class="z7"><i class="checkmark icon"></i></td>
										</tr>
									</tbody>
								</table>
			  				</div>        
			  			</div>   
				  	</div>
			     </div>
			     <div class="actions">
				    <div class="ui positive right labeled icon button" id="updSubmit"> 提 交 <i class="checkmark icon"></i></div>
				 </div>   
			 </div>
			
			<div id="modLogicStu" class="ui modal">
			  <div class="header">
			  	任选课学生信息：
			  	<i class="close icon" style="float: right;"></i>                
			  </div>
			  <div class="content">      
			  	<div class="description">
			  		<div class="ui message" id="lginformessage">
			  					  			
			  		</div>  
			  		<div>
				  		<div class="ui search">
					  		<div class="ui icon input"> 
							    <input class="prompt" id="stusearch" type="text" placeholder="输入学生学号、姓名"> 
							</div>      
							<button class="circular ui basic mini button"  id="buticon" data-content="点击搜索" data-variation="small"><i class="search large icon"></i></button>
						</div>
				  		<button class="ui basic brown mini button"  id="lgaddstu"><i class="plus icon"></i> 添加学生 </button>   
						<button class="ui basic black mini button"  id="lgshowstu"><i class="reply all icon"></i> 显示全部 </button>
			  		</div>       
			  		 
           			<div class="ui message" id="lgClassStuAddmessage">
			  			<label class="bq">新增学生：</label> 						
	                    <i class="angle large double up icon" id="addlgstuHide" data-content="点击收起" data-variation="small"></i>
						<div class="ui search" id="lgstuaddSearch">                           
							  <div class="ui icon input">                
							    <input class="prompt" id="addstuSearch" type="text" placeholder="学生姓名、学号...">
							    <i class="search icon"></i>
							  </div>                      
						  	  <div class="results"></div>    
							  <button class="ui white small button" type="submit" id="lgstuadd"><i class="checkmark box icon"></i> 添 加 </button>			  			
						</div>
			  		</div>     
			  		
			  		<div class="ui message" style="background-color:white; max-height:500px;overflow-y:scroll;">
				  		<table class="ui very compact striped table" id="modlgtable">   
						  <thead>         
						    <tr>        
						      <th>学号</th>     
						      <th>学生姓名</th>
						      <th>学生状态</th>
						      <th>移除</th>      
						    </tr>
						  </thead>
						  <tbody id="modLogicStuInfor">
						  </tbody>
						</table>
					</div>				  
			    </div>
			  </div>
			</div>
		
	</div>
	<!--这里绘制页面-->
</body>

<script type="text/javascript">
	    $(function(){    	        
	    	downAllTerm();               
			var termid= "";   
			var czterm_no = "";
			czterm_no = '<%=term_no%>';
			var dqdepno="";
			var bjrs = "";        
			var lgclass = "";
			var stuid = "";
			var flag = "";
			var teaid = "";
			var classid = "";    
			var addteaid = "";
			var courseDep = "";
	    	var classesno = {}; 
	    	var newscheInfor = {};   
	    	var courseFilePath="";  
	    	var pagenum = 10;
	    	var times = 0;   
	    	var flag2 = 0;    
	    	var lgpagenum = 10;   
	    	var lgtimes = 0;
	    	var flag3 = 0;
	    	var search_val = "";   
	    	var purview=USEROBJECT.userpurview;
	    	
	    	$("#depdiv").hide();  
	    	$("#import_dr").popup();
	    	$("#export_dc").popup();   
			if(purview=="ALL"){
				initDep();
				dqdepno="all";
		//		loadDepData(dqdepno);      
		
			}else{
				dqdepno=USEROBJECT.userinfo.dep_no;
		//		loadDepData(dqdepno);
			}

			 
	    	//初始化部门
	    	function initDep(){
	    		//1、从公共变量获得部门数据
	    		var deps=SYSOBJECT.departments;
	    		
	    		//2、绘制到页面中
	    		$("#depdiv .dep").remove();
	    		for(var i=0;i<deps.length;i++){
					if (deps[i].dep_type!="行政"){
						var depdiv=$('<a class="dep ui gray label"" id="'+deps[i].dep_no+'">'+deps[i].dep_name+'</a>');
						$("#depdiv").append(depdiv);
					}

	    		}
	    		$("#depdiv").fadeIn();
	    		//3.绑定点击事件
	    		$("#depdiv .label").click(function(){
	    			$("#depdiv .blue").removeClass("blue");
	    			$(this).addClass("blue");
	    			flag2 = 0;    
	    			times = 0;               
	    			var dep_no=this.id;
	    			dqdepno=dep_no;
	    			loadDepData(dqdepno);
	    		});
	    	}

	    	//导出功能
	    	$("#export_dc").unbind('click').click(function(){
				var params = [];
				if(dqdepno == "all") {
					params.push(termid);
					var type = "excel";
					open(BASE_PATH+"/qm/base/export.jsp?export_id=7&params="+params+"&type="+type+"&more=1");
				} else {
					params.push(termid);
					params.push(dqdepno);
					var type = "excel";   
					open(BASE_PATH+"/qm/base/export.jsp?export_id=5&params="+params+"&type="+type+"&more=1");
				}
				
	    	});
	    	
	    	//导入功能
	    	$("#import_dr").unbind('click').click(function(){
	    		showmodel();
	    	});
	//    	console.log(czterm_no);       
	    	if(czterm_no==null ||czterm_no==""){
	    		
	    	}else{
	    		showmodel();
	    	}
	    	
	    	 function showmodel(){
	    		 $("#ImportMod").modal({
	    				transition:'slide down',
	    				observeChanges:true,
	    				closable:false                
	    			}).modal('show'); 
	    		    $("#excelImportSaveModal.lg").removeClass("lg");
		    		$("#excelImportSaveModal").addClass("kc");
		    		
	    		    $('.selectButton').attr("href","template/newcourse_mb.xls");
	    			initFilePath();
	    			
	    			
	    			  //课程数据导入 coursetemplate.xls
	    		    $("#excelImportSaveModal.kc").unbind('click').click(function() {
	    		    	var temr_noT = "";
	    		    	if(czterm_no==null ||czterm_no==""){
	    		    		temr_noT=termid;
	    		    	}else{
	    		    		temr_noT=czterm_no;
	    		    	}
	    				$.ajax({
	    					url:"do?invoke=baseCourseWH@importExcelBaseCourse",
	    					type:'POST',
	    					dataType:'json',
	    					data:{
	    						term_no:temr_noT,
	    						course_file_path:courseFilePath,
	    					},
	    					success:function(rep) {
	    						$.alert(rep.message);
	    					}
	    				});
	    			    $("#ImportMod").modal({
	        				transition:'slide down',
	        				observeChanges:true,
	        				closable:false                
	        			 }).modal('hide'); 
	    			});
	    	 }
	    	//新课程信息的添加
	    	$("#addCourse").popup();
	    	$("#addCourse").unbind('click').click(function(){
	    		$("#AddCourseMod").modal({
    				transition:'slide down',
    				observeChanges:true,
    				closable:false                
    			}).modal('show'); 
	    		courseDep = "";   
	    		AllDeps(); 
	    		addteaid = ""; 
	    		var sche_id = 0;  
	    		$("#bq16").text("授课教师：   ");  
	    		$("#ClassesPane").empty();     
	    		$("#ClassesTasksPane").empty();                          
	    		$("#AddCourseno").val("");
	    		$("#AddCoursename").val("");
	    		$("#SeaTeano").val("");
	    		$("#coursetype").val("");     
	    		$("#courseattr").val("");    
	    		$("#courseweek").val("");    
	    		$("#ccount").val("");
	    		$("#scount").val("");  
	    		$("#SeaClassno").val("");  
	    		$("#sche_add").popup();           
	    		var itemid = 0;
				classesno = {};	    	
				newscheInfor = {};
	    		TeasClassesSearch(itemid);     	
	    		
	    		//点击新课程的添加节次按钮
	    		$("#sche_add").unbind('click').click(function(){
	    			$("#classschetab").show();            
	    			$('#AddCourseMod').modal('refresh');    
	    			ClickIconAddScheInfor();
	    		});
	    		
	    		//新添课程里的节次表图标点击事件
	    		function ClickIconAddScheInfor() {
	    			$('#classschetab').find(".checkmark").unbind('click').click(function(){
	    				var scheid = $(this).parents('td').attr("id");
	    				var zcV = scheid.substring(1,2);
	    				var jcV = scheid.substring(2,3);
	    				schezc = WEEK[zcV];
	    				schejc = COURSE_JC_SINGLE[jcV];
	    				var tep = 
	    					'<div class="ui middle aligned selection list">'+
								'<div class="scheinfor item" id="add'+sche_id+'">'+ 
									'<div class="bq"  id="">  节 次   &nbsp;&nbsp;——&nbsp;&nbsp; 【 '+   schezc   +'&nbsp;&nbsp;:   '+   schejc   +' 】&nbsp;&nbsp;&nbsp;&nbsp; 上课地点：'+
										'<div class="ui mini input">'+
										  '<input type="text" placeholder="" id="addrVadd'+sche_id+'" value="">'+          
										'</div>'+     
										'<i class="newScheDel remove red large circle icon" id="add'+sche_id+'" data-content="删除" data-variation="small"></i>'+
									'</div>'+
								'</div>'+        
							'</div>';
							$("#ClassesTasksPane").append($(tep));     
							$("#classschetab").hide();    
							var newscheid = "add"+sche_id;
							var newaddrval = $("#addrV"+newscheid).val();
							newscheInfor[newscheid] = scheid+"-o-"+newaddrval;
							newScheDel(newscheid);
							sche_id = sche_id +1;
	    			});	
	    		}
	    		
	    		//新增课程里的新添节次元素删除
	    		function newScheDel(scheid){
    		    	$('.newScheDel').unbind('click').click(function(){                                                         
    		    		var delno = $(this).attr("id");                          
    					$("#"+delno+'.scheinfor.item').parents('.list').remove();                   
    				});    
	    		}
	    		

	    		//点击添加新课程的提交按钮
				$("#AddSubmit").unbind('click').click(function(){   
		    		var courseDM = $("#AddCourseno").val();
		    		var courseMC = $("#AddCoursename").val();                  
		    		var courseType = $("#coursetype").val();    
		    		var courseAttr = $("#courseattr").val();    
		    		var courseWeeks = $("#courseweek").val();    
		    		var courseKS = $("#ccount").val();
		    		var courseRS = $("#scount").val();  
//		    		console.log(courseDM,courseMC,addteaid,courseType,courseAttr,courseWeeks,courseKS,courseRS,courseDep);
					$.each(newscheInfor,function(id,value) {
						newscheInfor[id] = newscheInfor[id].split('-o-')[0]+"-o-"+$("#addrV"+id).val();	      
						console.log(newscheInfor[id]);               
				    }); 
    
					console.log("^^^^^^^^^^^^^^^^^6");
					console.log(JSON.stringify(classesno));
					console.log(classesno); 
					console.log(newscheInfor);      
					if(JSON.stringify(classesno) == "{}" && courseType != "任选课") {                         
						$.alert("课程添加信息没有班级数据，此信息无法添加！");  
						return;        
					}
//					console.log(termid);                
		    		$.ajax({
	    				url:"do?invoke=baseCourseWH@InsCourseInforData",
						type:'POST',   
						dataType:'json',
						data:{
							termno:termid,
							courseno:courseDM,
							coursename:courseMC,
							courseteano:addteaid,
							coursetype:courseType,
							courseattr:courseAttr,
							courseweek:courseWeeks,
							courseccount:courseKS,
							coursescount:courseRS,
							coursedep:courseDep,  
							courseclassno:JSON.stringify(classesno),
							coursescheInfor:JSON.stringify(newscheInfor)
						},
						success:function(rep) {
							console.log(rep);
							if(rep.result == 0){
								$.alert("很抱歉，新课程信息添加失败！");   
								return;
							} else {
								$.alert("课程添加成功！");   
								if(search_val != "" || search_val != null) {
									$("#coursetable").empty();     
									times = 0;      
									SeaCourse(search_val);    
								} else {      
									loadDepData(dqdepno);  
								}
								   
							//	$.alert(rep.message);   
							}
						}
		    		});
					
				});
	    	});
	    	
	    	
	    	
	    	function DrawClassesItem(item,itemid) {     
	    		var temp = 	    			 
	    			'<div class="ui middle aligned selection list">'+   
						'<div class="classes item" id="class'+itemid+'">'+ 
							'<div class="bq"  id="">' + item.title + '【 '+ item.description +'】'+           
								'<i class="Class_Del remove red  circle icon" id="class'+itemid+'" data-content="删除" data-variation="small"></i>'+
							'</div>'+
						'</div>'+           
					'</div>';
				$("#ClassesPane").append($(temp));
				$("#SeaClassno").val("");            
				classesno['class'+itemid] = item.title;        
				DelClassltem();
	    	}              
	    	
	    	function DelClassltem() {
		    	$(".Class_Del").unbind('click').click(function(){
		    		var classdelno = $(this).attr("id");             
		    		$(this).parents('.list').remove();
		    		classesno[classdelno] = null;               
		    	});
	    	}
	    	
	    	
	    	function AllDeps() {
				$.ajax({
					url:"do?invoke=supervisorMarkAdd@getAllDeps",
					type:'POST',
					dataType:'json',
					success:function(rep) {
						if(rep.result == 0) {  
							$.alert("很抱歉，没有取到院系相关信息！");
							return;
						} else {
							var departments = rep.data;
							renderDepSelect(departments, rep.data.length);	
						}
					}
				});
			}
			
			function renderDepSelect(departments,length){
				for(var i=0; i<length; i++) {
					var dom=$('<div class="item" id="'+departments[i].dep_no+'" data-value="'+departments[i].dep_no+'"> '+departments[i].dep_name+'</div>');
					if(USEROBJECT.userpurview=="ALL"){
						depi = 0;
						$("#depselect .menu").append(dom);
					}else{					
						if(departments[i].dep_no==USEROBJECT.userpurview){
							depi = i;
							$("#depselect .menu").append($('<div class="item" id="'+departments[i].dep_no+'" data-value="'+departments[i].dep_no+'"> '+departments[i].dep_name+'</div>'));
						}
					}
				}
				$('#depselect').dropdown({        
					maxSelections: 3,
					onChange:function(value,text){
						courseDep = value;
			//			console.log(value);    
					}
				}).dropdown("set selected",departments[depi].dep_no);                 
			}
	 
	    	
	    	
	    	
	    	//课程相关信息搜索
	    	$("#searchicon").popup();          
	    	$("#searchicon").unbind('click').click(function(){
	    		search_val = $("#SearchMHTea").val();
	    		if(search_val == null || search_val == "") {
	    			times = 0;  
					$("#coursetable").empty(); 
					loadDepData(dqdepno); 
	    			
	    		//	$.alert("您还没有输入任何搜索值！");       
	    		} else {
	    			flag2 = 0;    
	    			times = 0; 
	    			$("#coursetable").empty();  
	    			SeaCourse(search_val);
	    		}
	    	});
	    	
	    	//课程搜索的Ajax请求
	    	function SeaCourse(search_val) {
    			$.ajax({
    				url:"do?invoke=baseCourseWH@getSearchCourseData",
					type:'POST',   
					dataType:'json',
					data:{
						depno:dqdepno,     
						termno:termid,
						searchval:search_val,
						pagenum:pagenum,
						times:times
					},
					success:function(rep) {
						console.log("获取到数据：",rep);
						if(rep.result == 0) {
							if(flag2 == 3) {
								$("#Clickmore").remove();  
								$.alert("只有这么多啦，没有搜索到更多相关数据！");         
								return;
							}
							$.alert("没有搜索到相关课程数据，您可以换个搜索条件试试！");   
							return;
						} else {
							if(flag2 == 3) {
								$("#Clickmore").remove();
							}
							$("#SearchMHTea").val("");    
							var searchData = rep.data;	  
							if(flag2 == 1) {
								$("#Clickmore").remove();        
							}
							flag2 = 3;
							DrawTableData(searchData,dqdepno,search_val);
						}
					}  
				});	    				
			}
	    	
	    	
	    	//页面表格的绘制
	    	function DrawTableData(Data,depno,search_val) {
				for(var i=0; i<Data.length; i++) {
					var course_name = Data[i].course_name;
					if (course_name.length > 16) {  
						course_name= course_name.substring(0,16) + "……"; 
					}
					var dom =
						'<tr>'+
							'<td>'+ course_name +'</td>'+                
							'<td>'+ Data[i].course_type +'</td>';     
							if(/* (Data[i].class_no == null || Data[i].class_no == "") && */ Data[i].course_type == "任选课") { 
								dom +=
									'<td>'+
										'<div class="infor circular ui brown basic icon button" id="'+ Data[i].task_no +'" course_no="'+Data[i].course_no+'">'+
					                        '<i class="file text brown icon"></i>'+
						                '</div>'+
						             '</td>';                 
							} else {      
								dom += 
									'<td>'+ Data[i].class_name +'</td>';		
							}       
							dom +=
							'<td>'+ Data[i].teacher_name +'</td>'+
							'<td>'+
								'<div class="upd circular ui blue basic icon button" id="'+ Data[i].task_no +'">'+
			                        '<i class="edit blue icon"></i>'+
				                '</div>'+ 
				                '<div class="del circular ui red basic icon button" id="'+ Data[i].task_no +'">'+
			                        '<i class="remove red icon"></i>'+
				                '</div>'+
							'</td>'+
						 '</tr>';     
						$("#coursetable").append($(dom));
				}
				var courselength = Data.length;    
				if(courselength >= pagenum) {       
					$("#coursetable").append($('<tr id="Clickmore"><td colspan="5"><label class="bq" id="ButtMore"><i class="spinner icon"></i> 显示更多 </label></td></tr>'));                   
					if(flag2 != 3) {
						$("#Clickmore").unbind('click').click(function(){
							console.log("abcvvvvvvvvvvvvvvvvv");  
							times = times + 1;
							flag2 = 1;         
							loadDepData(depno);		 				    
						});   
					} else {
						$("#Clickmore").unbind('click').click(function(){
							console.log("bbbbbbbbbbbbb"); 
							times = times + 1;
							flag2 = 3;         
							SeaCourse(search_val);				    
						});  
						
					}
				}
				
				$('.infor').unbind('click').click(function(){     
					var infor_taskno = $(this).attr("id");
					var course_no = $(this).attr('course_no');
					InforLogicClass(infor_taskno,course_no);
				});
				$('.upd').unbind('click').click(function(){
					var upd_taskno = $(this).attr("id");
					UpdCourse(upd_taskno);
				});
				$('.del').unbind('click').click(function(){
					var del_taskno = $(this).attr("id");
					DelCourse(del_taskno);      
				});  	
	    	}
	    	
	    	//获取部门对应课程数据
	    	function loadDepData(depno){
	    		console.log("ttt"+termid);  
	    	 	if(flag2 != 1) {
		    		$("#coursetable").empty();
	    		} 
	    		$.ajax({
					url:"do?invoke=baseCourseWH@getCourseData",
					type:'POST',   
					dataType:'json',
					data:{
						depno:depno,
						termno:termid,
						pagenum:pagenum,
						times:times
					},
					success:function(rep) {
						console.log("获取到数据：",rep);
						if(rep.result == 0){
							$.alert("没有加载到课程数据，您可以换一个学期试试！");
							return;
						} else {
							var courseInfor = rep.data;
							if(flag2 == 1) {
								$("#Clickmore").remove();       
							}
							DrawTableData(courseInfor,depno);
						}		
						
					}
	    		});
	    	}
	    	
   	
	    	//查看逻辑班级信息
	    	function InforLogicClass(taskno,course_no) {
	    		$("#modLogicStu").modal({
    				transition:'slide down',
    				observeChanges:true,
    				closable:false
    			}).modal('show');
	    		lgtimes = 0;
				flag3 = 0; 
	    		$("#buticon").popup();  
		    	$("#addlgstuHide").popup();      
		    	$("#addlgstuHide").css({'cursor':'pointer'});           
		    	
	    		$("#stusearch").val("");   
	    		$("#lgshowstu").hide();         
	    		$("#modLogicStuInfor").empty();         
	    		$("#lginformessage").empty();            
	    		var temp =
	    			'<p><label class="bq" id="bq1">课程名称：</label><label class="bq" id="bq2">班级人数：</label></p>'+
		  			'<p><label class="bq" id="bq3">学年学期：</label></p>'+
		  			'<button class="ui basic mini button" style="position:absolute;left:79%;top:80px;" id="lgimport_dr" data-content="点击导入" data-variation="small"><i class="sign in icon"></i> 导 入 </button>'+
					'<button class="ui basic mini button" style="position:absolute;left:89%;top:80px;" id="lgexport_dc" data-content="点击导出" data-variation="small"><i class="upload icon"></i> 导 出 </button>';
		  		$("#lginformessage").append($(temp));   
	    		$.ajax({   
					url:"do?invoke=baseCourseWH@getLogicClassData",
					type:'POST',   
					dataType:'json',
					data:{
						taskno:taskno,
						termno:termid,
						lgtimes:lgtimes,
						lgpagenum:lgpagenum
					}, 
					success:function(rep) {   
						console.log(rep);
						if(rep.result == 0){
							$.alert("没有加载到任选课班级数据，您可以换一个学期试试！");
							return;
						} else {
							lgclass = rep.lgdata.data;
							bjrs = rep.lgtotal.data[0].total;                        
							$("#bq1").text("课程名称：" + lgclass[0].course_name);
							$("#bq2").text("班级人数：    " + bjrs);   
							$("#bq3").text("学年学期：    " + lgclass[0].term_name);
							ShowlgClassStu(taskno);   							
						}         
					}    
	    		}); 
	    		
	    		//逻辑班级数据导出功能
		    	$("#lgexport_dc").unbind('click').click(function(){
					var params = [];
					params.push(taskno);
					params.push(termid);
					var type = "excel";
					open(BASE_PATH+"/qm/base/export.jsp?export_id=6&params="+params+"&type="+type+"&more=1");
		    	});
	    		
		    	//逻辑班级数据导入功能
		    	$("#lgimport_dr").unbind('click').click(function(){
	    		    $("#ImportMod").modal({
	    				transition:'slide down',
	    				observeChanges:true,
	    				closable:false                      
	    			}).modal('show'); 
	    		    $("#excelImportSaveModal.kc").removeClass("kc");
		    		$("#excelImportSaveModal").addClass("lg");
		    		
	    		    $('.selectButton').attr("href","template/lgstudent.xls");
	    			initFilePath();
	    			
	    			
			    	$("#excelImportSaveModal.lg").unbind('click').click(function() {  
			    		$.ajax({
							url:"do?invoke=baseCourseWH@importExcelBaseLgCourse",
							type:'POST',
							dataType:'json',
							data:{
								task_no:taskno,
								course_no:course_no,
								term_no:termid,
								course_file_path:courseFilePath,
							},
							success:function(rep) {
								$.alert(rep.message);
							}
						});
					    $("#ImportMod").modal({
		    				transition:'slide down',
		    				observeChanges:true,
		    				closable:false                
		    			 }).modal('hide'); 
					});
		    	});
	    	}

	    	//逻辑班级学生表格绘制 (动态重新新)
	    	function SeaShowlgClassStu(taskno) {    
	    		$.ajax({
					url:"do?invoke=baseCourseWH@getLogicClassData",
					type:'POST',   
					dataType:'json',
					data:{
						taskno:taskno,
						termno:termid,
						lgtimes:lgtimes,
						lgpagenum:lgpagenum
					},
					success:function(rep) {
						console.log(rep);
						if(rep.result == 0){
							$.alert("没有加载到任选课班级数据，您可以换一个学期试试！");
							return;
						} else {
							lgclass = rep.lgdata.data;
							bjrs = rep.lgtotal.data[0].total;
						/* 	lgclass = rep.data;
							bjrs = lgclass.length; */    
							if(flag3 == 1) {
								$("#lgClickmore").remove();       
							}
							ShowlgClassStu(taskno);
						}
					}
				});        
	    	}
	    	
	    	//逻辑班级学生表格绘制 (静态刷)
	    	function ShowlgClassStu(taskno) {    	    		
	    		for(var j=0 ; j<lgclass.length; j++) {
					var dom =
						'<tr>'+         
							'<td>'+ lgclass[j].student_no +'</td>'+  
							'<td>'+ lgclass[j].stu_name +'</td>';
							if(lgclass[j].stu_status == "0") {
								dom += '<td style="color: red;">异常</td>';          
							} else {
								dom += '<td style="color: blue;">正常</td>';   
							}   
							dom += 
								'<td>'+        
					                '<div class="lgCdel mini circular ui red basic icon button" id="'+ lgclass[j].student_no +'">'+
				                        '<i class="remove red icon"></i>'+
					                '</div>'+
								'</td>'+         
							 '</tr>';        
   						$("#modLogicStuInfor").append($(dom));            
				} 
	    		var lgstulength = lgclass.length;    
				if(lgstulength >= lgpagenum) {       
					$("#modLogicStuInfor").append($('<tr id="lgClickmore"><td colspan="4"><label class="bq" id="lgButtMore"><i class="spinner icon"></i> 显示更多 </label></td></tr>'));                   
					$("#lgClickmore").unbind('click').click(function(){
						lgtimes = lgtimes + 1;
						flag3 = 1;      
						SeaShowlgClassStu(taskno);				     	    
					});   
				}
	    		
	    		//点击搜索按钮
				$("#buticon").unbind('click').click(function(){    
					var searchval = $("#stusearch").val();
					StuSearch(searchval,taskno);
		    	});  
				//点击删除按钮
				$('.lgCdel').unbind('click').click(function(){    
					var stuno = $(this).attr("id");
					DellgClassStu(stuno,taskno);							
				});    
				//点击添加学生按钮
				$("#lgaddstu").unbind('click').click(function(){
					SearchlgClassStu(taskno);    
				});
				        
				//点击添加确定按钮
				$("#lgstuadd").unbind('click').click(function(){
					AddlgClassStu(taskno);       					
				});
	    	}
	    	
	    	//向逻辑班级添加学生信息
	    	function AddlgClassStu(taskno) {
	    		$.ajax({
					url:"do?invoke=baseCourseWH@AddlgClassStuData",
					type:'POST',   
					dataType:'json',
					data:{
						termno:termid,
						stuno:stuid,
						taskno:lgclass[0].task_no,
						logicno:lgclass[0].logic_no,
						logicname:lgclass[0].logic_name,
						courseno:lgclass[0].course_no
					},
					success:function(rep) {
						console.log(rep);
						if(rep.result == 0){
							$.alert("很抱歉，为该班级新添学生失败！");
							return;
						} else {  
							if(rep.message == "") {
								$.alert("该学生已经存在，不可以重复添加！");
							} else {
								SeaShowlgClassStu(taskno);  
								ShowlgClassStu(taskno);
								$("#addstuSearch").val("");       
								bjrs = bjrs+1;          
								$("#bq2").text("班级人数：    " + bjrs); 
							}
						}
					}
	    		});
	    	}
	    	
	    	//获取所有可搜索的学生信息
	    	function SearchlgClassStu(taskno) {
	    		$("#lgClassStuAddmessage").show();   
	    		$.ajax({
					url:"do?invoke=baseCourseWH@SearchlgClassStuData",
					type:'POST',   
					dataType:'json',
					data:{
						taskno:taskno,
						termno:termid
					},
					success:function(rep) {
						console.log(rep);
						if(rep.result == 0){
							$.alert("很抱歉，学生数据获取失败！");
							return;
						} else {   
							var stuData = rep.data;
							var allstu=[];    
							for(var i=0; i<stuData.length; i++) {
								allstu[i]  = {
													title:stuData[i].stu_name,
													description:stuData[i].stu_no,
													price:stuData[i].class_name,     
													"id":stuData[i].stu_no
												};
							}    
							$("#lgstuaddSearch").search({    
								 source: allstu,
								 maxResults:10,   
								 onSelect:function(itemstu) { 
									 stuid = itemstu.id;
								 }
							});
						}
					}         
	    		});		   
	    		$("#addlgstuHide").unbind('click').click(function(){
	    			$("#lgClassStuAddmessage").hide();          
	    		});
	    	}
	    	     
	    	//逻辑班级学生表格删除数据
	    	function DellgClassStu(stuno,taskno) {
	    		$.confirm({
					msg          :"您确定要删除逻辑班级的此学生么？",       
					btnSure     :'确定',
					btnCancel  :'取消',   
					sureDo       : function(){
								    		$.ajax({
												url:"do?invoke=baseCourseWH@delLogicClassData",
												type:'POST',   
												dataType:'json',
												data:{
													taskno:taskno,
													stuno:stuno,
													termno:termid
												},
												success:function(rep) {
													console.log(rep);
													if(rep.result == 0){
														$.alert("删除失败，您可以再试一次！");
														return;
													} else {
														$('#'+stuno+'').parents('tr').remove();   
														bjrs = bjrs-1;       
														$("#bq2").text("班级人数：    " + bjrs);   
													}  
												}
								    		});
					},
					cancelDo:function(){
						                      
					}       
	    		});
	    	}
	    	
	    	//查询逻辑班级学生，绘制表格
	     	function StuSearch(searchval,taskno) {
				$("#modLogicStuInfor").empty();  
				$("#stusearch").val("");      
				$("#lgshowstu").show();				        
				for(var k=0 ; k<lgclass.length; k++) {
					if(searchval == lgclass[k].student_no || searchval == lgclass[k].stu_name) {
						var y = k;
						var dom =
							'<tr>'+
								'<td>'+ lgclass[y].student_no +'</td>'+  
								'<td>'+ lgclass[y].stu_name +'</td>';
								if(lgclass[y].stu_status == "0") {  
									dom += '<td style="color: red;">异常</td>';
								} else {
									dom += '<td style="color: blue;">正常</td>';   
								}   
								dom += 
									'<td>'+        
						                '<div class="lgCdelSearch mini circular ui red basic icon button" id="'+ lgclass[y].student_no +'">'+
					                        '<i class="remove red icon"></i>'+
						                '</div>'+
									'</td>'+         
								 '</tr>';  
						  $("#modLogicStuInfor").append($(dom));     						    
						     
						  //点击搜索结果的删除按钮    
						  $('.lgCdelSearch').unbind('click').click(function(){
							  var stuno = $(this).attr("id");
							  flag = 1;
							  DellgClassStu(stuno,taskno);               
						  });						    
					}    
				}
				//点击返回全部学生数据表格
				  $("#lgshowstu").unbind('click').click(function(){      
					  $("#modLogicStuInfor").empty();
					  $("#lgshowstu").hide(); 
					  $("#stusearch").val("");
					  if(flag == 0) {
						  ShowlgClassStu(taskno);         						  
					  } else {
						  SeaShowlgClassStu(taskno); 
						  ShowlgClassStu(taskno);
					  }
				  });
	    	}
	    	 
	    	
	    	//修改课程信息
	    	function UpdCourse(taskno) {
	    		$("#modCourseInfor").modal({   
    				transition:'slide down',
    				observeChanges:true,
    				closable:false
    			}).modal('show');
	    		$("#TaskScheInforPane").hide();                       
	  			$("#TaskInforPane").empty();               
				$("#addsche").popup();       
	  				$.ajax({
						url:"do?invoke=baseCourseWH@getCourseTaskInfroData",
						type:'POST',   
						dataType:'json',
						data:{   
							taskno:taskno,
							termno:termid
						},
						success:function(rep) {
							console.log(rep);   
							if(rep.result == 0){
								$.alert("很抱歉，该课程相关信息获取失败！"); 
								return;
							} else {
								var courseData = rep.data;
								$("#bq4").text("授课教师：   "+courseData[0].teacher_name);         
								$("#teach_teano").val(courseData[0].teacher_no);
						    	$("#coursename").val(courseData[0].course_name);   
						    	$("#course_weeks").val(courseData[0].course_week);
								var thiscourse_type=courseData[0].course_type;
								$('#course_type').dropdown('set selected',thiscourse_type);
								if((courseData[0].class_no != null || courseData[0].class_no != "") && courseData[0].course_type == "任选课") {
									$("#bq5").text("授课班级：   逻辑班级");          
								} else {    
									$("#bq5").text("授课班级：   "+courseData[0].class_name); 
								}   
								$("#teach_class").val(courseData[0].class_no);   
								
								teaid = $("#teach_teano").val();
								classid = $("#teach_class").val();  
								TeasClassesSearch();      
								var scheval ={};  
								var scheset = "";
								var zc = "";
								var jc = "";    
								var taskkc = "";
								var taskzc = ""; 
								var taskjc = "";  
								var addid = 0;
								for(var i=0; i<courseData.length; i++) {
									if(courseData[i].sche_no != null || courseData[i].sche_no != "") {
										scheset = courseData[i].sche_set;  																													
									}    
									taskkc = "";         
									zc = "";
									taskzc = "";  
									jc = "";
									taskjc = "";
  
									taskkc = courseData[i].course_type;      
									zc = scheset.substring(1,2);    
									jc = scheset.substring(2,3);  
									taskzc = WEEK[zc];
									taskjc = COURSE_JC_SINGLE[jc];
									var dom =    
										'<div class="ui middle aligned selection list">';
											if(taskkc == "实训课") {     
												dom +=
													'<div class="coursetask item" id="'+courseData[i].sche_no+'">'+              
														'<div class="bq">' + taskkc + ' &nbsp;&nbsp;——&nbsp;&nbsp;'+ 
															'<div class="ui mini transparent input">'+ 
															  '<input type="text" readonly="readonly" placeholder="" id=addrval"'+courseData[i].sche_no+'" value="实训周">'+     
															'</div>'+  
															'<i class="scheDel remove red large circle icon" id="'+ courseData[i].sche_no +'" data-content="删除" data-variation="small"></i>'+
														'</div>'+             
													'</div>';                
											} else if(taskkc == "任选课" && (courseData[i].sche_no == null || courseData[i].sche_no == "")) {
												dom +=            
													'<div class="coursetask item">'+             
														'<div class="bq">' + taskkc + ' &nbsp;&nbsp;——&nbsp;&nbsp; 没有获取到该课程的相关节次数据，您也可以新添节次信息！   '+
														'</div>'+             
													'</div>';
											} else if(taskkc == "讲授课" && (courseData[i].sche_no == null || courseData[i].sche_no == "")) {
												dom +=            
													'<div class="coursetask item">'+             
														'<div class="bq">' + taskkc + ' &nbsp;&nbsp;——&nbsp;&nbsp; 没有获取到该课程的相关节次数据，您也可以新添节次信息！   '+
														'</div>'+             
													'</div>';
											} else {    
												dom +=
												'<div class="coursetask item" id="'+courseData[i].sche_no+'">'+             
													'<div class="bq" id="'+courseData[i].sche_set+'">' + taskkc + ' &nbsp;&nbsp;——&nbsp;&nbsp; 【 '+   taskzc   +'&nbsp;&nbsp;:   '+   taskjc   +' 】&nbsp;&nbsp;&nbsp;&nbsp;'+
													    '<div class="ui mini transparent input">'+
														  '<input type="text" readonly="readonly"  id="addrval'+courseData[i].sche_no+'" value="'+ courseData[i].sche_addr +'">'+     
														'</div>'+
														'<i class="scheDel remove red large circle icon" id="'+ courseData[i].sche_no +'" data-content="删除" data-variation="small"></i>'+
													'</div>'+                 
												'</div>';                                
											}       
											dom +=
										'</div>';            
									$("#TaskInforPane").append($(dom));        
								}        
								$('.scheDel').css({'cursor':'pointer'});     
								$('.scheDel').popup();    

								//显示课程节次信息
								function ClickCheckmarkIcon() {
									$('#tableset').find(".checkmark").unbind('click').click(function(){										                 										
										var schesetid = $(this).parents('td').attr("id");            
										zc = schesetid.substring(1,2);    
										jc = schesetid.substring(2,3);
										taskzc = WEEK[zc];
										taskjc = COURSE_JC_SINGLE[jc];
										var temp =
											'<div class="ui middle aligned selection list">'+
												'<div class="coursetask item" id="add'+addid+'">'+ 
													'<div class="bq"  id="">' + taskkc + ' &nbsp;&nbsp;——&nbsp;&nbsp; 【 '+   taskzc   +'&nbsp;&nbsp;:   '+   taskjc   +' 】&nbsp;&nbsp;&nbsp;&nbsp;'+
														'<div class="ui mini input">'+
														  '<input type="text" placeholder="" id="addrvaladd'+addid+'" value="">'+     
														'</div>'+  
														'<i class="clickadd_scheDel remove red large circle icon" id="add'+addid+'" data-content="删除" data-variation="small"></i>'+
													'</div>'+
												'</div>'+        
											'</div>';
										$("#TaskInforPane").append($(temp)); 
										$("#TaskScheInforPane").hide();        
										var add_delno = "add"+addid;    
										var scheaddrval = $("#addrval"+add_delno).val();         
										scheval[add_delno] = schesetid+"-o-"+scheaddrval;       
										addDel(add_delno);        
										addid = addid+1;
									});	
								}
								
								$("#addsche").unbind('click').click(function() {
									$("#TaskScheInforPane").show();    
									$('#modCourseInfor').modal('refresh');
									ClickCheckmarkIcon();
								});              
								    
								$('.scheDel').unbind('click').click(function(){
									var scheno = $(this).attr("id");    
									TaskScheDel(taskno,scheno);
								});        
								
								$("#updSubmit").unbind('click').click(function(){
									var task_teano = teaid;
									var task_classno = classid;         
									var task_coursename = $("#coursename").val();
									var task_coursetype = $("#course_type option:selected").val();
									var task_courseweek = $("#course_weeks").val();
									$.each(scheval,function(id,value) {
										 scheval[id] = scheval[id].split('-o-')[0]+"-o-"+$("#addrval"+id).val();	      
										 if(typeof($("#addrval"+id).val()) == "undefined") {
											 delete scheval.id;       
											 console.log("TTTTTTTTTTTTTT");     
											 console.log($("#addrval"+id).val());    
											 console.log(scheval);   
										 }
										 console.log(scheval[id]);               
								    });     
 									$.ajax({
										url:"do?invoke=baseCourseWH@UpdCourseInfroData",
										type:'POST',   
										dataType:'json',
										data:{
											taskno:taskno,
											termno:termid,
											teano:task_teano,
											classno:task_classno,
											coursename:task_coursename,
											coursetype:task_coursetype,   
											courseweek:task_courseweek,
											courseInfo:JSON.stringify(scheval)
										},
										success:function(rep) {    
											console.log(rep);         
											if(rep.result == 0){
												$.alert("很抱歉，该课程修改失败！"); 
												return;
											} else {
												$.alert(rep.message);    
											}
										}
									});
								});   
							}
						}     
	  				});
	    	}   
	    	

	    	function addDel(id) {
		    	$('.clickadd_scheDel').click(function(){                                                         
		    		var delno = $(this).attr("id");                          
					$("#"+delno+'.coursetask.item').remove();       
				});    
	    	} 

	    	//获取所有可搜索的教师数据
	    	function TeasClassesSearch(itemid) {
	    		$.ajax({
					url:"do?invoke=baseCourseWH@getTeasClassesAllData",
					type:'POST',   
					dataType:'json',
					success:function(rep) {
						console.log(rep);
						if(rep.result == 0){
							$.alert("很抱歉，没有获取到教师或班级的所有数据！");
							return;
						} else {
							var Teas_Classes = rep.data[0];
							var allTeas = [];
							var allClasses = [];
							for(var i=0; i<Teas_Classes.teas.length; i++) {
								allTeas[i] = 
										{
											title:Teas_Classes.teas[i].teacher_no,
											description:Teas_Classes.teas[i].teacher_name,
											"id":Teas_Classes.teas[i].teacher_no
										};    
							}
							$("#teaSearch").search({
								source:allTeas,
								maxResults:5,
								onSelect:function(itemtea,rep) {
									teaid = itemtea.id;
									teaname = itemtea.description;
						   			$("#bq4").text("授课教师：   "+teaname);
					   			
								}     
							});
							
							$("#TeachTeaSearch").search({
								source:allTeas,
								maxResults:5,
								onSelect:function(itemtea,rpe) {
						   			addteaid = itemtea.id;			
						   			$("#bq16").text("授课教师：   "+ itemtea.description);             
								}     
							});
							for(var j=0; j<Teas_Classes.classes.length; j++) {
								allClasses[j] = 
									{
										title:Teas_Classes.classes[j].class_no,
										description:Teas_Classes.classes[j].class_name,
										"id":Teas_Classes.classes[j].class_no,
									};
							}   
							$("#ClassSearch").search({
								source:allClasses,
								maxResults:5,        
								onSelect:function(itemclass,rep) {
									classid = itemclass.id;
									classname = itemclass.description;
									$("#bq5").text("授课班级：   "+classname);    
									
								}
							}); 
							
							$("#ClassesSearch").search({       
								source:allClasses,
								maxResults:4,        
								onSelect:function(itemclass,rep) {        
						//			addclassid = itemclass.id;   
									DrawClassesItem(itemclass,itemid);
									itemid = itemid +1;    
								}
							}); 
						}
					}
	    		});
	    	}
	    	
	    	//删除课程的某一条节次信息
	    	function TaskScheDel(taskno,scheno) {
	    		$.confirm({
					msg          :"您确定要删除该课程的此条节次数据么？",       
					btnSure     :'确定',
					btnCancel  :'取消',   
					sureDo       : function(){
								    		$.ajax({
												url:"do?invoke=baseCourseWH@delCourseTaskSche",
												type:'POST',   
												dataType:'json',
												data:{
													taskno:taskno,
													scheno:scheno
												},
												success:function(rep) {
													console.log(rep);
													if(rep.result == 0){
														$.alert("删除失败，您可以再试一次！");
														return;
													} else {
														$("#"+scheno+'.coursetask.item').remove();     
														$('.checkmark.icon').removeClass("teal");
														$('.checkmark.icon').removeClass("large");   
													}
												}
											});
					},
					cancelDo:function(){
						
					}       
	    		});
	    	}
	    	
	    	//删除课程信息
	    	function DelCourse(taskno) {      
	    		$.confirm({
					msg          :"您确定要删除该条课程数据么？",       
					btnSure     :'确定',
					btnCancel  :'取消',
					sureDo       : function(){
							    		$.ajax({
											url:"do?invoke=baseCourseWH@delClassData",
											type:'POST',   
											dataType:'json',
											data:{
												taskno:taskno,
												termno:termid
											},
											success:function(rep) {
												console.log(rep);
												if(rep.result == 0){
													$.alert("",rep.message);
													return;
												} else {
													$.alert("",rep.message);    
													$('#'+taskno+'').parents('tr').remove();       
												}
											}
							    		}); 
					},
					cancelDo:function(){
						
					}
	    		});
	    	}
	    	
	 //   	downAllTerm();  
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
						termid=temp[temp.length-1].term_no;             
						$("#coursetable").empty();     
						loadDepData(dqdepno);          
						
						$("#dropdown").change(function(){  
							termid=$("#dropdown").val();       
							console.log(termid);
							times = 0;  
							$("#coursetable").empty(); 
							loadDepData(dqdepno);
						});
					}  
		    	});       
		    }
		     
		     
		    //文件上传
			function initFilePath() {
		         console.log("aaaa");
				var test=$("#courseuploadify").uploadify(
						{
							'auto' : true,

							'buttonText' : '<i class="file excel outline icon"></i>&nbsp;&nbsp;选择文件',
							//接受一个文件路径。此文件检查正要上传的文件名是否已经存在目标目录中。存在时返回1，不存在时返回0(应该主要是作为后台的判断吧)，默认为false
							//checkExisting: '/uploadify/check-exists.php',
							//开启或关闭debug模式
							'debug': false,
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
							'fileDesc' : '表格文件(*.xls;*.xlsx;)',
							//设置允许上传的文件扩展名（也就是文件类型）。但手动键入文件名可以绕过这种级别的安全检查，所以你应该始终在服务端中检查文件类型。输入多个扩展名时用分号隔开('*.jpg;*.png;*.gif')
							'fileTypeExts' : '*.xls;*.xlsx',

							onCancel : function(file) {
								//文件被移除出队列时触发,返回file参数
								console.log('将文件  ' + file.name + ' 移除出队列中.');
							},

							onClearQueue : function(queueItemCount) {
								//当调用cancel方法且传入'*'这个参数的时候触发，其实就是移除掉整个队列里的文件时触发，上面有说cancel方法带*时取消整个上传队列
								console.log(queueItemCount + 'file(s) were removed frome the queue');
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
										+ queueData.filesErrored);
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
								console.log('The queue ID is ' + instance.settings.queueID);
							},

							onQueueComplete : function(queueData) {
								//队列中的文件都上传完后触发，返回queueDate参数，有以下属性：
								/*
								    uploadsSuccessful 成功上传的文件数量
								    uploadsErrored 出现错误的文件数量
								 */
								console.log(queueData.uploadsSuccessful + '\n'
										+ queueData.uploadsErrored);
							},

							onSelect : function(file) {
								//选择每个文件增加进队列时触发，返回file参数
								console.log('增加文件\r' + file.name + '\r到上传队列中');
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
										'总共需要上传' + bytesTotal + '字节，' + '已上传' + totalBytesTotal + '字节');
							},

							onUploadStart : function(file) {
							    $('#excelImportSaveModal').addClass('loading');
							    $('#excelImportSaveModal').attr({"disabled":"disabled"});
								//每个文件即将上传前触发
								console.log('start update');
							},

							onUploadSuccess : function(file, data, respone) {
								$('#excelImportSaveModal').removeAttr("disabled");
								$('#excelImportSaveModal').removeClass('loading');
								courseFilePath = "" + data;
							}

						});

			}
		    
		  
    });
</script>           
		
<!--这里引用其他JS-->
</html>