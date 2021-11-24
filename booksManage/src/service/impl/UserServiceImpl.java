package service.impl;

import dao.IUserDao;
import dao.impl.UserDaoImpl;
import entity.User;
import service.IUserService;

//业务逻辑层：逻辑性的增删改查（ 增：查+增）  ，对dao层进行的组装
public class UserServiceImpl implements IUserService {
	IUserDao UserDao = new UserDaoImpl();
	
	//登入
	public int Login(User user) {
		return UserDao.Login(user);
	}
	
	//注册
	public int Adduser(User user) {
		return UserDao.Adduser(user);
	}
	//修改密码   
	public boolean updatePassword(User user) {
		return UserDao.updatePassword(user);
	}

	//删除stu_user用户
	public boolean delStuUser(String userName) {
		// TODO 自动生成的方法存根
		return UserDao.delStuUser(userName);
	}
	
}

