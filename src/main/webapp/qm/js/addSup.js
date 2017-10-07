/**
 * 
 */
function addSup(){ 
	//弹出框   
	var teacher_name="";
	var teacher_no=""; 
	var dep_name="";    
	var type_role="院系督学";  
	var id=""; 
	this.showModal=function(dep_no){   
	
		$("#modal").remove();     
		var modal='<div class="ui small modal long" id="modal">'+ 
				  '<i class="close icon"></i>'+ 
				  '<div class="header">'+ 
				  '<i class="write icon"></i>'+ 
				    '添加督学'+  
				  '</div>'+ 
				  '<div class="content grand">'+      
				    
				  '<div class="ui horizontal segments">'+
				  '<div class="ui segment">'+

				  '<div class="ui fluid selection dropdown">'+  
					'<i class="dropdown icon"></i> <span class="default text">院系督学</span>'+
					'<div class="menu infro">'+      
					'<div class="item dep">院系督学</div>'+    
					'<div class="item dep">校级督学</div>'+     
					'</div>'+     
				'</div>'+ 
				  '</div>'+
				  '<div class="ui segment">'+
					'<div class="ui  search" >'+              
					  '<div class="ui icon input">'+      
					    '<input class="prompt" type="text" placeholder="教师姓名、工号、所属部门..." >' + 
					   '<i class="search icon"></i>'+    
					  '</div>'+ 
					 '<div class="results" style="height:300px;overflow-y:scroll;"></div>'+ 
					  
					'</div>'+   
				  '</div>'+   
				 '</div>'+ 
				  
				'</div>'+ 
				 
		
				  '<div class="actions">'+ 
				  '<div class="ui red deny button" id="back">'+
			      	'返 回'+ 
			      	'</div>'+
				    '<div class="ui green button" id="submitbtn">'+  
				      '提 交'+  
				   '</div>'+  
				  '</div>'+
				'</div>';
			
		$("#container").append($(modal)); 
		 $('.ui.dropdown').dropdown();    
		
		loadteacher(dep_no); 		
		
	} 
	function loadteacher(dep_no){    
		$.ajax({ 
			url:"do?invoke=addSup@getAddTeacher",
			type:'POST',
			dataType:'json',
			async: false,
			data:{
				dep_no:dep_no
			},
			success:function(rep){ 
				if(rep.result==0){ 
					$.alert("没有可添加教师");
				}else{ 
					 
					var content=[]; 
					var teacherInf=rep.data;
					 for(var i=0 ; i<teacherInf.length ; i++){
						 content[i]={title:teacherInf[i].teacher_name,price:teacherInf[i].teacher_no,description:teacherInf[i].dep_name,"id":teacherInf[i].user_id};
					 }
					 $('#modal') //弹出层初始化  
					  .modal('show'); 
					 $('.item.dep').unbind('click').click(function(){ 
						 type_role=$(this).text();  
						  
					 })  
					 $('.ui.search').search(
								{source: content,   
									maxResults:10000,   
									searchFields   : [
									                  'title', 
									                  'price', 
									                  'description'
									                ],
									 onSelect:function(content,response){  
										 	
									    	teacher_name=content.title;
									    	teacher_no=content.price;
									    	dep_name=content.description;  
									    	id=content.id;
									    } 
									}
								);//初始化搜索 
					
					
					$('#submitbtn').unbind('click').click(function(){
						  
						if($(this).hasClass("loading")){  
							return;  
						} 
						$(this).addClass("loading");   
						if(teacher_no==""){  
							$(this).removeClass("loading"); 
							$.alert({
								msg  : "请先选择教师", 
								type : 'info',  
								btnText : '我知道啦',   
								callback: function(){     
								}
							});  
						}else{ 
						 
							postSup();  
						} 
						
					})
				}
			} 
		});
	} 
	function postSup( ){
		$.ajax({ 
			url:"do?invoke=addSup@postSup",
			type:'POST', 
			dataType:'json', 
			async: false,
			data:{ 
				type:type_role,
				teacher_no:teacher_no,  
				teacher_name:teacher_name,   
				id:id, 
				
			}, 
			success:function(rep){ 
				 if(rep.result==0){ 
					 $.alert({
							msg  : "添加失败", 
							type : 'info',
							btnText : '我知道啦',  
							callback: function(){ 
								$('#submitbtn').removeClass("loading");     
							}
						}); 
				 }else{
					 $.alert({
							msg  : "添加成功",
							type : 'info',
							btnText : '我知道啦', 
							callback: function(){       
								$("#back").click();   
								$('#submitbtn').removeClass("loading");    
								location.href=BASE_PATH+'/qm/teacher/sup_manage.jsp?module=10&menu=70'; 
							}
						});  
				 }
				
	
			}
		});
	}
}