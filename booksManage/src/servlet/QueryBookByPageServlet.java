package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.Book;
import entity.Book;
import entity.Page;
import service.IBookService;
import service.IBookService;
import service.impl.BookServiceImpl;
import service.impl.BookServiceImpl;
@WebServlet(name="QueryBookByPageServlet",urlPatterns = "/QueryBookByPageServlet")

public class QueryBookByPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public QueryBookByPageServlet() {
        super();

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cPage = request.getParameter("currentPage")  ;//当前页数
		String pSize = request.getParameter("pageSize")  ;//当前页数
		if(cPage == null) cPage = "1" ;
		if(pSize == null) pSize = "10" ;
		int currentPage = Integer.parseInt( cPage );
		int pageSize =  Integer.parseInt( pSize );
		IBookService bookService = new BookServiceImpl();
		int count = bookService.getTotalCount() ;//数据总数
		//将分页所需的5个字段（其中有1个自动计算，因此实际只需要组装4个即可），组装到page对象之中
		Page page = new Page();
		page.setTotalCount(count);
		page.setCurrentPage(currentPage);
		
		page.setPageSize(pageSize);
		ArrayList<Book>  books  = bookService.queryBooksByPage(currentPage, pageSize) ;

		page.setBooks(books);
		request.setAttribute("p", page);
		request.getRequestDispatcher("queryBooksByPage.jsp").forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
