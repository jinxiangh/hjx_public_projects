package dao;

import java.util.ArrayList;

import entity.Book;
import entity.Book;

public interface IBookDao {

	//添加Book (增)
	boolean addBook(Book b);

	//查询一个Book详细信息
	Book getBooks(String id);

	//删除Book信息 
	boolean deleteBook(String id);

	//修改Book信息
	boolean updateBook(Book f);
	
	//查询所有Book
	ArrayList<Book> getAllBooks();
	
	//按条件查询
	ArrayList<Book> getBooksByCondition(String condition,String newData);
	
	//查询总数据
	int getTotalCount();
	
	//currentPage:当前页（页码）   pageSize：页面大小（每页显示的数据条数）
	ArrayList<Book> queryBooksByPage(int currentPage,int pageSize);
	
	//stu_user 查看已借图书
	ArrayList<Book> getBorrowedBook(String uname);
	
	//借书 (查+增)
	boolean borrowBook(String userName,String bookId);
	
	//还书
	boolean returnBook(String userName,String bookId);
	
	
}