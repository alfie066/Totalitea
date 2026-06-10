package model;

public class User {
	
	private int id;
	private String name;
	private String email;
	private String password;
	private String dob;
	private String address;
	private String creditCard;
	private String expiryDate;
	private String cvv;
	
	public User(String name, String email, String password, String dob, String address, String creditCard, String expiryDate, String cvv) {
		this.name = name;
		this.email = email;
		this.password = password;
		this.dob = dob;
		this.address = address;
		this.creditCard = creditCard;
		this.expiryDate = expiryDate;
		this.cvv = cvv;
	}
	
	public int getID() {
		return id;
	}

	public void setID(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getDob() {
		return dob;
	}

	public void setDob(String dob) {
		this.dob = dob;
	}
	
	public String getAddress() {
		return address;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}

	public String getCreditCard() {
		return creditCard;
	}

	public void setCreditCard(String creditCard) {
		this.creditCard = creditCard;
	}

	public String getExpiryDate() {
		return expiryDate;
	}

	public void setExpiryDate(String expiryDate) {
		this.expiryDate = expiryDate;
	}

	public String getCvv() {
		return cvv;
	}

	public void setCvv(String cvv) {
		this.cvv = cvv;
	}
}