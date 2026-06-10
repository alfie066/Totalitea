DROP DATABASE IF EXISTS totalitea_db;
CREATE DATABASE totalitea_db;
USE totalitea_db;

CREATE TABLE Product (
    Id           INT PRIMARY KEY AUTO_INCREMENT,
    Name         VARCHAR(50) NOT NULL,
    Description  VARCHAR(1000) NOT NULL,
    PriceInPencePer100g INT NOT NULL,
    CONSTRAINT ck_posPrice CHECK (PriceInPencePer100g > 0)
);

CREATE TABLE User (
    Id          INT AUTO_INCREMENT PRIMARY KEY,
    Name        VARCHAR(100) NOT NULL,
    Email       VARCHAR(100) NOT NULL UNIQUE,
    Password    VARCHAR(100) NOT NULL,
    DOB         DATE NOT NULL,
    Address     VARCHAR(100) NOT NULL,
    CreditCard  VARCHAR(19),
    ExpiryDate  VARCHAR(5),
    CVV         VARCHAR(4)
);

CREATE TABLE Basket (
    Id     INT PRIMARY KEY AUTO_INCREMENT,
    UserId INT NOT NULL,
    CONSTRAINT fk_basket_userId FOREIGN KEY (UserId) REFERENCES User(Id)
);

CREATE TABLE BasketItem (
    Id                 INT PRIMARY KEY AUTO_INCREMENT,
    BasketId           INT NOT NULL,
    ProductId          INT NOT NULL,
    PriceInPencePer100g   INT NOT NULL,
    Grams              INT NOT NULL,
    Quantity           INT NOT NULL,
    CONSTRAINT fk_basketItem_basketId  FOREIGN KEY (BasketId)  REFERENCES Basket(Id),
    CONSTRAINT fk_basketItem_productId FOREIGN KEY (ProductId) REFERENCES Product(Id),
    CONSTRAINT ck_basketItem_quantity  CHECK (Quantity >= 1),
    CONSTRAINT ck_price_positive       CHECK (PriceInPencePer100g > 0),
    CONSTRAINT uq_basket_product       UNIQUE (BasketId, ProductId, Grams),
    CONSTRAINT ck_grams CHECK (Grams IN (100, 200, 300, 400, 500, 1000, 2000, 3000, 4000, 5000))
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
    IN pricePer100g INT,
    IN description VARCHAR(1000),
    OUT keyval     INT
)
BEGIN
    INSERT INTO Product (Name, Description, PriceInPencePer100g)
    VALUES (name, description, pricePer100g);

    SELECT LAST_INSERT_ID() INTO keyval;
END;
/

CREATE PROCEDURE updateExistingProduct(
    IN nname  VARCHAR(50),
    IN ndesc  VARCHAR(50),
    IN npricePer100g INT,
    IN keyval INT
)
BEGIN
    UPDATE Product
    SET Name = nname,
        Description = ndesc,
        PriceInPencePer100g = npricePer100g
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

    DECLARE pricePer100g INT;
    DECLARE finalPrice INT;

    SELECT PriceInPencePer100g INTO pricePer100g
    FROM Product
    WHERE Id = myProductId;

    SET finalPrice = (pricePer100g * myGrams) DIV 100;


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

        INSERT INTO BasketItem (
            BasketId,
            ProductId,
            priceInPencePer100g,
            Grams,
            Quantity
        )
        VALUES (
            myBasketId,
            myProductId,
            finalPrice,
            myGrams,
            myQty
        );

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


CALL insertNewProduct("Cold Brew", 300, "Slow-brewed coffee. Brew colour: deep dark brown. Recommended 8g per cup. Medium caffeine content (1.5 mg per gram).",  @out);

CALL insertNewProduct("Nitro Cold Brew", 300, "Nitrogen-infused smooth coffee. Brew colour: dark brown with creamy foam top. Recommended 8g per cup. High caffeine content (1.9 mg per gram).", @out);

CALL insertNewProduct("Mocha", 300, "Coffee with chocolate flavour. Brew colour: dark brown. Recommended 9g per cup. Medium caffeine content (1.7 mg per gram).", @out);

CALL insertNewProduct("Matcha Latte", 250, "Green tea-based latte. Brew colour: bright green. Recommended 6g per cup. Low caffeine content (0.7 mg per gram).", @out);


CALL insertNewProduct("Espresso", 250, "Strong black coffee. Brew colour: very dark brown (almost black). Recommended 7g per cup. High caffeine content (2.1 mg per gram).", @out);

CALL insertNewProduct("Americano", 280, "Espresso with hot water. Brew colour: dark brown. Recommended 7g per cup. Medium caffeine content (1.5 mg per gram).", @out);

CALL insertNewProduct("Latte", 320, "Coffee with steamed milk. Brew colour: creamy light brown. Recommended 8g per cup. Medium caffeine content (1.6 mg per gram).", @out);

CALL insertNewProduct("Cappuccino", 320, "Coffee with milk foam. Brew colour: medium brown with foam top. Recommended 8g per cup. Medium caffeine content (1.8 mg per gram).", @out);

CALL insertNewProduct("Flat White", 300, "Smooth coffee with microfoam. Brew colour: light brown. Recommended 8g per cup. Medium caffeine content (1.7 mg per gram).", @out);

CALL insertNewProduct("Iced Coffee", 300, "Chilled coffee with ice. Brew colour: dark brown. Recommended 8g per cup. Medium caffeine content (1.5 mg per gram).", @out);

CALL insertNewProduct("English Breakfast Tea", 200, "Classic black tea. Brew colour: golden brown. Caffeine content: 0.45 mg per gram.", @out);

CALL insertNewProduct("Green Tea", 220, "Light and refreshing tea. Brew colour: pale green. Caffeine content: 0.3 mg per gram.", @out);

CALL insertNewProduct("Earl Grey", 220, "Black tea with bergamot. Brew colour: dark brown. Caffeine content: 0.4 mg per gram.", @out);

CALL insertNewProduct("Iced Tea", 280, "Cold brewed tea with ice. Brew colour: light amber. Main use: refreshing and hydration. Naturally caffeine-free.", @out);

SELECT @out;