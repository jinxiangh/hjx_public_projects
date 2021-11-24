package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.User;
import service.IUserService;
import service.impl.UserServiceImpl;


@WebServlet(name="UpdatePwdServlet",urlPatterns = "/UpdatePwdServlet")
public class UpdatePwdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		String uname = (String)session.getAttribute("uname");
		String utype = (String)session.getAttribute("utype");
		String oldPwd = request.getParameter("oldPwd");
		String newPwd = request.getParameter("newPwd");
		
		User login = new User(uname,oldPwd,utype);
		IUserService UserService = new UserServiceImpl();
		
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if(1==UserService.Login(login)) { //1 登入成功 0：用户名或密码错误  -1系统错误
			User user = new User(uname,newPwd,utype);
			
			if(UserService.updatePassword(user)) {
				out.write("true");
			}else {
				out.write("false");
			}
		}else {
			out.write("原密码错误！");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}

