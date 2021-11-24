package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.Book;
import service.IBookService;
import service.impl.BookServiceImpl;


/**
 * Servlet implementation class addBookServlet
 */
@WebServlet(name = "AddBookServlet",urlPatterns = "/AddBookServlet")

public class AddBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AddBookServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		String bookid = request.getParameter("bookid");
		String bookname = request.getParameter("bookname");
		String publish = request.getParameter("publish");
		String price = request.getParameter("price");
		
		Book b  = new Book();
		b.setBookid(bookid);
		b.setBookname(bookname);
		b.setPrice(price);
		b.setPublish(publish);
		IBookService bookService = new BookServiceImpl();
		
		
		if(bookService.addBook(b)) {
			out.write("true");
		}else {
			out.write("false");
		}
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
