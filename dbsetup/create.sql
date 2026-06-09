DROP DATABASE IF EXISTS totalitea_db;
CREATE DATABASE totalitea_db;
USE totalitea_db;

CREATE TABLE Product (
    Id           INT PRIMARY KEY AUTO_INCREMENT,
    Name         VARCHAR(50) NOT NULL,
    Description  VARCHAR(50) NOT NULL,
    PriceInPence INT NOT NULL,
    CONSTRAINT ck_posPrice CHECK (PriceInPence > 0)
);

CREATE TABLE User (
    Id       INT AUTO_INCREMENT PRIMARY KEY,
    Email    VARCHAR(100) NOT NULL UNIQUE,
    Password VARCHAR(100) NOT NULL,
    Address  VARCHAR(100) NOT NULL
);

CREATE TABLE Basket (
    Id     INT PRIMARY KEY AUTO_INCREMENT,
    UserId INT NOT NULL,
    CONSTRAINT fk_basket_userId FOREIGN KEY (UserId) REFERENCES User(Id)
);

CREATE TABLE BasketItem (
    Id        INT PRIMARY KEY AUTO_INCREMENT,
    BasketId  INT NOT NULL,
    ProductId INT NOT NULL,
    Grams	  INT NOT NULL,
    Quantity  INT NOT NULL,
    CONSTRAINT fk_basketItem_basketId  FOREIGN KEY (BasketId)  REFERENCES Basket(Id),
    CONSTRAINT fk_basketItem_productId FOREIGN KEY (ProductId) REFERENCES Product(Id),
    CONSTRAINT ck_basketItem_quantity  CHECK (Quantity >= 1),
    CONSTRAINT uq_basket_product       UNIQUE (BasketId, ProductId, Grams)
);

CREATE TABLE Orders (
    Id         INT PRIMARY KEY AUTO_INCREMENT,
    UserId     INT NOT NULL,
    TotalPrice DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_orders_userId FOREIGN KEY (UserId) REFERENCES User(Id)
);

CREATE TABLE OrderItem (
    Id        INT PRIMARY KEY AUTO_INCREMENT,
    OrderId   INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity  INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_orderItem_orderId   FOREIGN KEY (OrderId)   REFERENCES `Orders`(Id),
    CONSTRAINT fk_orderItem_productId FOREIGN KEY (ProductId) REFERENCES Product(Id),
    CONSTRAINT ck_orderItem_quantity  CHECK (Quantity >= 1)
);

DELIMITER /

CREATE PROCEDURE insertNewProduct(
    IN name        VARCHAR(50),
    IN description VARCHAR(50),
    IN price       INT,
    OUT keyval     INT
)
MODIFIES SQL DATA
BEGIN
    INSERT INTO Product (Name, Description, PriceInPence)
        VALUES (name, description, price);
    SELECT last_insert_id() INTO keyval;
END;
/

CREATE PROCEDURE updateExistingProduct(
    IN nname  VARCHAR(50),
    IN ndesc  VARCHAR(50),
    IN nprice INT,
    IN keyval INT
)
MODIFIES SQL DATA
BEGIN
    UPDATE Product SET
        Name         = nname,
        Description  = ndesc,
        PriceInPence = nprice
    WHERE Id = keyval;
END;
/

CREATE PROCEDURE insertItemIntoBasket(
    IN myBasketId INT,
    IN myProductId INT,
    IN myGrams INT,
    IN myQty INT,
    OUT myKeyval INT
)

MODIFIES SQL DATA
BEGIN


    IF EXISTS (
        SELECT 1 
        FROM BasketItem 
        WHERE BasketId = myBasketId 
          AND ProductId = myProductId 
          AND Grams = myGrams
    ) THEN


        UPDATE BasketItem
        SET Quantity = Quantity + myQty
        WHERE BasketId = myBasketId 
          AND ProductId = myProductId 
          AND Grams = myGrams;

        SET myKeyval = 0;

    ELSE

        INSERT INTO BasketItem (BasketId, ProductId, Grams, Quantity)
        VALUES (myBasketId, myProductId, myGrams, myQty);

        SELECT LAST_INSERT_ID() INTO myKeyval;

    END IF;

END;

/

CREATE PROCEDURE updateExistingBasketItem(
    IN myBasketId INT,
    IN myProductId INT,
    IN myGrams INT,
    IN myQuantityChange INT
)
BEGIN
    UPDATE BasketItem
    SET Quantity = Quantity + myQuantityChange
    WHERE BasketId = myBasketId 
      AND ProductId = myProductId 
      AND Grams = myGrams;

END;
/

CREATE PROCEDURE removeExistingBasketItem(
    IN myBasketId INT,
    IN myProductId INT,
    IN myGrams INT
)
BEGIN
    DELETE FROM BasketItem
    WHERE BasketId = myBasketId 
      AND ProductId = myProductId 
      AND Grams = myGrams;

END;
/

CREATE PROCEDURE readFullProducts()
BEGIN
    SELECT * FROM Product;
END;
/

DELIMITER ;

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

SELECT @out;