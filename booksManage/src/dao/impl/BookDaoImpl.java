package dao.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

//import com.mysql.cj.xdevapi.Result;

import dao.IBookDao;
import entity.Book;
import entity.Book;
import util.DBUtil;

public class BookDaoImpl implements IBookDao {

	private static String URL = "jdbc:mysql://localhost:3306/library_management?serverTimezone=GMT%2B8&characterEncoding=utf8&useSSL=false";
	private static String USERNAME = "root";
	private static String PASSWORD = "123456";
	
	//添加book (增)
	public boolean addBook(Book b) { //成功返回 True 系统异常  False
		String sql = "insert into book values(?,?,?,?)";
		Object[] params = {b.getBookid(),b.getBookname(),b.getPublish(),b.getPrice()};
		return DBUtil.executeUpdate(sql, params);
	}

	//显示所有book信息
	public ArrayList<Book> getAllBooks() {
		ArrayList<Book> books = new ArrayList<Book>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		System.out.println("========getAllBooksDao========");
		try {
			String sql = "select * from book";
			
			rs = DBUtil.executeQuery(sql, null);
			while (rs.next()) {
				Book b = new Book();
				b.setBookid(rs.getString(1));
				b.setBookname(rs.getString(2));
				b.setPublish(rs.getString(3)); 
				b.setPrice(rs.getString(4));
				books.add(b);
			}
			return books;
		}catch(SQLException e){
			e.printStackTrace();
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			DBUtil.closeAll(rs, pstmt, DBUtil.connection);
		}
		return books;
	}

	//查询一个book详细信息
	public Book getBooks(String id) { 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Book b = new Book();
		try {
			
			String sql = "select * from book where bookid=?";
			Object[] params = {id};
			rs = DBUtil.executeQuery(sql, params);
			while (rs.next()) {
				b.setBookid(rs.getString(1));
				b.setBookname(rs.getString(2));
				b.setPublish(rs.getString(3)); 
				b.setPrice(rs.getString(4));
			}
			return b;
		}catch(SQLException e){
			e.printStackTrace();
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			DBUtil.closeAll(rs, pstmt, DBUtil.connection);
		}
		return b;
	}
	
	//删除book信息 
	public boolean deleteBook(String id) {  //返回 true成功   false 失败
		String sql = "delete from book where bookid=?";
		Object[] params = {id};
		return DBUtil.executeUpdate(sql, params);
	}
	
	//修改book信息
	public boolean updateBook(Book b) {  //返回 true成功   false 失败
		System.out.println("========sql_updateBookDao=======");
		String sql = "update book set bookname=?,price=?,publish=? where bookid=?";
		Object[] params = {b.getBookname(),b.getPrice(),b.getPublish(),b.getBookid()};
		return DBUtil.executeUpdate(sql, params);
	}
	

	//条件查询
	public ArrayList<Book> getBooksByCondition(String condition, String data) {
		ArrayList<Book> books = new ArrayList<Book>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		System.out.println("========sql_getBooksByConditionDao=======");
		try {
			String sql = "select * from book where "+condition+"=?";
			Object[] params = {data};
			System.out.println(condition);
			rs = DBUtil.executeQuery(sql, params);
			while (rs.next()) {
				Book b = new Book();
				b.setBookid(rs.getString(1));
				b.setBookname(rs.getString(2));
				b.setPublish(rs.getString(3));
				b.setPrice(rs.getString(4)); 
				books.add(b);
			}
			return books;
		}catch(SQLException e){
			e.printStackTrace();
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			DBUtil.closeAll(rs, pstmt, DBUtil.connection);
		}
		return books;
	}
	
	//分页查询
	@Override
	public int getTotalCount() {
		String sql = "select count(1) from book" ;
		return DBUtil.getTotalCount(sql);
	}
	@Override
	public ArrayList<Book> queryBooksByPage(int currentPage, int pageSize) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from book limit ?,?;";
		Object[] params = {(currentPage-1)*pageSize,pageSize}; 
		ArrayList<Book> books = new ArrayList<>();
		
		
		rs = DBUtil.executeQuery(sql, params) ;
		
		try {
			while(rs.next()) {
				Book b = new Book();
				b.setBookid(rs.getString(1));
				b.setBookname(rs.getString(2));
				b.setPublish(rs.getString(3));
				b.setPrice(rs.getString(4)); 
				books.add(b);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBUtil.closeAll(rs, pstmt, DBUtil.connection);
		}
		return books;
	}
	
	//stu_user 查看已借图书
	public ArrayList<Book> getBorrowedBook(String uname){
		ArrayList<Book> books = new ArrayList<Book>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		System.out.println("========getBorrowedBookDao========");
		try {
			String sql = "SELECT * FROM book WHERE bookid in (SELECT bookid FROM stu_borrow WHERE borrower=? AND state=1)";
			Object[] params = {uname};
			rs = DBUtil.executeQuery(sql, params);
			while (rs.next()) {
				Book b = new Book();
				b.setBookid(rs.getString(1));
				b.setBookname(rs.getString(2));
				b.setPublish(rs.getString(3)); 
				b.setPrice(rs.getString(4));
				books.add(b);
			}
			return books;
		}catch(SQLException e){
			e.printStackTrace();
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			DBUtil.closeAll(rs, pstmt, DBUtil.connection);
		}
		return books;
	}
	
	//借书 (查+增)
	public boolean borrowBook(String userName,String bookId) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count=-1;
		int bk,un;
		System.out.println("========borrowBookDao========");
		try {
			
			bk = pdbk(bookId);
			un = pdun(userName)	;	
			String sql = "SELECT count(bookid) FROM stu_borrow WHERE bookid=? AND state=1";
			Object[] params = {bookId};
			rs = DBUtil.executeQuery(sql, params);
			if (rs.next()) {
				count = rs.getInt(1);  //已存在为1   否则为0
			}
			if (count==0 && bk==1 && un==1) {
				String sql2 = "insert into stu_borrow values(?,?,1)";
				Object[] params2 = {bookId,userName};
				return DBUtil.executeUpdate(sql2, params2);
			}else {
				return false;
			}
		}catch(SQLException e){
			e.printStackTrace();
			return false;
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}finally {
			DBUtil.closeAll(rs, pstmt, DBUtil.connection);
		}
	}
	
	public int pdbk(String bookId) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int bk = -1;
		try {
			String sql3 = "SELECT count(*) FROM book where bookid=?";
			Object[] params3 = {bookId};
			rs = DBUtil.executeQuery(sql3, params3);
			if(rs.next()) {
				bk = rs.getInt(1); //已存在为1   否则为0
			}
			return bk;
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

	public int pdun(String userName) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int un = -1;
		try {
			String sql = "SELECT count(*) FROM usertable where userName=? AND userType=?";
			Object[] params = {userName,"stu_user"};
			rs = DBUtil.executeQuery(sql, params);
			if(rs.next()) {
				un = rs.getInt(1); //已存在为1   否则为0
			}
			return un;
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
	
	//还书
	public boolean returnBook(String userName,String bookId) {
		System.out.println("========returnBookDao=======");
		String sql = "UPDATE stu_borrow SET state=0 WHERE borrower=? AND bookid=?";
		Object[] params = {userName,bookId};
		return DBUtil.executeUpdate(sql, params);
	}
	


}
