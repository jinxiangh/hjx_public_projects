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

@WebFilter(filterName = "/SessionFilter",urlPatterns = {"/*"})
public class SessionFilter implements Filter {

    public SessionFilter() {
    	
    }

	public void destroy() {

	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		request.setCharacterEncoding("utf-8");
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		HttpSession session = req.getSession(true);
		
		String request_uri = req.getRequestURI();
		String ctxPath = req.getContextPath();
		String uri = request_uri.substring(ctxPath.length());//获取地址
		
		if(uri.equals("/login.html")|| uri.equals("/LoginServlet")||uri.equals("/AddStuUserServlet")
				||uri.endsWith(".css")||uri.endsWith(".js")||uri.endsWith(".jpg")||uri.endsWith(".png")) //排除登入、注册页、静态资源
			chain.doFilter(request, response);
		else {
			if(null!=session.getAttribute("uname") && ""!=session.getAttribute("uname")) {
				chain.doFilter(request, response);
			}
			else {
				resp.setHeader("P3P","CP=CAO PSA OUR");
				resp.sendRedirect("login.html");
			}
		}

	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
