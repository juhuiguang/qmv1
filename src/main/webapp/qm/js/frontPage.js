/**
 * 
 */
function page(){
 this.changepage=function(pageindex,pagelength,totaltemp,totalpage){
		 if(totalpage==0)
			  $("#spanPageNum").text(0);
			else
				$("#spanPageNum").text(pageindex);
			//判断按钮是否禁用 
			if(pageindex==1 ||totalpage==0)
				{
				    $("#spanPre").removeAttr("href"); 
				    $("#spanPre").addClass("display")
				}
			if(totalpage>1){
			if(pageindex==2 ||pageindex==totalpage)
			{
				if(typeof($("#spanPre").attr("href"))=="undefined"){
			    $("#spanPre").attr("href","javascript:void(0);");
			    $("#spanPre").removeClass("display")
				}
			}
			}
			if(pageindex==1 ||totalpage==0)
			{
			    $("#spanFirst").removeAttr("href");
			    $("#spanFirst").addClass("display")
			}
			if(totalpage>1){
				if(pageindex==2 ||pageindex==totalpage) 
				{
					if(typeof($("#spanFirst").attr("href"))=="undefined"){
				    $("#spanFirst").attr("href","javascript:void(0);");
				    $("#spanFirst").removeClass("display")
					}
				}
			}
			if(pageindex==totalpage ||totalpage==0)
			{
			    $("#spanNext").removeAttr("href");
			    $("#spanNext").addClass("display")
			} 
		  if(totalpage>1){
				if(pageindex==totalpage-1 ||pageindex==1)
				{
					if(typeof($("#spanNext").attr("href"))=="undefined"){ 
				    $("#spanNext").attr("href","javascript:void(0);");
				    $("#spanNext").removeClass("display")
					}
				}
			}
		if(pageindex==totalpage ||totalpage==0)
		{
		    $("#spanLast").removeAttr("href");
		    $("#spanLast").addClass("display")
		}
		if(totalpage>1){
			if(pageindex==totalpage-1 ||pageindex==1)
			{
				if(typeof($("#spanLastt").attr("href"))=="undefined"){
				    $("#spanLast").attr("href","javascript:void(0);");
				    $("#spanLast").removeClass("display")
				}
			}
		}
	 }
 }