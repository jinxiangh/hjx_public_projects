package dao.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dao.IUserDao;
import entity.User;
import util.DBUtil;

//数据访问层 
public class UserDaoImpl implements IUserDao {
	//登入 （查）
	public int Login(User user) {//1 登入成功   0：用户名或密码错误  -1系统错误
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "select count(*) from usertable where userName=? and password=? and userType=?";
			Object[] params = {user.getName(),user.getPwd(),user.getType()};
			rs = DBUtil.executeQuery(sql, params);  //返回查的结果集
			int count=0;
			if(rs.next()) {//next() 指针下移，有数据为True
				count = rs.getInt(1);  //1
			}
			return count;

		}catch(SQLException e){
			e.printStackTrace();
			return -1;
		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}finally {
			DBUtil.closeAll(rs, pstmt, DBUtil.connection);
		}
	}

	//注册  (查+增)
	public int Adduser(User user) {   // 成功返回 0    用户名已存在 1   系统异常 -1  
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = -1;
		try {
			String sql = "select count(*) from usertable where userName=? and userType=?";
			Object[] params = {user.getName(),user.getType()};
			rs = DBUtil.executeQuery(sql, params);  //返回查的结果集
			if(rs.next()){				//next() 指针下移，有数据为True
				count = rs.getInt(1);  //已存在为1   否则为0
			}
			if(count == 0) {
				sql = "insert into usertable(userName,password,userType) values(?,?,?)";
				Object[] params2 = {user.getName(),user.getPwd(),user.getType()};
				DBUtil.executeUpdate(sql, params2);  //添加成功返回True
			}
			return count;

		}catch(SQLException e){
			e.printStackTrace();
			return -1;
		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}finally {
			DBUtil.closeAll(rs, pstmt, DBUtil.connection);
		}	
	}
	
	//删除stu_user用户
	public boolean delStuUser(String userName) {
		String sql = "DELETE FROM usertable WHERE userName=? AND userType='stu_user'";
		Object[] params = {userName};
		return DBUtil.executeUpdate(sql, params);
	}
	

	//修改密码   （改）
	public boolean updatePassword(User user) {  // 成功返回 True 系统异常  False
		String sql = "update usertable set password=? where userName=? and userType=?";
		Object[] params = {user.getPwd(),user.getName(),user.getType()};
		return DBUtil.executeUpdate(sql, params);
	}
}

