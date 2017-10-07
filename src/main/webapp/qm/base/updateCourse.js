/**
 * 修改课程
 */
(function($,window){
	$.courseTool={
			allTeas: [],
			allClasses:[],
			teacher:{},
			classinfo:{},
			TeasClassesSearch:function(callback){
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
							
							for(var i=0; i<Teas_Classes.teas.length; i++) {
								$.courseTool.allTeas[i] = 
										{
											title:Teas_Classes.teas[i].teacher_no,
											description:Teas_Classes.teas[i].teacher_name,
											"id":Teas_Classes.teas[i].teacher_no
										};    
							}
							$("#teaSearch").search({
								source:$.courseTool.allTeas,
								maxResults:5,
								onSelect:function(itemtea) {
									$.courseTool.teacher.teaid = itemtea.id;
									$.courseTool.teacher.teaname = itemtea.description;
						   			$("#bq4").text("授课教师：   "+$.courseTool.teacher.teaname);
								}     
							});
							for(var j=0; j<Teas_Classes.classes.length; j++) {
								$.courseTool.allClasses[j] = 
									{
										title:Teas_Classes.classes[j].class_no,
										description:Teas_Classes.classes[j].class_name,
										"id":Teas_Classes.classes[j].class_no
									};
							}   
							$("#ClassSearch").search({
								source:$.courseTool.allClasses,
								maxResults:5,        
								onSelect:function(itemclass) {
									$.courseTool.classinfo.classid = itemclass.id;
									$.courseTool.classinfo.classname = itemclass.description;
									$("#bq5").text("授课班级：   "+$.courseTool.classinfo.classname);           
								}
							});
							if(callback){
								callback();
							}
						}
					}
				});
			},
			updateCourse:function(taskno,termno){
				var _this=this;
				var courseData=[];
				//界面初始化
				function init(){
					getCourse(function(){
						renderInfo();
						renderSche();
					});
					
					$("#modCourseInfor").modal({   
						transition:'slide down',
						observeChanges:true,
						closable:false
					}).modal('show');
						$("#TaskInforPane").empty();               
						$('.checkmark.icon').removeClass("teal");
					$('.checkmark.icon').removeClass("large");
					
					function getCourse(callback){
						$.ajax({
							url:"do?invoke=baseCourseWH@getCourseTaskInfroData",
							type:'POST',   
							dataType:'json',
							data:{   
								taskno:taskno,
								termno:termno
							},
							success:function(rep){
								if(rep.result == 0){
									$.alert("很抱歉，该课程相关信息获取失败！"); 
									return;
								} else {
									courseData = rep.data;
									if(callback){
										callback(rep.data);
									}
								}
							}
						});
					}
					$("#addsche").unbind("click").click(function(){
						chooseSche();
					});
				}
				
				function chooseSche(){
					$("#TaskScheInforPane").show();
					
				}
				
				function renderInfo(){
					$("#courseterm").text("学年学期：   "+courseData[0].term_name);   
					$("#bq4").text("授课教师：   "+courseData[0].teacher_name);         
					$("#teach_teano").val(courseData[0].teacher_no);
			    	$("#coursename").val(courseData[0].course_name);                
					if((courseData[0].class_no != null || courseData[0].class_no != "") && courseData[0].course_type == "任选课") {
						$("#bq5").text("授课班级：   逻辑班级");         
					} else {    
						$("#bq5").text("授课班级：   "+courseData[0].class_name); 
					}   
					$("#teach_class").val(courseData[0].class_no);   
				}
				
				function renderSche(){
					var scheval ={};  
					var scheset = "";
					var scheaddr = "";
					var zc = "";
					var jc = "";    
					var taskkc = "";
					var taskzc = ""; 
					var taskjc = "";
					var scheid = "";
					scheArray = [];     
					for(var i=0; i<courseData.length; i++) {
						if(courseData[i].sche_no != null || courseData[i].sche_no != "") {
							scheid = courseData[i].sche_no;    
							scheset = courseData[i].sche_set;  
							scheaddr = courseData[i].sche_addr;
							scheval[scheid] = scheset+"-o-"+scheaddr;   
							scheArray.push(scheval);         																														
						}    
						taskkc = "";         
						zc = "";
						taskzc = "";  
						jc = "";
						taskjc = "";
						if(courseData[i].course_type == "实训课" && (courseData[i].sche_set == "K99" || courseData[i].sche_set == "k99")) {
							taskkc = "实训周";
						} else {
							if(courseData[i].course_type == "任选课" && (courseData[i].class_name == null || courseData[i].class_name == "")) {
								taskkc = "任选课"; 
							} else {
								taskkc = "讲授课";    
							}
							zc = scheset.substring(1,2);    
							jc = scheset.substring(2,3);       
							taskzc=WEEK[zc];
							taskjc=COURSE_JC[jc];
						}
						var dom =    
							'<div class="ui middle aligned selection list">';
								if(taskkc == "实训周") {    
									dom +=
										'<div class="coursetask item" id="'+courseData[i].sche_no+'">'+             
											'<div class="bq">' + taskkc + ' &nbsp;&nbsp;——&nbsp;&nbsp;  【 '+   courseData[i].sche_set   +' 】&nbsp;&nbsp;&nbsp;&nbsp;'+
												'<div class="ui mini input">'+
												  '<input type="text" placeholder="" id=addrval"'+courseData[i].sche_no+'" value="'+ courseData[i].sche_addr +'">'+     
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
											'<div class="ui mini input">'+
											  '<input type="text" placeholder="" id="addrval'+courseData[i].sche_no+'" value="'+ courseData[i].sche_addr +'">'+     
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
				}
				
				//获取search数据
				if($.courseTool.allTeas.length==0 || $.courseTool.allClasses.length==0){
					$.courseTool.TeasClassesSearch(function(){
						init();
					});
				}else{
					init();
				}
			}
		
	}
})($,window);
