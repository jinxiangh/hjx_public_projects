package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.Book;
import service.IBookService;
import service.impl.BookServiceImpl;

@WebServlet(name="QueryUserBorrowedServlet",urlPatterns = "/QueryUserBorrowedServlet")
public class QueryUserBorrowedServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public QueryUserBorrowedServlet() {
        super();
       
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userName = request.getParameter("userName");
		String action = request.getParameter("action_");
		String bookId = request.getParameter("id");
		
		System.out.println("action:"+action);
		System.out.println("id:"+bookId);
		IBookService bookService = new BookServiceImpl();
		
		if("returnBook".equals(action)) {
			bookService.returnBook(userName, bookId);
			
		}
		ArrayList<Book> books = bookService.getBorrowedBook(userName);
		request.setAttribute("books", books);
		request.setAttribute("flag", "re");
		request.setAttribute("userName", userName);
		request.getRequestDispatcher( "getAllBooks.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
