package function; 

import java.util.ArrayList;

import db.jdbcmysql;
import function.YouBikeItem;

public class YouBikeData extends jdbcmysql { 
	
	public ArrayList<YouBikeItem> GetStop(){
		
		StringBuffer sSql = new StringBuffer();
		ArrayList<YouBikeItem> result = new ArrayList<YouBikeItem>();
		
		try {
			
			sSql.append("SELECT * FROM daytrip.youbikestop order by id asc");
			
			pst = con.prepareStatement(sSql.toString()); 
			pst.clearParameters();
			
    		rs = pst.executeQuery();


			while(rs.next()){
				YouBikeItem YouBikeI = new YouBikeItem();
				
				YouBikeI.setId(rs.getInt("id"));
				YouBikeI.setLat(rs.getDouble("lat"));
				YouBikeI.setLng(rs.getDouble("lng"));
				YouBikeI.setStation(rs.getString("station"));
				YouBikeI.setSarea(rs.getString("sarea"));
				YouBikeI.setAddress(rs.getString("address"));
				YouBikeI.setTotal(rs.getInt("total"));
				
				result.add(YouBikeI);
			}
			
			return result;
		      
		}
		catch(Exception SQLE)
		{ 
			System.out.println("SQLException: " + SQLE.toString()); 
		}finally{
			Close();
		}
		
		return null;

	}
	
	public ArrayList<YouBikeItem> GetHsinchu(){
		
		StringBuffer sSql = new StringBuffer();
		ArrayList<YouBikeItem> result = new ArrayList<YouBikeItem>();
		
		try {
			
			sSql.append("SELECT * FROM daytrip.hsinchu order by id asc");
			
			pst = con.prepareStatement(sSql.toString()); 
			pst.clearParameters();
			
    		rs = pst.executeQuery();


			while(rs.next()){
				YouBikeItem YouBikeI = new YouBikeItem();
				
				YouBikeI.setId(rs.getInt("id"));
				YouBikeI.setLat(rs.getDouble("lat"));
				YouBikeI.setLng(rs.getDouble("lng"));
				YouBikeI.setStation(rs.getString("station"));
				YouBikeI.setAddress(rs.getString("address"));
				YouBikeI.setTotal(rs.getInt("total"));
				
				int total = rs.getInt("total");
				if(total > 100){
					//red
					YouBikeI.setImage("r.png");
				}else if(total <= 100 && total > 50){
					//yellow
					YouBikeI.setImage("o.png");
				}else if(total <= 50){
					//green
					YouBikeI.setImage("g.png");
				}
				
				result.add(YouBikeI);
			}
			
			return result;
		      
		}
		catch(Exception SQLE)
		{ 
			System.out.println("SQLException: " + SQLE.toString()); 
		}finally{
			Close();
		}
		
		return null;

	}

	public ArrayList<YouBikeItem> GetCircle(){
		
		StringBuffer sSql = new StringBuffer();
		ArrayList<YouBikeItem> result = new ArrayList<YouBikeItem>();
		
		try {
			
			sSql.append("SELECT * FROM daytrip.circle order by id asc");
			
			pst = con.prepareStatement(sSql.toString()); 
			pst.clearParameters();
			
    		rs = pst.executeQuery();


			while(rs.next()){
				YouBikeItem YouBikeI = new YouBikeItem();
				
				YouBikeI.setId(rs.getInt("id"));
				YouBikeI.setLat(rs.getDouble("lat"));
				YouBikeI.setLng(rs.getDouble("lng"));
				YouBikeI.setStation(rs.getString("station"));
				YouBikeI.setAddress(rs.getString("address"));

				result.add(YouBikeI);
			}
			
			return result;
		      
		}
		catch(Exception SQLE)
		{ 
			System.out.println("SQLException: " + SQLE.toString()); 
		}finally{
			Close();
		}
		
		return null;

	}
	
	public ArrayList<YouBikeItem> GetSchool(){
		
		StringBuffer sSql = new StringBuffer();
		ArrayList<YouBikeItem> result = new ArrayList<YouBikeItem>();
		
		try {
			
			sSql.append("SELECT * FROM daytrip.school order by id asc");
			
			pst = con.prepareStatement(sSql.toString()); 
			pst.clearParameters();
			
    		rs = pst.executeQuery();


			while(rs.next()){
				YouBikeItem YouBikeI = new YouBikeItem();
				
				YouBikeI.setId(rs.getInt("id"));
				YouBikeI.setLat(rs.getDouble("lat"));
				YouBikeI.setLng(rs.getDouble("lng"));
				YouBikeI.setStation(rs.getString("station"));
				YouBikeI.setAddress(rs.getString("address"));

				result.add(YouBikeI);
			}
			
			return result;
		      
		}
		catch(Exception SQLE)
		{ 
			System.out.println("SQLException: " + SQLE.toString()); 
		}finally{
			Close();
		}
		
		return null;

	}
	
	public ArrayList<YouBikeItem> GetTraffic(){
		
		StringBuffer sSql = new StringBuffer();
		ArrayList<YouBikeItem> result = new ArrayList<YouBikeItem>();
		
		try {
			
			sSql.append("SELECT * FROM daytrip.traffic order by id asc");
			
			pst = con.prepareStatement(sSql.toString()); 
			pst.clearParameters();
			
    		rs = pst.executeQuery();


			while(rs.next()){
				YouBikeItem YouBikeI = new YouBikeItem();
				
				YouBikeI.setId(rs.getInt("id"));
				YouBikeI.setLat(rs.getDouble("lat"));
				YouBikeI.setLng(rs.getDouble("lng"));
				YouBikeI.setStation(rs.getString("station"));
				YouBikeI.setAddress(rs.getString("address"));

				result.add(YouBikeI);
			}
			
			return result;
		      
		}
		catch(Exception SQLE)
		{ 
			System.out.println("SQLException: " + SQLE.toString()); 
		}finally{
			Close();
		}
		
		return null;

	}
	
