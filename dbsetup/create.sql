DROP DATABASE IF EXISTS totalitea_db;
CREATE DATABASE totalitea_db;
USE totalitea_db;

CREATE TABLE Product (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL,
    Description VARCHAR(1000) NOT NULL,
    PriceInPencePer100g INT NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT ck_posPrice CHECK (PriceInPencePer100g > 0)
);


CREATE TABLE User (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Password VARCHAR(100) NOT NULL,
    DOB DATE NOT NULL,
    Address VARCHAR(100) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE Orders (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    UserId INT NOT NULL,
    Status VARCHAR(20) DEFAULT 'OPEN',
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PlacedAt TIMESTAMP NULL,

    CONSTRAINT fk_orders_userId FOREIGN KEY (UserId) REFERENCES User(Id),
    CONSTRAINT ck_status CHECK (Status IN ('OPEN', 'PAID', 'DELIVERED', 'CANCELLED'))

);

CREATE TABLE OrderItem (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    OrderId INT NOT NULL,
    ProductId INT NOT NULL,
    PriceInPencePer100g INT NOT NULL,
    Grams INT NOT NULL,
    Quantity INT NOT NULL,

    CONSTRAINT fk_orderItem_orderId FOREIGN KEY (OrderId) REFERENCES Orders(Id),
    CONSTRAINT fk_orderItem_productId FOREIGN KEY (ProductId) REFERENCES Product(Id),

    CONSTRAINT ck_grams CHECK (Grams IN (100,200,300,400,500,1000,2000,3000,4000,5000)),
    CONSTRAINT ck_quantity CHECK (Quantity >= 1),

    CONSTRAINT uq_order UNIQUE (OrderId, ProductId, Grams) 
);

CREATE TABLE Payment (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    OrderId INT NOT NULL,
    NameOnCard VARCHAR(50),
    CardNumber VARCHAR(19),
    ExpiryDate DATE,
    CVV VARCHAR(10),

    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_payment_order FOREIGN KEY (OrderId) REFERENCES Orders(Id)
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
    IN ndesc  VARCHAR(1000),
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

CREATE PROCEDURE insertItemIntoOrder(
    IN myUserId INT,
    IN myProductId INT,
    IN myGrams INT,
    IN myQty INT,
    OUT myKeyval INT
)
BEGIN
    DECLARE orderId INT;
    DECLARE pricePer100g INT;

    -- Step 1: Get latest OPEN order
    SELECT Id INTO orderId
    FROM Orders
    WHERE UserId = myUserId
      AND Status = 'OPEN'
    ORDER BY CreatedAt DESC
    LIMIT 1;

    -- Step 2: HARD re-check (this is the critical fix)
    IF orderId IS NOT NULL THEN
        IF NOT EXISTS (
            SELECT 1 FROM Orders 
            WHERE Id = orderId AND Status = 'OPEN'
        ) THEN
            SET orderId = NULL;
        END IF;
    END IF;

    -- Step 3: Create new order if needed
    IF orderId IS NULL THEN
        INSERT INTO Orders (UserId, Status)
        VALUES (myUserId, 'OPEN');

        SET orderId = LAST_INSERT_ID();
    END IF;

    -- Step 4: Get price
    SELECT PriceInPencePer100g INTO pricePer100g
    FROM Product
    WHERE Id = myProductId;

    -- Step 5: Atomic insert/update (NO EXISTS anymore)
    INSERT INTO OrderItem (
        OrderId,
        ProductId,
        PriceInPencePer100g,
        Grams,
        Quantity
    )
    VALUES (
        orderId,
        myProductId,
        pricePer100g,
        myGrams,
        myQty
    )
    ON DUPLICATE KEY UPDATE
        Quantity = Quantity + myQty;

    SET myKeyval = LAST_INSERT_ID();

END;

/

CREATE PROCEDURE removeOrderItem(
    IN myOrderId INT,
    IN myProductId INT,
    IN myGrams INT
)
BEGIN
    DELETE FROM OrderItem
    WHERE OrderId = myOrderId
      AND ProductId = myProductId
      AND Grams = myGrams;
END;
/


DELIMITER ;


CALL insertNewProduct("Cold Brew", 180, "Slow-brewed coffee. Brew colour: deep dark brown. Recommended 8g per cup. Medium caffeine content (1.5 mg per gram).",  @out);

CALL insertNewProduct("Nitro Cold Brew", 200, "Nitrogen-infused smooth coffee. Brew colour: dark brown with creamy foam top. Recommended 8g per cup. High caffeine content (1.9 mg per gram).", @out);

CALL insertNewProduct("Mocha", 190, "Coffee with chocolate flavour. Brew colour: dark brown. Recommended 9g per cup. Medium caffeine content (1.7 mg per gram).", @out);

CALL insertNewProduct("Matcha Latte", 170, "Green tea-based latte. Brew colour: bright green. Recommended 6g per cup. Low caffeine content (0.7 mg per gram).", @out);


CALL insertNewProduct("Espresso", 170, "Strong black coffee. Brew colour: very dark brown (almost black). Recommended 7g per cup. High caffeine content (2.1 mg per gram).", @out);

CALL insertNewProduct("Americano", 180, "Espresso with hot water. Brew colour: dark brown. Recommended 7g per cup. Medium caffeine content (1.5 mg per gram).", @out);

CALL insertNewProduct("Latte", 220, "Coffee with steamed milk. Brew colour: creamy light brown. Recommended 8g per cup. Medium caffeine content (1.6 mg per gram).", @out);

CALL insertNewProduct("Cappuccino", 220, "Coffee with milk foam. Brew colour: medium brown with foam top. Recommended 8g per cup. Medium caffeine content (1.8 mg per gram).", @out);

CALL insertNewProduct("Flat White", 190, "Smooth coffee with microfoam. Brew colour: light brown. Recommended 8g per cup. Medium caffeine content (1.7 mg per gram).", @out);

CALL insertNewProduct("Iced Coffee", 190, "Chilled coffee with ice. Brew colour: dark brown. Recommended 8g per cup. Medium caffeine content (1.5 mg per gram).", @out);

CALL insertNewProduct("English Breakfast Tea", 120, "Classic black tea. Brew colour: golden brown. Caffeine content: 0.45 mg per gram.", @out);

CALL insertNewProduct("Green Tea", 130, "Light and refreshing tea. Brew colour: pale green. Caffeine content: 0.3 mg per gram.", @out);

CALL insertNewProduct("Earl Grey", 130, "Black tea with bergamot. Brew colour: dark brown. Caffeine content: 0.4 mg per gram.", @out);

CALL insertNewProduct("Iced Tea", 150, "Cold brewed tea with ice. Brew colour: light amber. Main use: refreshing and hydration. Naturally caffeine-free.", @out);
SELECT @out;