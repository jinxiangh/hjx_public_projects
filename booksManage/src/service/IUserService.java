package service;

import entity.User;

public interface IUserService {

	//登入
	int Login(User user);

	//注册
	int Adduser(User user);
	
	//删除stu_user用户
	boolean delStuUser(String userName);
	
	//修改密码   
	boolean updatePassword(User user);

}