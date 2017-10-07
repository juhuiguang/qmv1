<%@page import="com.jhg.utils.PropertyConfig"%>
<%@page import="com.service.system.SystemStart"%>
<%@page import="com.sys.LoginServer"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.jhg.common.TypeUtils"%>
<%@page import=" com.alibaba.fastjson.JSONObject"%>
<%@page import=" com.alibaba.fastjson.JSONArray"%>
<%@page 
	language="java"
	contentType="text/html; charset=GB2312"
	pageEncoding="GB2312"
	import="com.wiscom.is.*, java.net.*"
%>

<%
	String is_config = request.getRealPath("/client.properties");
    Cookie all_cookies[] = request.getCookies();
    Cookie myCookie;
    String decodedCookieValue = null;
    if (all_cookies != null) {
        for(int i=0; i< all_cookies.length; i++) {
        	System.out.println("cookies"+i+":"+all_cookies[i]);
            myCookie = all_cookies[i];
            if( myCookie.getName().equals("iPlanetDirectoryPro") ) {
            	System.out.println("decodedCookieValue："+decodedCookieValue);
                decodedCookieValue = URLDecoder.decode(myCookie.getValue(),"GB2312");
            }
        }
    }
	System.out.println(is_config);
	IdentityFactory factory = IdentityFactory.createFactory( is_config );
	IdentityManager im = factory.getIdentityManager();
	
	String curUser = "";
	System.out.println("getting user>>>>>");
	if (decodedCookieValue != null ) {
		
    	curUser = im.getCurrentUser( decodedCookieValue );
    	System.out.println("getuser:"+curUser);
    }
	
	String systemurl = new PropertyConfig("sysConfig.properties").getValue("rootpath");
	if ( curUser.length()>0 ){
		String user_no=curUser;
		LoginServer ser=new LoginServer();
		List<Map<String,Object>> usrlist=ser.getUserData(user_no);
		if(TypeUtils.isEmpty(usrlist)){
			out.println("系统中不存在用户："+user_no+"。");
			return;
		}else{
			Map<String,Object> usermap=usrlist.get(0);
			session.setAttribute("secret",new java.util.Date().getTime());
			session.setAttribute("loginname", TypeUtils.getString(usermap.get("USER_LOGINNAME")));
			session.setAttribute("username", TypeUtils.getString(usermap.get("USER_NAME")));
			session.setAttribute("usertype", TypeUtils.getString(usermap.get("USER_TYPE")));
			session.setAttribute("userid", TypeUtils.getString(usermap.get("USER_ID")));
			session.setAttribute("userPurview", TypeUtils.getString(usermap.get("USER_PURVIEW")));
			SystemStart.resetUser(TypeUtils.getString(usermap.get("USER_LOGINNAME")));
			JSONObject currentuser=SystemStart.getUser(TypeUtils.getString(usermap.get("USER_LOGINNAME")));
			JSONArray roles=currentuser.getJSONArray("roles");
			if(roles.size()>0){
				for(int i=0;i<roles.size();i++){
					String userindex=roles.getJSONObject(i).getString("role_index");
					if(!userindex.equals("")){
						systemurl+="/"+userindex;
						break;
					}
				}
			}
			
		}
	}
	
	response.sendRedirect(systemurl);
%>