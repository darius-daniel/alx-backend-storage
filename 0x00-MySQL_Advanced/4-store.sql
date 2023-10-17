-- 4. Buy buy buy
-- Drop the trigger if it exists
DROP TRIGGER IF EXISTS after_order_insert;
-- Change the delimiter
DELIMITER $$
-- Create the trigger again
CREATE TRIGGER IF NOT EXISTS after_order_insert
  AFTER INSERT 
  ON orders FOR EACH ROW
BEGIN
  UPDATE items
    SET quantity = quantity - NEW.number
    WHERE name = NEW.item_name;
END $$
-- Change the delimiter back to the default
DELIMITER ;
