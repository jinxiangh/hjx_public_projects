package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.Book;
import service.IBookService;
import service.IUserService;
import service.impl.BookServiceImpl;
import service.impl.UserServiceImpl;

@WebServlet("/DelStuUserServlet")
public class DelStuUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DelStuUserServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userName = request.getParameter("userName");

		PrintWriter out = response.getWriter();
		
		IUserService UserService = new UserServiceImpl();
		IBookService bookService = new BookServiceImpl();
		
		//先查 图书 判断
		ArrayList<Book> books = bookService.getBorrowedBook(userName);
		int size = books.size();

		if(size>0) {
			out.write("false");
		}else {
			//删除用户
			boolean result = UserService.delStuUser(userName);
			System.out.println(result);
			if(result) 
				out.write("true");
			else
				out.write("-1");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
