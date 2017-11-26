package db; 

import java.sql.Connection; 
import java.sql.DriverManager; 
import java.sql.PreparedStatement; 
import java.sql.ResultSet; 
import java.sql.SQLException; 
import java.sql.Statement; 

public class jdbcmysql { 
  protected Connection con = null; //Database objects 
  //連接object 
  protected Statement stat = null; 
  //執行,傳入之sql為完整字串 
  protected ResultSet rs = null; 
  //結果集 
  protected PreparedStatement pst = null; 
  //執行,傳入之sql為預儲之字申,需要傳入變數之位置 
  //先利用?來做標示 
  
  public jdbcmysql() 
  { 
    try { 
      Class.forName("com.mysql.jdbc.Driver"); 
      //註冊driver 
      con = DriverManager.getConnection( 
      "jdbc:mysql://localhost/daytrip?useUnicode=true&characterEncoding=UTF8", 
      "root","v112233");  
      //取得connection
      //jdbc:mysql://localhost/test?useUnicode=true&characterEncoding=Big5
      //localhost是主機名,test是database名
      //useUnicode=true&characterEncoding=Big5使用的編碼 
    } 
    catch(ClassNotFoundException ClassNotFoundE) 
    {
    	System.out.println("ClassNotFoundException: " + ClassNotFoundE.toString());
    }//有可能會產生sqlexception
    catch(SQLException SQLE) {
    	System.out.println("SQLException: " + SQLE.toString());
    } 
    
  } 
  
  //完整使用完資料庫後,記得要關閉所有Object 
  //否則在等待Timeout時,可能會有Connection poor的狀況 
  public void Close() 
  { 
    try 
    { 
      if(rs!=null) 
      { 
        rs.close(); 
        rs = null; 
      } 
      if(stat!=null) 
      { 
        stat.close(); 
        stat = null; 
      } 
      if(pst!=null) 
      { 
        pst.close(); 
        pst = null; 
      } 
    } 
    catch(SQLException e) 
    { 
      System.out.println("Close Exception :" + e.toString()); 
    } 
  } 
}