-- Drop existing stored procedures if they exist
DROP PROCEDURE IF EXISTS AddNewProduct;
DROP PROCEDURE IF EXISTS ModifyInventoryAmount;

-- Drop existing trigger if it exists
DROP TRIGGER IF EXISTS DeleteProductFromInventory;

-- Stored Procedure to Add a New Product
DELIMITER //

CREATE PROCEDURE AddNewProduct(
    IN p_CrystalID INT UNSIGNED,
    IN p_Name VARCHAR(50),
    IN p_Description TEXT,
    IN p_Price DECIMAL(10, 2),
    IN p_WidthSize DECIMAL(5, 2),
    IN p_HeightSize DECIMAL(5, 2),
    IN p_Weight DECIMAL(5, 2),
    IN p_PackCount INT
)
BEGIN
    INSERT INTO PRODUCT (CrystalID, Name, Description, Price, WidthSize, HeightSize, Weight, PackCount)
    VALUES (p_CrystalID, p_Name, p_Description, p_Price, p_WidthSize, p_HeightSize, p_Weight, p_PackCount);
END //

DELIMITER ;

-- Stored Procedure to Modify Inventory Amount
DELIMITER //

CREATE PROCEDURE ModifyInventoryAmount(
    IN p_SKU_ID INT UNSIGNED,
    IN p_Count INT,
    IN p_WarehouseName VARCHAR(50)
)
BEGIN
    UPDATE INVENTORY
    SET Count = p_Count
    WHERE SKU_ID = p_SKU_ID AND WarehouseName = p_WarehouseName;
END //

DELIMITER ;

-- Trigger to Delete Product from Inventory
DELIMITER //

CREATE TRIGGER DeleteProductFromInventory
    AFTER DELETE ON PRODUCT
    FOR EACH ROW
BEGIN
    DELETE FROM INVENTORY WHERE SKU_ID = OLD.SKU_ID;
END //

DELIMITER ;
