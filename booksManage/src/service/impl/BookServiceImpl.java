package service.impl;

import java.util.ArrayList;

import dao.IBookDao;
import dao.impl.BookDaoImpl;
import entity.Book;
import service.IBookService;

//业务逻辑层
public class BookServiceImpl implements IBookService {
	IBookDao BookDao = new BookDaoImpl();
	
	//添加Book
	public boolean addBook(Book b) {
		return BookDao.addBook(b);
	}
	
	//查询所有Book
	public ArrayList<Book> getAllBooks(){
		return BookDao.getAllBooks();
	}
	
	//查询一个Book详细信息
	public Book getBooks(String id) {
		return BookDao.getBooks(id);
	}
	
	//删除Book信息 
	public boolean deleteBook(String id) {
		return BookDao.deleteBook(id);
	}
	
	//修改Book信息
	public boolean updateBook(Book id) {
		return BookDao.updateBook(id);
	}
	//按条件查询
	public ArrayList<Book> getBooksByCondition(String condition,String newData){
		return BookDao.getBooksByCondition(condition,newData);
	}
	
	@Override //查询总数据
	public int getTotalCount() {
		return BookDao.getTotalCount();
	}

	@Override //分页查询
	public ArrayList<Book> queryBooksByPage(int currentPage, int pageSize) {
		return BookDao.queryBooksByPage(currentPage, pageSize);
	}

	@Override //stu_user 查看已借图书
	public ArrayList<Book> getBorrowedBook(String uname) {
		return BookDao.getBorrowedBook(uname);
	}

	@Override
	public boolean borrowBook(String userName, String bookId) {
		
		return BookDao.borrowBook(userName,bookId);
	}

	@Override
	public boolean returnBook(String userName, String bookId) {
		
		return BookDao.returnBook(userName,bookId);
	}
	
	
	
	
}
