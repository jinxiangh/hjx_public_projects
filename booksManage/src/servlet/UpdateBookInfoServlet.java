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

@WebServlet(name = "UpdateBookInfoServlet",urlPatterns = "/UpdateBookInfoServlet")
public class UpdateBookInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UpdateBookInfoServlet() {
        super();

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String flag = request.getParameter("flag");
		String id = request.getParameter("id");
//		System.out.println("flag:"+flag);
		IBookService bookService = new BookServiceImpl();
		if ("inp".equals(flag)) {
			Book book = bookService.getBooks(id);
			request.setAttribute("book",book);
			request.getRequestDispatcher( "updateBookInfo.jsp").forward(request, response);
			
		}else if(flag==null) {
			String bookId = request.getParameter("bookId");
			String bookName = request.getParameter("bookName");
			String publish = request.getParameter("publish");
			String price = request.getParameter("price");
			Book b = new Book();
			b.setBookid(bookId);
			b.setBookname(bookName);
			b.setPublish(publish);
			b.setPrice(price);
			
			boolean result = bookService.updateBook(b);
			response.setCharacterEncoding("utf-8");
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			if (result==true) {
				out.write("true");
				
			}else {
				out.write("false");
			}
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
