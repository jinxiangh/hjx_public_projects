package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.User;
import service.IUserService;
import service.impl.UserServiceImpl;

@WebServlet(name="AddAdminServlet",urlPatterns = "/AddAdminServlet")
public class AddAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AddAdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
  		String name = request.getParameter("uname");
  		String pwd = request.getParameter("upwd");
  		String userType = "admin";
  		
  		
  		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
  		
  		User user = new User(name,pwd,userType);
  		IUserService UserService = new UserServiceImpl();
  		int result = UserService.Adduser(user);  // 成功返回 1      用户名已存在 2      系统异常 -1
  		
  		
  		if(result==0) {
  			out.write("1");
  			
	     }else if(result==1){
	    	 out.write("0");
	    	 
       	}else {
       		out.write("-1");
       		
       	}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
