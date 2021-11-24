package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name="ExitLoginServlet",urlPatterns = "/ExitLoginServlet")

public class ExitLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ExitLoginServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		HttpSession session = request.getSession();
		session.removeAttribute("uname");
		session.removeAttribute("upwd");
		PrintWriter out = response.getWriter();	
		out.print("<html><body><center><br><br><br><br><h2>用户已注销</h2><br><h3>3秒后跳转至登入界面</h3></center></body></html>");
		response.setHeader("refresh", "3;url=login.html");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
