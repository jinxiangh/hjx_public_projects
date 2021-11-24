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

@WebServlet(name = "QueryBookByIdServlet",urlPatterns = "/QueryBookByIdServlet")

public class QueryBookByIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public QueryBookByIdServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String condition = request.getParameter("condition");
		String data = request.getParameter("data");
		IBookService BookService = new BookServiceImpl();
		ArrayList<Book> books = BookService.getBooksByCondition(condition, data);
		request.setAttribute("books", books);
		request.getRequestDispatcher( "getAllBooks.jsp").forward(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
