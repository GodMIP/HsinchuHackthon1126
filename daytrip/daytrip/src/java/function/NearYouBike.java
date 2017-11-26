package function;

import gnu.trove.procedure.TIntProcedure;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.ArrayList;

import net.sf.jsi.Point;
import net.sf.jsi.Rectangle;
import net.sf.jsi.SpatialIndex;
import net.sf.jsi.rtree.RTree;

import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONArray;

import db.jdbcmysql;

public class NearYouBike extends jdbcmysql {	
  String sna = "";
  String sarea = "";     

  public String getSna() {
	return sna;
  }

  public void setSna(String sna) {
	this.sna = sna;
  }

  public String getSarea() {
	return sarea;
  }
  
  public void setSarea(String sarea) {
	this.sarea = sarea;
  }
  
  public ArrayList<ArrayList<YouBikeItem>> NearOne(final Point inputp,final Point outputp) throws IOException, JSONException {

	  StringBuffer sSql = new StringBuffer();
	  ArrayList<YouBikeItem> result = new ArrayList<YouBikeItem>();
	 
      try {   	      	  
          
    	  sSql.append("SELECT * FROM daytrip.hsinchu order by id asc");
			
		  pst = con.prepareStatement(sSql.toString()); 
		  pst.clearParameters();
			
  		  rs = pst.executeQuery();
  		  
  		  rs.last();
  	      int size = rs.getRow();
  	      rs.beforeFirst();
  		  
    	  SpatialIndex si = new RTree();
          si.init(null);          
          final Rectangle[] rects = new Rectangle[size];
          int id = 0;
          
          while(rs.next()){
        	  YouBikeItem YouBikeI = new YouBikeItem();
              
        	  YouBikeI.setId(rs.getInt("id"));
			  YouBikeI.setLat(rs.getDouble("lat"));
			  YouBikeI.setLng(rs.getDouble("lng"));
			  YouBikeI.setStation(rs.getString("station"));
			  YouBikeI.setAddress(rs.getString("address"));
			  YouBikeI.setTotal(rs.getInt("total"));
    
              Float[] SWNE = ConvertPosition(Float.parseFloat(rs.getString("lat")),Float.parseFloat(rs.getString("lng")),0.05f);
              rects[id] = new Rectangle(SWNE[0],SWNE[1],SWNE[2],SWNE[3]); //將經緯度放入              
              si.add(rects[id], id); //放入Rtree中
              id++;
              
              result.add(YouBikeI);              
          }                 
          
          final ArrayList<YouBikeItem> inputNearestYouBikeList = new ArrayList<YouBikeItem>();
                   
          si.nearestN(inputp, new TIntProcedure() {
            public boolean execute(int i) {        	 
              YouBikeItem NearestList = (YouBikeItem) result.get(i);            
        	  
              inputNearestYouBikeList.add(NearestList);
              
              System.out.println("NearestList " + NearestList.getLat());
              System.out.println("Rectangle " + i + " " + rects[i] + ", distance=" + rects[i].distance(inputp));
              return true;
            }
          }, 1 , Float.MAX_VALUE );
          
          final ArrayList<YouBikeItem> outputNearestYouBikeList = new ArrayList<YouBikeItem>();
          
          si.nearestN(outputp, new TIntProcedure() {
              public boolean execute(int i) {        	 
                YouBikeItem NearestList = (YouBikeItem) result.get(i);            
          	  
                outputNearestYouBikeList.add(NearestList);
                
                System.out.println("NearestList " + NearestList.getLat());
                System.out.println("Rectangle " + i + " " + rects[i] + ", distance=" + rects[i].distance(outputp));
                return true;
              }
          }, 1 , Float.MAX_VALUE );
          
          final ArrayList<ArrayList<YouBikeItem>> allNearestYouBikeList = new ArrayList<ArrayList<YouBikeItem>>();
          
          allNearestYouBikeList.add(inputNearestYouBikeList);
          allNearestYouBikeList.add(outputNearestYouBikeList);
          
          return allNearestYouBikeList;
      }catch(Exception SQLE)
	  { 
    	  System.out.println("SQLException: " + SQLE.toString()); 
	  }finally{
		  Close();
	  }

      return null;
  }
  
  public Float[] ConvertPosition(float latitude,float longitude,float c){	
  	float lat_diff= c/110.574f;  //利用距離的比例來算出緯度上的比例
  	float lon_distance=(float)(111.320f * Math.cos(latitude*Math.PI/180)); //算出該緯度上的經度長度
  	float lon_diff= c/lon_distance; //利用距離的比例來算出經度上的比例

  	float N = latitude + Math.abs(lat_diff), //右上 緯度
  	S = latitude - Math.abs(lat_diff), //左下 緯度
  	E = longitude+ Math.abs(lon_diff), //右上 經度
  	W = longitude- Math.abs(lon_diff); //左下 經度
  	
  	Float[] SWNE = {S,W,N,E};
  	
  	//System.out.print("S: " + S);
  	//System.out.print(" W: " + W);
  	//System.out.print(" N: " + N);
  	//System.out.println(" E: " + E);
  	
  	return SWNE;
  }

}