package com.jhg.mvc;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jhg.utils.PropertyConfig;

public class Dispatch   extends HttpServlet {
	private static final long serialVersionUID = 1445994328471051152L;
	public void init()  throws ServletException
    {
		
    }
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {		
		doPost(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{	
		response.setCharacterEncoding("UTF-8"); 
		response.addHeader("Content-Encoding", "UTF-8");
		request.setCharacterEncoding("UTF-8");
        String __class   = "";
        String __methond = "";  
        
        String __invoke  = request.getParameter("invoke");
        if(__invoke==null || __invoke.equals(""))
        {
        	System.err.println("[ERROR]请求URL连接 "+request.getRequestURL()+" 未找到invoke参数�?");
        	return ;
        
        }
        if(__invoke.indexOf("@")==-1)
        {
        	System.err.println("[ERROR]请求URL连接"+request.getRequestURL()+" 中invoke参数,没有@<method>未指定调用方面名�?");
        	return ;
        }
        String[] __array   = __invoke.split("@");
        __class   = __array[0] ; 
        
       if(null!=__class&&""!=__class){
    	  String class__= new PropertyConfig("sysConfig.properties").getValue(__class);
    	   if(null!=class__&&""!=class__){
    		   __methond = __array[1]; 
    	        this.invoke(request, response, class__, __methond);
    	   }else{
    		   System.err.println("[ERROR]请求URL------"+__class+"------未找到�??");
    	   }
    	   
       }
	}
	
	
	
	protected boolean IsExtends(Class<?> childClass,Class<?> superClass)
	{   
		 Class<?>    __superClass = childClass;
		 boolean  __isExist    = false;
		 while(true)
		 {   
			 if(__superClass!=null)
			 {
				__superClass = __superClass.getSuperclass();
				if(__superClass==null)
				{
					 break;
				}
				else if(__superClass==superClass)
				{
					 __isExist =true; break;
				}
			 }
			 else
			 {
				 break;
			 }
		 }
	     return __isExist;
	}
	
	
	protected void invoke(HttpServletRequest request, HttpServletResponse response,String className,String method)
	{   
		try 
		{  
			Class<?>   cAction  = com.jhg.mvc.Action.class;
			Class<?>   classZ   = Class.forName(className);	
	//----------------------------------------------------------------------------------------------------------------
    //�?测继�?
			classZ.getGenericSuperclass();
			classZ.getSuperclass();
		    Object  __Instance  =  classZ.newInstance();		 
			Method  __Method    =  __Instance.getClass().getMethod(method);		
			if(!IsExtends(classZ,cAction))
			{
				throw new ClassNotFoundException(className+"不是"+cAction.toString()+"子类");
			}
			Method  __RequestMethod  =  cAction.getDeclaredMethod("setRequest",javax.servlet.http.HttpServletRequest.class);
			Method  __ResponseMethod =  cAction.getDeclaredMethod("setResponse",javax.servlet.http.HttpServletResponse.class);
			if(!__RequestMethod.isAccessible())
			{
			   __RequestMethod.setAccessible(true);
			   __RequestMethod.invoke(__Instance,new Object[]{request});
			   __RequestMethod.setAccessible(false);
			}
			else
			{
			   __RequestMethod.invoke(__Instance,new Object[]{request});
			}
			if(!__ResponseMethod.isAccessible())
			{
				__ResponseMethod.setAccessible(true);
				__ResponseMethod.invoke(__Instance,new Object[]{response});
				__ResponseMethod.setAccessible(false);
			}
			else
			{
				__ResponseMethod.invoke(__Instance,new Object[]{response});
			}
			if(!__Method.isAccessible())
			{
				__Method.setAccessible(true);
				__Method.invoke(__Instance, new Object[]{});
				__Method.setAccessible(false);
			}
			else
			{
				__Method.invoke(__Instance,new Object[]{});
			}   
		} 
		catch (ClassNotFoundException e)
		{
			System.err.println("[ERROR]"+request.getRequestURL()+" URL中不能找�?"+className+"Classs");
			e.printStackTrace();
		}
		catch (InvocationTargetException e)
		{
			e.printStackTrace();
		}		
		catch (InstantiationException e)
		{
			e.printStackTrace();
		}
		catch (SecurityException e)
		{
			e.printStackTrace();
		}
		catch(NoSuchMethodException e)
		{
			e.printStackTrace();
		}
		catch (IllegalAccessException e)
		{
			e.printStackTrace();
		}
	}
}


