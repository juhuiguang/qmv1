/**
 * 
 */
function loadListen(){ 
	//弹出框   
	this.showModal=function(id, term_no){   
	
		
		$("#modal").remove();     
		var modal='<div class="ui small  modal long" id="modal">'+ 
				  '<i class="close icon"></i>'+ 
				  '<div class="header">'+
				  '<i class="write icon"></i>'+ 
				    '修改听课记录'+ 
				  '</div>'+
				  '<div class="content grand">'+   
 
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

		loadtable(id ,term_no); 		
		
	} 
	function loadtable(id ,term_no){   
		$.ajax({
			url:"do?invoke=marsterLiten@getTeaListenTable",
			type:'POST',
			dataType:'json', 
			async: false,
			data:{ 
				id:id,
				term_no:term_no
			},
			success:function(rep){
				if(rep.result==0){
					$.alert("没有读取到听课指标和分数");
				}else{ 
					
					var table=rep.data; 
					for(var i=0;i<table.length;i++){
						var maxgrade=table[i].rule_goal;
						var div=parseInt(maxgrade)/5;
						var dom='<div class="repeat item ruleitem" rownumber="'+i+'" fieldname="'+table[i].rule_field+'"> '+
											'<div class="ui raised content"> '+
										 		'<div class="header">'+
										 		'<i class="grid layout icon"></i>'+
										 		(i+1)+'、'+table[i].rule_title+
										 		'<input class="gradebar middle aligned" type="range" name="item'+i+'" step=1 value='+parseInt(table[i].grand)+' min="0" max="'+parseInt(table[i].rule_goal)+'" style="margin-left:20px;" />'+
										 		 
										 		'<div class="ui left icon input" style="width:20%;margin-left:5%">'+  
										 		  '<input id="grand'+i+'" class="grand input" type="text" placeholder="手动输入……" value="'+parseInt(table[i].grand)+'">'+
										 		  '<i class="tag icon"></i>'+   
										 		'</div>'+
										 		'</div> '+
											 '</div>'+ 
									 	'</div>'+
											 '<div class="ui divider"></div>';
						$(".content.grand").append($(dom));  
						
					}
					var text=
					 		'<div class="header">'+ 
					 		'<i class=" github middle aligned file word outline icon"></i>'+
					 			
					 			(table.length+1)+'、听课评价'+
					 	'</div>'+ 
					 		'<div class="description">'+
						       	'<textarea id="txttkpj" rows="3" style="width:90%;">'+table[0].skpj+'</textarea>'+
						    '</div>'+ 
						    '<div class="ui divider"></div>'+   
					 		'<div class="header">'+ 
					 			'<i class=" github middle aligned file word outline icon"></i>'+
					 			(table.length+2)+'、教学建议'+ 
					 		'</div>'+
					 		'<div class="description">'+    
						       	'<textarea id="txtjxjy" rows="3" style="width:90%;">'+table[0].jxjy+'</textarea>'+
				 	'</div>';
					$(".content.grand").append($(text));
					$(".gradebar").unbind("change").change(function(a,b,c,d){
						$(this).next().find('input').val($(this).val());   
					});
					$(".grand.input").unbind("change").change(function(a,b,c,d){
						var grand=parseInt($(this).val());
						var grandMax=parseInt($(this).parent().prev().attr("max"));
						if(grand>=0){ 
							if(grand>=grandMax)
							{
								$(this).val(grandMax);
								$(this).parent().prev().val(grandMax);
							}
							else{
								$(this).val(grand);
								$(this).parent().prev().val(grand);  
							}
						}else{
							$(this).val("0"); 
							$(this).parent().prev().val("0");  
						}
						$(this).parent().prev().val($(this).val());    
					});
					$('#modal') //弹出层初始化 
					  .modal('show')       
					; 
					
					$('#submitbtn').unbind('click').click(function(){
						if($(this).hasClass("loading")){
							return;
						}
						$(this).addClass("loading"); 
						var grand=[];
						
						for(var i=0;i<table.length;i++){
							var score=$('#grand'+i+'').val();
							var field=$('#grand'+i+'').parents('.repeat.item.ruleitem').attr("fieldname");
							grand.push(field+"-"+score);
						
						}
						var jxpj=$("#txttkpj").val();  
						var jxjy=$("#txtjxjy").val(); 
						var post_grand=grand.join(',');  
					
						postgrand(id ,jxpj , jxjy,post_grand);
					})
				}
			} 
		});
	} 
	function postgrand(id ,jxpj , jxjy,grand ){
		$.ajax({ 
			url:"do?invoke=marsterLiten@postgrand",
			type:'POST',
			dataType:'json',
			async: false,
			data:{ 
				id:id,
				jxpj:jxpj,
				jxjy:jxjy,
				grand:grand
			},
			success:function(rep){ 
				 
				$.alert({
					msg  : "修改成功",
					type : 'info',
					btnText : '我知道啦', 
					callback: function(){     
						$("#back").click();   
						$('#submitbtn').removeClass("loading"); 
						location.href=BASE_PATH+'/qm/Master/MasterListen.jsp?module=11&menu=29'; 
						 
					}
				});  
	
			}
		});
	}
}