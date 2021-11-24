package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

//通用的数据操作方法
public class DBUtil {
	private static final String URL = "jdbc:mysql://localhost:3306/library_management?serverTimezone=GMT%2B8&characterEncoding=utf8&useSSL=false";
	private static final String USERNAME = "root";
	private static final String PASSWORD = "123456";
	public static Connection connection = null;
	public static PreparedStatement pstmt = null;
	public static ResultSet rs = null;
	
	//通用的：查询总数
	public static int getTotalCount(String sql ) {//select count(*) from xx ;
		int count = -1 ;
		try {
			pstmt = createPreParedStatement(sql, null) ;
			rs = pstmt.executeQuery() ;//88
			if(rs.next()) {
				count= rs.getInt( 1 ) ;
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeAll(rs, pstmt, connection);
		}
		return count ;
	}
	
	//通用的增删改
	public static boolean executeUpdate(String sql,Object[] params) {
		try {  
			  pstmt = createPreParedStatement(sql,params);
			  int count = pstmt.executeUpdate() ;
			  if(count>0)
				  return true ;
			  else 
				  return false ;
			  
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			  return false ;
		} catch (SQLException e) {
			e.printStackTrace();
			  return false ;
		}catch (Exception e) {
			e.printStackTrace();
			return false ;
		}
		finally {
			closeAll(null,pstmt,connection);
		}
	}
		//Statement  关闭连接实例
		public static void closeAll(ResultSet rs,Statement stmt,Connection connection)
		{
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(connection!=null)connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
			
		// connection  连接 
		public static Connection getConnection() throws ClassNotFoundException, SQLException {
			 Class.forName("com.mysql.jdbc.Driver") ;
			 return  DriverManager.getConnection( URL,USERNAME,PASSWORD ) ;
		}
		//PreparedStatement
		public static PreparedStatement createPreParedStatement(String sql,Object[] params) throws ClassNotFoundException, SQLException {
			  pstmt = getConnection().prepareStatement(sql) ;
			  if(params!=null ) {
				  for(int i=0;i<params.length;i++) {
					  pstmt.setObject(i+1, params[i]);
				  }
			  }
			  return pstmt;
		}
		
		//通用的查  
		public static ResultSet executeQuery(String sql ,Object[] params) {
			try {
				pstmt = createPreParedStatement(sql,params);
				rs =  pstmt.executeQuery() ;
				return rs ;
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
				return null ; 
			} catch (SQLException e) {
				e.printStackTrace();
				return null ; 
			}catch (Exception e) {
				e.printStackTrace();
				return null ; 
			}
		}
	
	
	
	
	
	
	
	
	
	
}
