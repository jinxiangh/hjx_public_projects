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

@WebServlet(name="LoginServlet",urlPatterns = "/LoginServlet")
public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = -8552683134862056264L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String userType = request.getParameter("userType");//获取login.html 传过来的数据
		String name = request.getParameter("uname");
		String pwd = request.getParameter("upwd");
		
		User user = new User(name,pwd,userType);
		HttpSession session = request.getSession();
		
		PrintWriter out = response.getWriter();
		IUserService UserService = new UserServiceImpl();
		
		int result = UserService.Login(user);//1 登入成功 0：用户名或密码错误  -1系统错误
		if (result==1){
			//只有登入成功，session中才保存uname/upwd/utype
			session.setAttribute("uname", name);
			session.setAttribute("upwd", pwd);
			session.setAttribute("utype", userType);
			session.setMaxInactiveInterval(300); //最大非活动时效5min
			out.write("1");
			
		}else if(result==0){
			out.write("0");
		}else{
			out.write("-1");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
