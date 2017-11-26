<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>
<%@ page import="net.sf.jsi.examples.*"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="net.sf.jsi.Point"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.google.gson.*"%>
<%@ page import="org.apache.commons.lang3.*"%>
<%@ page import="function.YouBikeItem,function.NearYouBike" %>

<%	
	float inputlat = Float.parseFloat(StringUtils.isEmpty(request.getParameter("inputlat"))?"0":request.getParameter("inputlat"));
	float inputlng = Float.parseFloat(StringUtils.isEmpty(request.getParameter("inputlng"))?"0":request.getParameter("inputlng"));
	float outputlat = Float.parseFloat(StringUtils.isEmpty(request.getParameter("outputlat"))?"0":request.getParameter("outputlat"));
	float outputlng = Float.parseFloat(StringUtils.isEmpty(request.getParameter("outputlng"))?"0":request.getParameter("outputlng"));
	
	final Point inputp = new Point(inputlat, inputlng);
	final Point outputp = new Point(outputlat, outputlng);

	NearYouBike NearP = new NearYouBike();
	ArrayList<ArrayList<YouBikeItem>> YouBikeList = NearP.NearOne(inputp,outputp);
	String json = new Gson().toJson(YouBikeList);
	
	response.getWriter().write(json);
	response.getWriter().flush();
	response.getWriter().close();
%>
