package model;

public class User {
	
	private int id;
	private String email;
	private String password;
	private String address;
	
	public User(String email, String password, String address) {
		this.email = email;
		this.password = password;
		this.address = address;
		
	}
	
	public int getID() {
		return id;
	}

	public String getEmail() {
		return email;
		
	}
	
	public String getPassword() {
		return password;
	}
	
	public String getAddress() {
		return address;
	}
	
	public void setID(int id) {
		this.id = id;
	}

	public void setEmail(String email) {
		this.email = email;
		
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}

}
