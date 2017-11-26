<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>

<%@ page import="java.sql.*" %>

<%	
	
  try { 
    Class.forName("com.mysql.jdbc.Driver").newInstance(); 
    //註冊driver 
    Connection con = null;
    con = DriverManager.getConnection( 
    "jdbc:mysql://localhost/daytrip?useUnicode=true&characterEncoding=UTF8", 
    "root","v112233"); 
    //取得connection
	//jdbc:mysql://localhost/test?useUnicode=true&characterEncoding=Big5
	//localhost是主機名,test是database名
	//useUnicode=true&characterEncoding=Big5使用的編碼 

    System.out.println("Connected to the database");
    con.close();
    System.out.println("Disconnected from database");
    
  } 
  catch(ClassNotFoundException e) 
  { 
    System.out.println("DriverClassNotFound :"+e.toString()); 
  }//有可能會產生sqlexception 
  catch(SQLException x) { 
    System.out.println("Exception :"+x.toString()); 
  } 
	
%>
