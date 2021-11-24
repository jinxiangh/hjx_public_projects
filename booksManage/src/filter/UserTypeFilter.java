package filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(filterName = "/UserTypeFilter",urlPatterns = {"/*"})
public class UserTypeFilter implements Filter {

    public UserTypeFilter() {

    }

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		HttpSession session = req.getSession(true);
		
		String request_uri = req.getRequestURI();
		String ctxPath = req.getContextPath();
		String uri = request_uri.substring(ctxPath.length());//获取地址
		String utype = (String)session.getAttribute("utype");//获取用户身份
//		System.out.println("utype:"+utype);
		
		if(uri.equals("/login.html")|| uri.equals("/LoginServlet")||uri.equals("/AddAdminServlet")
				||uri.endsWith(".css")||uri.endsWith(".js")||uri.endsWith(".jpg")||uri.endsWith(".png")) //排除登入、注册页、静态资源
			chain.doFilter(request, response);
		else {
			
			if("admin".equals(utype)) {
				
				if(uri.contains("QueryBorrowedBookServlet")||uri.contains("viewBorrowedBook.jsp"))
					resp.sendRedirect("main.jsp");
				else 
					chain.doFilter(request, response);
			}else if("stu_user".equals(utype)){
				if(uri.contains("main.jsp")||uri.contains("QueryBorrowedBookServlet")
						||uri.contains("viewBorrowedBook.jsp")||uri.contains("queryBookById.jsp")
						||uri.contains("QueryBookByIdServlet")||uri.contains("ExitLoginServlet")
						||uri.contains("updatePwd.jsp")||uri.contains("UpdatePwdServlet")
						||uri.contains("ShowAllBooksServlet")||uri.contains("getAllBooks.jsp"))
					chain.doFilter(request, response);
				else {
					resp.sendRedirect("main.jsp");
				}
			}else {
				System.out.println("err");
				resp.sendRedirect("login.html");
			}
			
		}
	}


	public void init(FilterConfig fConfig) throws ServletException {
	
	}

}
