<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>

<%@ page import="net.sf.jsi.Point"%>
<%@ page import="json.*"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.apache.commons.lang3.*"%>
<%@ page import="com.google.gson.*"%>

<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.FileInputStream"%>

<%	
	
	String sarea = StringUtils.isEmpty(request.getParameter("sarea"))?"":request.getParameter("sarea");
	String keyword = StringUtils.isEmpty(request.getParameter("keyword"))?"":request.getParameter("keyword");
	float positionlatitude = Float.parseFloat(StringUtils.isEmpty(request.getParameter("positionlatitude"))?"0":request.getParameter("positionlatitude"));
	float positionlongitude = Float.parseFloat(StringUtils.isEmpty(request.getParameter("positionlongitude"))?"0":request.getParameter("positionlongitude"));
	
	System.out.println("sarea: " + sarea);
	System.out.println("keyword: " + keyword);
	System.out.println("positionlatitude: " + positionlatitude);
	System.out.println("positionlongitude: " + positionlongitude);
	
	final Point p = new Point(positionlatitude, positionlongitude);

	ServletContext context = request.getSession().getServletContext();
	InputStream  input = context.getResourceAsStream("/properties/youbike.properties");
	Properties prop = new Properties();
	prop.load(input);	
	System.out.println(prop.getProperty("currentinformation"));
	
	
	JsonReader read = new JsonReader();
	read.setSna(keyword);
	read.setSarea(sarea);
	ArrayList<YouBikeItem> YouBikeList = read.FromUrl(prop.getProperty("currentinformation"),p);
	String json = new Gson().toJson(YouBikeList);
	
	response.getWriter().write(json);
	response.getWriter().flush();
	response.getWriter().close();
	
%>
