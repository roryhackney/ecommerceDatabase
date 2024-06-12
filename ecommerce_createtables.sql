DROP DATABASE IF EXISTS DRAGONS_HOARD_SHOP;

CREATE DATABASE DRAGONS_HOARD_SHOP;

USE DRAGONS_HOARD_SHOP;

CREATE TABLE TAG (
    TagName VARCHAR(50) PRIMARY KEY
);

CREATE TABLE CRYSTAL (
    ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL,
    Description TEXT NOT NULL,
    IsSynthetic BOOL NOT NULL,
    SourceName VARCHAR(50) NOT NULL,
    SupplierName VARCHAR(50) NOT NULL
);

CREATE TABLE STATE (
    StateCode CHAR(2) PRIMARY KEY,
    CountryCode CHAR(2) NOT NULL,
    StateName VARCHAR(50) NOT NULL
);

CREATE TABLE ADDRESS (
    AddressID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    StateCode CHAR(2) NOT NULL,
    AddressName VARCHAR(50) NOT NULL,
    CityName VARCHAR(50) NOT NULL,
    ZipID VARCHAR(10) NOT NULL,
    CountryCode CHAR(2) NOT NULL,
    CONSTRAINT AddressStateFK FOREIGN KEY (StateCode) REFERENCES STATE(StateCode)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE WAREHOUSE (
    WarehouseName VARCHAR(50) PRIMARY KEY,
    AddressID INT UNSIGNED UNIQUE NOT NULL,
    CONSTRAINT WarehouseFKAddress FOREIGN KEY (AddressID) REFERENCES ADDRESS(AddressID)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

-- TODO: Enable multiple crystals in product?
CREATE TABLE PRODUCT (
    SKU_ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    CrystalID INT UNSIGNED NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Description TEXT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    WidthSize DECIMAL(5, 2) NOT NULL,
    HeightSize DECIMAL(5, 2) NOT NULL,
    Weight DECIMAL(5, 2) NOT NULL,
    PackCount INT NOT NULL,
    CONSTRAINT ProductCrystalFK FOREIGN KEY (CrystalID) REFERENCES CRYSTAL(ID)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE TRANSACTION (
    TransID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT UNSIGNED,
    ShippingAddress INT UNSIGNED,
    OrderDate DATE NOT NULL,
    ShipDate DATE,
    DeliverDate DATE,
    SubtotalPrice DECIMAL(10, 2) NOT NULL,
    TaxPrice DECIMAL(10, 2) NOT NULL,
    TotalPrice DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ShippingAddress) REFERENCES ADDRESS(AddressID)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE PRODUCT_TRANSACTION (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    SKU_ID INT UNSIGNED,
    TransID INT UNSIGNED,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (SKU_ID) REFERENCES PRODUCT(SKU_ID)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (TransID) REFERENCES TRANSACTION(TransID)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE PRODUCT_ORDER (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT UNSIGNED NOT NULL,
    WarehouseName VARCHAR(50) NOT NULL,
    OrderDate DATE NOT NULL,
    ExpectedDeliveryDate DATE NOT NULL,
    DeliveryDate DATE,
    TotalPrice DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES PRODUCT(SKU_ID)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (WarehouseName) REFERENCES WAREHOUSE(WarehouseName)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE COLOR (
    ColorName VARCHAR(50) PRIMARY KEY,
    HexCode CHAR(7) UNIQUE NOT NULL,
        -- first char should be #, last 6 should be letters or numbers 
    CONSTRAINT ValidHexCode CHECK (HexCode REGEXP "#[0-9A-Fa-f]{6}")
);

CREATE TABLE CRYSTAL_COLOR (
    ColorName VARCHAR(50),
    CrystalID INT UNSIGNED,
    CONSTRAINT CrystalColorPK PRIMARY KEY (ColorName, CrystalID),
    CONSTRAINT CrystalColorFKColor FOREIGN KEY (ColorName) REFERENCES COLOR(ColorName)
	ON UPDATE CASCADE ON DELETE RESTRICT,	-- color applied to crystals should not be deleted, can be updated
    CONSTRAINT CrystalColorFKCrystal FOREIGN KEY (CrystalID) REFERENCES CRYSTAL(ID)
    ON UPDATE CASCADE ON DELETE CASCADE -- if you delete a crystal, also delete its colors
);

CREATE TABLE PROPERTY (
    PropertyName VARCHAR(50) PRIMARY KEY
);

CREATE TABLE CRYSTAL_PROPERTY (
    PropertyName VARCHAR(50),
    CrystalID INT UNSIGNED,
    CONSTRAINT CrystalPropPK PRIMARY KEY (PropertyName, CrystalID),
    CONSTRAINT CrystalPropFKProp FOREIGN KEY (PropertyName) REFERENCES PROPERTY(PropertyName)
        ON UPDATE CASCADE ON DELETE CASCADE, -- if we no longer track a property, remove it from all crystals
    CONSTRAINT CrystalPropFKCrystal	FOREIGN KEY (CrystalID) REFERENCES CRYSTAL(ID)
        ON UPDATE CASCADE ON DELETE CASCADE -- if we stop carrying a crystal, stop tracking its properties
);

-- COLORS TESTING!
-- INSERT INTO COLOR VALUES ("Blue", "#ZF0921"); -- letter after F
-- INSERT INTO COLOR VALUES ("Red", "#FF921"); -- too few
-- INSERT INTO COLOR VALUES ("Green", "#FF09921"); -- too many
-- INSERT INTO COLOR VALUES ("Yellow", "0FF921"); -- doesn't start with #

-- should work, any combination of # and 6 numbers/letters of any case
-- INSERT INTO COLOR VALUES ("Pink", "#091AFe");

CREATE TABLE REVIEW (
    ReviewID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    SKU_ID INT UNSIGNED NOT NULL,
    CONSTRAINT ReviewFK_SKU FOREIGN KEY (SKU_ID) REFERENCES PRODUCT(SKU_ID)
    ON UPDATE CASCADE ON DELETE CASCADE,	-- if we stop carrying a product delete its reviews
    RatingNumber TINYINT UNSIGNED NOT NULL,
    CONSTRAINT RatingInRange CHECK (RatingNumber > 0 AND RatingNumber < 6),
    TitleName VARCHAR(75),
    Description TEXT
);

CREATE TABLE REVIEW_TAGS (
    ReviewID INT UNSIGNED,
    TagName VARCHAR(50),
    CONSTRAINT ReviewTagPK PRIMARY KEY (ReviewID, TagName),
    CONSTRAINT ReviewTagsFKReview FOREIGN KEY (ReviewID) REFERENCES REVIEW(ReviewID)
        ON UPDATE CASCADE ON DELETE CASCADE, -- delete tags of deleted review
    CONSTRAINT ReviewTagsFKTag FOREIGN KEY (TagName) REFERENCES TAG(TagName)
        ON UPDATE CASCADE ON DELETE CASCADE -- delete all associations for deleted tag
);

CREATE TABLE CUSTOMER (
    CustomerID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    EmailURL VARCHAR(50) UNIQUE NOT NULL,
    CONSTRAINT ValidEmail CHECK (EmailURL LIKE "%@%.%"),
    PhoneNumber CHAR(10),
    CONSTRAINT ValidPhone CHECK (PhoneNumber REGEXP "[0-9]{10}"),
    AddressID INT UNSIGNED NOT NULL,
    CONSTRAINT CustomerFKAddress FOREIGN KEY (AddressID) REFERENCES ADDRESS(AddressID)
	    ON UPDATE CASCADE ON DELETE RESTRICT, -- must update customer address, cannot be deleted if associated with customer
    CardNumber CHAR(16),
    CardType ENUM("MasterCard", "Visa")
);
-- INSERT INTO ADDRESS (AddressID) VALUES (1) -- setup
-- INSERT INTO CUSTOMER (FirstName, LastName, EmailURL, AddressID) VALUES ('A', 'A', 'bees', 1); -- should fail, invalid email
-- INSERT INTO CUSTOMER (FirstName, LastName, EmailURL, AddressID) VALUES ('A', 'A', 'bee@.s', 1); -- should fail, invalid email
-- INSERT INTO CUSTOMER (FirstName, LastName, EmailURL, AddressID) VALUES ('A', 'A', '@e.s', 1); -- should fail, invalid email
-- INSERT INTO CUSTOMER (FirstName, LastName, EmailURL, AddressID) VALUES ('A', 'A', 'bee@s.', 1); -- should fail, invalid email
-- INSERT INTO CUSTOMER (FirstName, LastName, EmailURL, AddressID) VALUES ('A', 'A', 'be@e.s', 1); -- should succeed
-- INSERT INTO CUSTOMER (FirstName, LastName, EmailURL, PhoneNumber, AddressID) VALUES ('A', 'A', 'be@e.s', 123456789,  1); -- should fail, invalid phone
-- INSERT INTO CUSTOMER (FirstName, LastName, EmailURL, PhoneNumber, AddressID) VALUES ('A', 'A', 'be@e.s', 12345678901,  1); -- should fail, invalid phone
-- INSERT INTO CUSTOMER (FirstName, LastName, EmailURL, PhoneNumber, AddressID) VALUES ('A', 'A', 'be@e.s', A123456789,  1); -- should fail, invalid phone
-- INSERT INTO CUSTOMER (FirstName, LastName, EmailURL, PhoneNumber, AddressID) VALUES ('A', 'A', 'be@e.s', 1234567890,  1); -- should succeed

CREATE TABLE REWARDS_MEMBER (
    CustomerID INT UNSIGNED PRIMARY KEY,
    CONSTRAINT RewardsFKCustomer FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID)
    ON UPDATE CASCADE ON DELETE CASCADE,
    UserName VARCHAR(50) UNIQUE NOT NULL,
    UserPassword VARCHAR(50) NOT NULL,
    -- Password is 8+ chars, includes number, symbol, uppercase letter
    CONSTRAINT		Password8Chars		CHECK (LENGTH(UserPassword) > 7),
    CONSTRAINT		PasswordHasNumber	CHECK (UserPassword REGEXP "[0-9]"),
    CONSTRAINT 		PasswordHasSymbol	CHECK (UserPassword REGEXP "[! | @ | # | % | & | * | ? | + | -]"),
    CONSTRAINT 		PasswordHasCapital	CHECK (UserPassword REGEXP "[A-Z]"),
    IsSubscribed	BOOL NOT NULL DEFAULT FALSE,
    RewardsNumber	INT UNSIGNED UNIQUE NOT NULL AUTO_INCREMENT
);

CREATE TABLE INVENTORY (
    SKU_ID INT UNSIGNED,
    WarehouseName VARCHAR(50),
    CONSTRAINT InventoryPK PRIMARY KEY (SKU_ID, WarehouseName),
    CONSTRAINT InventoryFKSKU FOREIGN KEY (SKU_ID) REFERENCES PRODUCT(SKU_ID)
	ON UPDATE CASCADE ON DELETE RESTRICT, -- must remove from inventory before deleting product
    CONSTRAINT FOREIGN KEY (WarehouseName) REFERENCES WAREHOUSE(WarehouseName)
	ON UPDATE CASCADE ON DELETE RESTRICT, -- must remove products from warehouse before deleting/selling warehouse
    Count INT UNSIGNED NOT NULL DEFAULT 0
);

CREATE TABLE WAREHOUSE_ORDER (
    OrderID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    OrderDate DATE NOT NULL,
    WarehouseName VARCHAR(50),
    CONSTRAINT OrderFKWarehouse FOREIGN KEY (WarehouseName) REFERENCES WAREHOUSE(WarehouseName)
	ON UPDATE CASCADE ON DELETE SET NULL, -- if a warehouse is deleted/sold, its past orders should be saved under null
    ExpectDelivDate DATE NOT NULL,
    DeliveryDate DATE
);

CREATE TABLE ORDERED_PRODUCT (
    OrderedProdID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    OrderID INT UNSIGNED NOT NULL,
    SKU_ID INT UNSIGNED,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    CONSTRAINT PositiveUnitPrice CHECK (UnitPrice > 0),
    CONSTRAINT OrdProdFKOrder FOREIGN KEY (OrderID) REFERENCES WAREHOUSE_ORDER(OrderID)
	ON UPDATE CASCADE ON DELETE CASCADE, -- if an order is cancelled remove the products from the order
    CONSTRAINT OrdProdFKSKU FOREIGN KEY (SKU_ID) REFERENCES PRODUCT(SKU_ID)
	ON UPDATE CASCADE ON DELETE SET NULL -- if a product is deleted, retain past order info with null SKU
);