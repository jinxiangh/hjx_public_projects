package dao;

import entity.User;

public interface IUserDao {

	//登入 （查）
	int Login(User user);

	//注册  (查+增)
	int Adduser(User user);
	
	//删除stu_user用户
	boolean delStuUser(String userName);
	
	//修改密码   （改）
	boolean updatePassword(User user);
	
}