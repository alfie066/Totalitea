DROP DATABASE IF EXISTS totalitea_db;
CREATE DATABASE totalitea_db;
USE totalitea_db;



CREATE TABLE Product (
	Id INT PRIMARY KEY AUTO_INCREMENT,
	Name VARCHAR(50) NOT NULL,
	Description VARCHAR(50) NOT NULL,
	PriceInPence INT NOT NULL,
	CONSTRAINT ck_posPrice CHECK (PriceInPence > 0)
);


CREATE TABLE User (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL
);

CREATE TABLE Basket (
	Id INT PRIMARY KEY AUTO_INCREMENT,
	UserId INT NOT NULL,
	ProductId INT,
	Quantity INT NOT NULL,
	CONSTRAINT fk_productId FOREIGN KEY (ProductId) REFERENCES Product(Id),
	CONSTRAINT fk_userId FOREIGN KEY (UserId) REFERENCES User(Id),
	CONSTRAINT ck_quantity CHECK (Quantity >= 0)
);

DELIMITER /

CREATE PROCEDURE insertNewProduct(
	IN name VARCHAR(50),
	IN description VARCHAR(50),
	IN price INT,
	OUT keyval INT
)
MODIFIES SQL DATA
BEGIN
	INSERT INTO Product (Name, Description, PriceInPence) 
	    VALUES (name, description, price);
	SELECT last_insert_id() INTO keyval;
END;
/


CALL insertNewProduct("Espresso", "Strong black coffee", 250, @out);
CALL insertNewProduct("Americano", "Espresso with hot water", 280, @out);
CALL insertNewProduct("Latte", "Coffee with steamed milk", 320, @out);
CALL insertNewProduct("Cappuccino", "Coffee with milk foam", 320, @out);
CALL insertNewProduct("Flat White", "Smooth coffee with microfoam", 300, @out);
CALL insertNewProduct("Iced Coffee", "Chilled coffee with ice", 300, @out);

CALL insertNewProduct("English Breakfast Tea", "Classic black tea", 200, @out);
CALL insertNewProduct("Green Tea", "Light and refreshing tea", 220, @out);
CALL insertNewProduct("Earl Grey", "Black tea with bergamot", 220, @out);
CALL insertNewProduct("Iced Tea", "Cold brewed tea with ice", 280, @out);

SELECT @out/

CREATE PROCEDURE updateExistingProduct(
	IN nname VARCHAR(50),
	IN ndesc VARCHAR(50),
	IN nprice VARCHAR(50),
	IN keyval INT
)
MODIFIES SQL DATA
BEGIN
	UPDATE Product SET
		Name = nname,
		Description = ndesc,
		PriceInPence = nprice 
	WHERE Id = keyval;
END;
/

CREATE PROCEDURE insertItemIntoBasket(
	IN oid INT,
	IN pid INT,
	IN qty INT,
	OUT keyval INT
)
MODIFIES SQL DATA
BEGIN
	INSERT INTO Basket (OId, ProductId, Quantity) 
	    VALUES (oid, pid, qty);
	SELECT last_insert_id() INTO keyval;
	COMMIT;	
END;
/




CREATE PROCEDURE updateExistingBasketItem(
	IN oid INT,
	IN pid INT,
	IN QuantityChange INT
)
MODIFIES SQL DATA
BEGIN
	UPDATE Basket SET
		Quantity = Quantity + QuantityChange
	WHERE OId = oid AND ProductId = pid;
END;
/



CREATE PROCEDURE removeExistingBasketItem(
	IN oid INT,
	IN pid INT
)
MODIFIES SQL DATA
BEGIN
	DELETE FROM Basket 
	WHERE OId = oid AND ProductId = pid;
END;
/


CREATE PROCEDURE readFullProducts()
BEGIN
		SELECT * FROM Product;
END;
/		