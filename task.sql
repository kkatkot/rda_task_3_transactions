-- Use our database
USE ShopDB; 

-- Some data should be created outside the transaction (here)
INSERT INTO Orders (CustomerID, Date) 
  VALUES (1, '2023-10-01');

INSERT INTO OrderItems (OrderID, ProductID, Count)
  VALUES (1, 1, 1);
-- Start the transaction 
START TRANSACTION; 

-- And some data should be created inside the transaction 
UPDATE Products SET WarehouseAmount = WarehouseAmount - (SELECT Count FROM OrderItems WHERE ProductId = (SELECT ProductID FROM OrderItems WHERE OrderID = 1)) 
WHERE ID = (SELECT ID FROM OrderItems WHERE ProductId = (SELECT ProductID FROM OrderItems WHERE OrderID = 1));
COMMIT; 