-- List items currently in inventory

SELECT INVENTORY.WarehouseName, Count, INVENTORY.SKU_ID, CRYSTAL.Name
FROM INVENTORY
INNER JOIN PRODUCT ON INVENTORY.SKU_ID = PRODUCT.SKU_ID
INNER JOIN CRYSTAL ON PRODUCT.CrystalID = CRYSTAL.ID
ORDER BY WarehouseName;

-- We can create new products, did when inserting data

-- Modify amount of an item in inventory
UPDATE INVENTORY
SET Count = 999
WHERE SKU_ID = 1;

-- Delete a product
DELETE FROM INVENTORY
WHERE SKU_ID = 3;



-- Once Ken creates the CustomerTransaction table, we can:
-- Get a list of the most popular products for a given time range
-- Get a list of the least popular products for a given time range
-- Get a list of users who haven't purchased something in a few months to send promotional emails to
-- This should also include products that these users normally purchase
