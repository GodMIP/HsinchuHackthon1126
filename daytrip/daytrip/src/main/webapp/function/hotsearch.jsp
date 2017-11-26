<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>

<%@ page import="net.sf.jsi.Point"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.apache.commons.lang3.*"%>
<%@ page import="com.google.gson.*"%>

<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.FileInputStream"%>

<%@ page import="function.YouBikeData,function.YouBikeItem"%>

<%	
	double inputlat = Double.parseDouble(StringUtils.isEmpty(request.getParameter("inputlat"))?"0":request.getParameter("inputlat"));
	double inputlng = Double.parseDouble(StringUtils.isEmpty(request.getParameter("inputlng"))?"0":request.getParameter("inputlng"));
	String input = request.getParameter("input");
	
	String distance1 = request.getParameter("distance1");
	
	double inputplat = Double.parseDouble(StringUtils.isEmpty(request.getParameter("inputplat"))?"0":request.getParameter("inputplat"));
	double inputplng = Double.parseDouble(StringUtils.isEmpty(request.getParameter("inputplng"))?"0":request.getParameter("inputplng"));
	String inputp = request.getParameter("inputp");
	
	String distance2 = request.getParameter("distance2");
	
	double outputplat = Double.parseDouble(StringUtils.isEmpty(request.getParameter("outputplat"))?"0":request.getParameter("outputplat"));
	double outputplng = Double.parseDouble(StringUtils.isEmpty(request.getParameter("outputplng"))?"0":request.getParameter("outputplng"));
	String outputp = request.getParameter("outputp");
	
	String distance3 = request.getParameter("distance3");
	
	double outputlat = Double.parseDouble(StringUtils.isEmpty(request.getParameter("outputlat"))?"0":request.getParameter("outputlat"));
	double outputlng = Double.parseDouble(StringUtils.isEmpty(request.getParameter("outputlng"))?"0":request.getParameter("outputlng"));	
	String output = request.getParameter("output");
	
	YouBikeData Data = new YouBikeData();
	boolean Item = Data.InsetHotSearch(inputlat,inputlng,input,distance1,inputplat,inputplng,inputp,distance2,outputplat,outputplng,outputp,distance3,outputlat,outputlng,output);
	String json = new Gson().toJson(Item);
	
	response.getWriter().write(json);
	response.getWriter().flush();
	response.getWriter().close();
	
%>
