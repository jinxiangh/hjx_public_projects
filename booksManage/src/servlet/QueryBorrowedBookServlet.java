package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.Book;
import service.IBookService;
import service.impl.BookServiceImpl;
@WebServlet(name = "QueryBorrowedBookServlet",urlPatterns = "/QueryBorrowedBookServlet")

public class QueryBorrowedBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public QueryBorrowedBookServlet() {
        super();
  
    }
    // stu_user 查看已借
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String uname = (String)session.getAttribute("uname");
		
		
		IBookService bookService = new BookServiceImpl();
		ArrayList<Book> books = bookService.getBorrowedBook(uname);
		request.setAttribute("books", books);
		request.getRequestDispatcher( "getAllBooks.jsp").forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
