package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.IBookService;
import service.impl.BookServiceImpl;


@WebServlet("/DelBookServlet")
public class DelBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DelBookServlet() {
        super();
        
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		IBookService bookservic = new BookServiceImpl();
		boolean result = bookservic.deleteBook(id);
		
		if(result==true) {
			request.getRequestDispatcher( "QueryBookByPageServlet").forward(request, response);
		}else {
			response.setCharacterEncoding("utf-8");
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print("删除失败！");
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
