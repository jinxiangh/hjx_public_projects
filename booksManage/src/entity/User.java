package entity;

public class User {
	private String name;
	private String pwd;
	private String type;
	

	public User() {	
	}

	public User(String name, String pwd,String type) {
		this.name = name;
		this.pwd = pwd;
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}


	
}
