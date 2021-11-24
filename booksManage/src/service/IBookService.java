package service;

import java.util.ArrayList;

import entity.Book;


public interface IBookService {

	//添加book
	boolean addBook(Book b);

	//查询所有book
	ArrayList<Book> getAllBooks();

	//查询一个book详细信息
	Book getBooks(String id);

	//删除book信息 
	boolean deleteBook(String id);

	//修改book信息
	boolean updateBook(Book id);
	
	//按条件查询
	ArrayList<Book> getBooksByCondition(String condition,String newData);
	
	//查询总数据
	int getTotalCount();
	
	//分页查询
	ArrayList<Book> queryBooksByPage(int currentPage,int pageSize);
	
	//stu_user 查看已借图书
	ArrayList<Book> getBorrowedBook(String uname);
	
	//借书 (查+增)
	boolean borrowBook(String userName,String bookId);
	
	//还书
	boolean returnBook(String userName,String bookId);
}