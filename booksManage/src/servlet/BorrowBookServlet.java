package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.IBookService;
import service.impl.BookServiceImpl;

@WebServlet(name="BorrowBookServlet",urlPatterns = "/BorrowBookServlet")

public class BorrowBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public BorrowBookServlet() {
        super();
    }
    //借书
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userName = request.getParameter("userName");
		String bookId = request.getParameter("bookId");
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		
		IBookService bookService = new BookServiceImpl();
		if(bookService.borrowBook(userName, bookId)) {
			out.write("true");
		}else {
			out.write("false");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