	public ArrayList<YouBikeItem> GetTourism(){
		
		StringBuffer sSql = new StringBuffer();
		ArrayList<YouBikeItem> result = new ArrayList<YouBikeItem>();
		
		try {
			
			sSql.append("SELECT * FROM daytrip.tourism order by id asc");
			
			pst = con.prepareStatement(sSql.toString()); 
			pst.clearParameters();
			
    		rs = pst.executeQuery();


			while(rs.next()){
				YouBikeItem YouBikeI = new YouBikeItem();
				
				YouBikeI.setId(rs.getInt("id"));
				YouBikeI.setLat(rs.getDouble("lat"));
				YouBikeI.setLng(rs.getDouble("lng"));
				YouBikeI.setStation(rs.getString("station"));
				YouBikeI.setAddress(rs.getString("address"));

				result.add(YouBikeI);
			}
			
			return result;
		      
		}
		catch(Exception SQLE)
		{ 
			System.out.println("SQLException: " + SQLE.toString()); 
		}finally{
			Close();
		}
		
		return null;

	}
	
	public ArrayList<YouBikeItem> GetDepartment(){
		
		StringBuffer sSql = new StringBuffer();
		ArrayList<YouBikeItem> result = new ArrayList<YouBikeItem>();
		
		try {
			
			sSql.append("SELECT * FROM daytrip.department order by id asc");
			
			pst = con.prepareStatement(sSql.toString()); 
			pst.clearParameters();
			
    		rs = pst.executeQuery();


			while(rs.next()){
				YouBikeItem YouBikeI = new YouBikeItem();
				
				YouBikeI.setId(rs.getInt("id"));
				YouBikeI.setLat(rs.getDouble("lat"));
				YouBikeI.setLng(rs.getDouble("lng"));
				YouBikeI.setStation(rs.getString("station"));
				YouBikeI.setAddress(rs.getString("address"));

				result.add(YouBikeI);
			}
			
			return result;
		      
		}
		catch(Exception SQLE)
		{ 
			System.out.println("SQLException: " + SQLE.toString()); 
		}finally{
			Close();
		}
		
		return null;

	}
	
	public ArrayList<YouBikeItem> GetHot(){
		
		StringBuffer sSql = new StringBuffer();
		ArrayList<YouBikeItem> result = new ArrayList<YouBikeItem>();
		
		try {
			
			sSql.append("SELECT id,inputlat,inputlng,input FROM daytrip.hotsearch where distance1 > 500 order by id");
			
			pst = con.prepareStatement(sSql.toString()); 
			pst.clearParameters();
			
    		rs = pst.executeQuery();


			while(rs.next()){
				YouBikeItem YouBikeI = new YouBikeItem();
				
				YouBikeI.setId(rs.getInt("id"));
				YouBikeI.setLat(rs.getDouble("inputlat"));
				YouBikeI.setLng(rs.getDouble("inputlng"));
				YouBikeI.setStation(rs.getString("input"));

				result.add(YouBikeI);
			}
			
			sSql = null;
			sSql = new StringBuffer();
			sSql.append("SELECT id,outputlat,outputlng,output FROM daytrip.hotsearch where distance3 > 500 order by id");
			
			pst = con.prepareStatement(sSql.toString()); 
			pst.clearParameters();
			
    		rs = pst.executeQuery();


			while(rs.next()){
				YouBikeItem YouBikeI = new YouBikeItem();
				
				YouBikeI.setId(rs.getInt("id"));
				YouBikeI.setLat(rs.getDouble("outputlat"));
				YouBikeI.setLng(rs.getDouble("outputlng"));
				YouBikeI.setStation(rs.getString("output"));

				result.add(YouBikeI);
			}
			
			return result;
		      
		}
		catch(Exception SQLE)
		{ 
			System.out.println("SQLException: " + SQLE.toString()); 
		}finally{
			Close();
		}
		
		return null;

	}
	
	public boolean InsetHotSearch(double inputlat,double inputlng,String input,String distance1,double inputplat,double inputplng,String inputp,String distance2,double outputplat,double outputplng,String outputp,String distance3,double outputlat,double outputlng,String output){
		
		StringBuffer sSql = new StringBuffer();
		ArrayList<YouBikeItem> result = new ArrayList<YouBikeItem>();
		
		try {
			
			sSql.append("INSERT INTO hotsearch " + "VALUES (null,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			
			pst = con.prepareStatement(sSql.toString()); 
			pst.clearParameters();
			pst.setDouble(1, inputlat);
			pst.setDouble(2, inputlng);
			pst.setString(3, input);
			pst.setString(4, distance1);
			pst.setDouble(5, inputplat);
			pst.setDouble(6, inputplng);
			pst.setString(7, inputp);
			pst.setString(8, distance2);
			pst.setDouble(9, outputplat);
			pst.setDouble(10, outputplng);
			pst.setString(11, outputp);
			pst.setString(12, distance3);
			pst.setDouble(13, outputlat);
			pst.setDouble(14, outputlng);
			pst.setString(15, output);
			
    		int insertrows = pst.executeUpdate();
    		
    		if(insertrows > 0){
    			return true;
    		}else{
    			return false;
    		}		
		      
		}
		catch(Exception SQLE)
		{ 
			System.out.println("SQLException: " + SQLE.toString()); 
		}finally{
			Close();
		}
		
		return false;

	}	
}